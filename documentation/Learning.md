# Learning Resources

This page contains helpful links and resources for Handwriting Recognition Research. Listed are some of the concepts and tools
that you'll need to know to get started.

### Python

* Most machine/deep learning frameworks are written in Python. You need to become familiar with it. If you haven't used python before,
you're likely coming from another language that is much more difficult and Python will seem like pseudocode.
Try to find resources that use Python 3.
* These resources may be helpful:
  * [Official Python Tutorial/Documentation](https://docs.python.org/3/)
  * [W3Schools](https://www.w3schools.com/python/default.asp)

### Machine/Deep Learning Concepts

* This free [Udacity course](https://www.udacity.com/course/intro-to-tensorflow-for-deep-learning--ud187) is a great introduction
  to Machine/Deep Learning and TensorFlow. It's highly recommended if you are not very familiar with machine learning concepts.
* This is a great [visualization](http://playground.tensorflow.org/) if you are new to the concept of neural networks.
* Concepts you probably need to become familiar with:
  * Neural Networks
  * Back-Propagation/Gradient Descent
  * Tensors and their role in deep learning
  * Deep Learning Model Layers:
    * Fully-Connected/Dense
    * Convolutions
    * Recurrent Units (LSTM/GRU)
  * Activation Functions:
    * ReLU
    * Sigmoid
    * Softmax
  * Loss Functions:
    * NegativeLogLikelihood
    * CrossEntropyLoss
    * MeanSquaredError
  * Optimizers
    * Adam
    * SGD
  * Training Concepts:
    * Dataset Splits (train/validation/test)
    * Learning Rates
    * Mini-batches
    * Epochs

### TensorFlow

* We try to use TensorFlow 2 if possible for our models. There are some pretty major differences between TF1 and TF2.
  Many tutorials you find will use TF1, but try to find resources on TF2 if at all possible.
* Google Colab
  * [Colab](https://colab.research.google.com/) is a free service provided by Google that gives free access to GPUs
    You simply login with your Google account and then you can run Python code in a Jupyter notebook. Many tutorials from
	  Google or other resources in this documentation will link to colab and will allow you to run the code yourself.
* TensorFlow Getting Started Pages:
  * [Beginner](https://www.tensorflow.org/tutorials/quickstart/beginner)
  * [Advanced](https://www.tensorflow.org/tutorials/quickstart/advanced)
* Official Documentation
  * TensorFlow has pretty good [documentation](https://www.tensorflow.org/api_docs/python/) with guides and tutorials.
  * For actually building models in TensorFlow, you will likely use the high-level API,
    [Keras](https://www.tensorflow.org/guide/keras/overview) for most of your work.
  
### Anaconda

* Conda is a package manager that we use on the supercomputer to manage our program dependencies.
    * [Getting Started Guide](https://docs.conda.io/projects/conda/en/latest/user-guide/getting-started.html#)
* Supercomputer
  * Run the script "Anaconda3-2019.03-Linux-x86_64.sh" in the fsl_groups/fslg_handwriting/compute directory
    on the supercomputer. This will setup anaconda in /fslhome/<YOUR_USERNAME>/anaconda
  * To turn on Conda for subsequent logins to the supercomputer, run the following command:
    * ```eval "$(/fslhome/<YOUR_USERNAME>/anaconda3/bin/conda shell.bash hook)"```
    * This will activate conda and allow you to activate various environments and install packages.

### Running Jobs on the Supercomputer

* [General Batch Information](https://rc.byu.edu/wiki/?id=General+Batch+Information)
* [SLURM Commands](https://rc.byu.edu/wiki/?id=SLURM+Commands)
* [Job Script Generator](https://rc.byu.edu/documentation/slurm/script-generator)

## Handwriting Specific Resources

### Most Auto-Indexing Projects can be broken down into a couple steps:

* Segmentation (what portion of the document do we care about, usually this involves segmenting lines of handwritten text)
* Handwriting Recognition (actually recognizing what the handwritten text is saying)
* Named-Entity-Recognition (extracting useful information from unstructured text such as names, dates, and places)

### Available Colab Notebooks to use for reference:

* Record Segmentation
  * Uses the Matterport implementation of MaskRCNN to segment individual records. You may need to download
    datasets from the supercomputer to get this to work.
  * [Colab Notebook](https://github.com/ericburdett/record_detection/blob/master/record_detection.ipynb)
* Handwriting Recognition
  * Basic Handwriting Recognition Model used on the IAM and RIMES datasets. You may need to download datasets
    from the supercomputer to get this to work.
  * [Colab Notebook](https://github.com/ericburdett/hwr/blob/master/notebook-tf.ipynb)
* Named-Entity-Recognition
  * Basic Named Entity Recognition Model used on the Esposalles dataset. This is the most complete of all the
    notebooks, and should work without any other downloads required. You should start here for a quick and easy
    example of using TensorFlow 2.
  * [Colab Notebook](https://github.com/ericburdett/named-entity-recognition/blob/master/notebook.ipynb)

### Handwriting Recognition Academic Papers:

* [Gated Convolutional Recurrent Neural Networks for Multilingual Handwriting Recognition](https://ieeexplore-ieee-org.erl.lib.byu.edu/document/8270042)
* [Are Multidimensional Recurrent Layers Really Necessary for Handwritten Text Recognition?](http://www.jpuigcerver.net/pubs/jpuigcerver_icdar2017.pdf)
* [Start-Follow-Read: End-to-End Full-Page Handwriting Recognition](http://openaccess.thecvf.com/content_ECCV_2018/papers/Curtis_Wigington_Start_Follow_Read_ECCV_2018_paper.pdf)
