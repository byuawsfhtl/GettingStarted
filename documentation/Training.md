# Running Experiments on Super Computer

Most of our shared team research data and code can be found on the super computer under the directory: `/home/<username>/fsl_groups/fslg_handwriting`

This is treated as the home directory of our handwriting team/group, and so any data stored here will remain and won't be deleted. You will, however, want to run experiments through the `/home/blakenp/fsl_groups/fslg_handwriting/nobackup/autodelete` directory. Be aware that any data and tests in this directory will be **automatically deleted after *12 weeks***! As such, any data or test results that you would like to keep stored permanently on the super computer would have to be moved to the hwr group home directory at `/home/<username>/fsl_groups/fslg_handwriting`.

## Running Jupyter Notebooks on Super Computer
To run Juptyer notebooks and still have access to the super computer's gpu, you can create a conda environment and install the [conda jupyter package](https://anaconda.org/anaconda/jupyter).Then, navigate to the directory that holds your jupyter notebook and run the following command:

```
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser
```

Then, from your local machine, you must login to the super computer using the corresponding login node that your jupyter notebook is running on. For example, if your notebook is running on the `login01` node, you would run the following:

```
ssh -L 8888:localhost:8888 username@login01.rc.byu.edu
```

Then connect to localhost on the correct port through your local machine's browser and you should be able to code in your notebook using the super computer's resources! 🥳
