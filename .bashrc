export PATH="~/bin:$PATH"
export CFLAGS="-std=c++11"

# added by Anaconda3 installer
# export PATH="/fslgroup/fslg_genome/software/anaconda3/bin:$PATH"  # commented out by conda initialize

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/fslgroup/fslg_handwriting/compute/software/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/fslgroup/fslg_handwriting/compute/software/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/fslgroup/fslg_handwriting/compute/software/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/fslgroup/fslg_handwriting/compute/software/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
