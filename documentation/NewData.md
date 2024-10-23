# Testing and Training Data
While most of the handwriting data we utilize will belong to a public dataset (IAM, Bentham, etc.), you may need to create or find your own truthy data so that the network can learn to segment, recognize, or classify correctly.

This documentation contains procedures for manual truthy data creation.

## Data Collection Via *AWS Textract*
Another option for collecting\labeling training data for the LineSegmentation model was recently found through a method where we can use *AWS Textract* to make labeling the data easier for us. 

*Textract* uses OCR techniques to drawing bounding/boxes around each line of text. This could potentially speed up the labeling process when combining the outputted bounding boxes with a python script that creates white baselines over a black background. While these white baselines aren't perfect, it's easy to use software like *Microsoft Paint* or *GIMP Studio* to correct the baselines. 

*AWS Textract* normally takes in batches of 150 images at a time, then outputs a zip file you can download with the json data of the bounding boxes for each image. One can simply use a script to batch images into 150 sized batches and separate them into files, allowing us to upload these files to an s3 bucket on AWS.

Below is an example of a python script you could use for doing this:

```python
import os
import shutil
import time
import argparse
from datetime import datetime

def main(directory_path, batch_size):
    file_name = directory_path.split('/')[-1]
    contents = [os.path.join(directory_path, item) for item in os.listdir(directory_path)]
    n = len(contents)

    batch_start = 0
    batch_end = batch_size
    count = 1

    start_time = time.time()
    while n > batch_start:
        timestamp = datetime.now().strftime("%m_%d_%I:%M%p_%Y")
        new_directory_path = f"{file_name}:{timestamp}:{count}" 
        os.mkdir(new_directory_path)
        for i in range(batch_start, batch_end):
            shutil.copy(contents[i], new_directory_path)

        batch_start = batch_end
        if n - batch_end > batch_size:
            batch_end += batch_size
        else:
            batch_end += n - batch_end

        count += 1

    end_time = time.time()
    time_to_run = end_time - start_time
    print(f"Finished batching data in {time_to_run:.2f} seconds")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Batch copy files into directories")
    parser.add_argument("directory_path", type=str, help="Path to directory you want to partition into batches")
    parser.add_argument("--batch_size", type=int, default=150, help="Number of files per batch (default=150)")

    args = parser.parse_args()
    main(args.directory_path, args.batch_size)
```

In addition to this, one can run the script `textract_create_baselines.py` in the [LineSegmentation Repo](https://github.com/byuawsfhtl/LineSegmentation/blob/augmentor/textract_create_baselines.py) to output a new image with the white baselines drawn over a black background. Below is the full script for doing this:

```python
import json
import os
from PIL import Image, ImageDraw
import argparse

# Function to process the JSON file and filter out lines
def filter_lines(json_data):
    lines = []
    for block in json_data['Blocks']:
        if block['BlockType'] == 'LINE':
            polygon = block['Geometry']['Polygon']
            lines.append({'polygon': polygon})
    return lines

# Function to create the ground truth image with white baselines on black background
def draw_gt(image_size, lines, output_path, offset):
    gt_img = Image.new('1', image_size, 0)  # Create a new binary image with black background
    draw = ImageDraw.Draw(gt_img)

    for line in lines:
        polygon = [(point['X'] * image_size[0], point['Y'] * image_size[1]) for point in line['polygon']]
        midpoints = [( (polygon[i][0] + polygon[-(i + 1)][0]) / 2,
                       (polygon[i][1] + polygon[-(i + 1)][1]) / 2 + offset) for i in range(len(polygon) // 2)]
        midpoints = sorted(midpoints, key=lambda x: x[0])
        draw.line(midpoints, fill=1, width=8)  # Draw white lines on the binary image

    gt_img.save(output_path)

# Function to create the overlay image with red baselines on the original image
def draw_overlay(img, lines, output_path, offset):
    overlay_img = img.copy().convert("RGBA")
    draw = ImageDraw.Draw(overlay_img)

    for line in lines:
        polygon = [(point['X'] * img.width, point['Y'] * img.height) for point in line['polygon']]
        midpoints = [( (polygon[i][0] + polygon[-(i + 1)][0]) / 2,
                       (polygon[i][1] + polygon[-(i + 1)][1]) / 2 + offset) for i in range(len(polygon) // 2)]
        midpoints = sorted(midpoints, key=lambda x: x[0])
        draw.line(midpoints, fill=(255, 0, 0, 255), width=8)  # Draw red lines with full opacity

    # Convert the image to RGB mode before saving as JPEG
    overlay_img = overlay_img.convert("RGB")
    overlay_img.save(output_path)

def process_directory(input_dir, json_dir, output_dir, overlay_output_dir=None, offset=20):
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    if overlay_output_dir and not os.path.exists(overlay_output_dir):
        os.makedirs(overlay_output_dir)

    for image_name in os.listdir(input_dir):
        if image_name.lower().endswith(('.png', '.jpg', '.jpeg')):
            image_path = os.path.join(input_dir, image_name)
            json_path = os.path.join(json_dir, os.path.splitext(image_name)[0], "analyzeDocResponse.json")
            gt_output_path = os.path.join(output_dir, image_name)

            if os.path.exists(json_path):
                with open(json_path, 'r') as f:
                    json_data = json.load(f)

                lines = filter_lines(json_data)
                img = Image.open(image_path).convert("RGBA")
                
                # Create the ground truth image
                draw_gt(img.size, lines, gt_output_path, offset)

                # Create the overlay image if the directory is specified
                if overlay_output_dir:
                    overlay_output_path = os.path.join(overlay_output_dir, image_name)
                    draw_overlay(img, lines, overlay_output_path, offset)
            else:
                print(f"JSON file for {image_name} not found at {json_path}")

def main():
    parser = argparse.ArgumentParser(description="Create binary images with baselines based on JSON data.")
    parser.add_argument("input_dir", help="Path to the directory containing input image files")
    parser.add_argument("json_dir", help="Path to the directory containing JSON files")
    parser.add_argument("output_dir", help="Path to the directory where processed image files will be saved")
    parser.add_argument("--overlay_output_dir", help="Directory to save overlay images")
    parser.add_argument("--offset", type=int, default=20, help="Offset to apply to the Y-coordinate of the baseline")

    args = parser.parse_args()

    process_directory(args.input_dir, args.json_dir, args.output_dir, args.overlay_output_dir, args.offset)

if __name__ == "__main__":
    main()
```

After running this script over the directory containing all json files and the input directory containing the original images, you will output a new directory with the new ground truth baselines. Then, you just need to manually correct the baselines using software like *GIMP*, etc.