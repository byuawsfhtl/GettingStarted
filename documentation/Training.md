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

### Running Jupyter Notebooks Using GPUs
The above will allow you to run notebooks on the supercomputer only using the super computer's CPU. In order to access the GPU nodes, you must set up a bash script that allows you to submit a job via `slurm` and request access to a number of gpus in this way.
Below is an example of a script that requests access to 3 gpus for 4 hours:

```bash
#!/bin/bash

#SBATCH --time=04:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=500G   # memory per CPU core
#SBATCH -J "Unsupervised HWR Research"   # job name
#SBATCH --gpus=3
#SBATCH --qos=standby

# Set the max number of threads to use for programs using OpenMP. Should be <= ppn. Does nothing if the program do$export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
module load miniconda3
source ~/.bashrc
conda activate blakenp

cur_dir=$(pwd)
cd ~/nobackup/autodelete/notebooks
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser
# /home/blakenp/.conda/envs/blakenp/bin/python train.py train_config.yaml
```

Once you have this script, run the following commands to submit the job and view the details of the running job (including the gpu compute node you need to create an ssh tunnel to in order to access the jupyter notebook on localhost in a browser).

```
sbatch run_notebook.sh --qos=cs
```
*The above submits the slurm job you want to run using the script you just defined*

```
tail slurm-<job-id>.out
```
*The above will show you the last couple lines of output for you job once it is running.*

You will want to look at the output of the `tail` command to see the id for the gpu node you must create an ssh tunnel to. It can be like this for example:

```
http://dw-1-5:8888/lab?token=abc123...
```

Thus, you would run the following command to connect to the gpu compute node **dw-1-5** for example to access the notebook in a browser that can use the gpus allotted to you:

```
ssh -L 8888:localhost:8888 dw-1-5
```

Then, open up **localhost:8888** and you should have access to your notebook and the gpus you requested to run the job. Yay! 🥳

#### Cancelling a Slurm Job
To cancel a slurm job for your notebook when you don't need to use the gpus anymore, please cancel as soon as you can so that others can use the gpus you no longer need. To do this, simply run the following command:

```
scancel <slurm-job-id>
```