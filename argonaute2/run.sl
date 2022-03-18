#!/bin/bash
#SBATCH --job-name=pymolrun
#SBATCH --output=report_%j.out
#SBATCH --error=report_%j.err
#SBATCH --ntasks=16
#SBATCH --time=24:00:00

source /shared/work/NBD_Utilities/miniconda3/etc/profile.d/conda.sh
conda activate /shared/work/NBD_Utilities/pymol
pymol -qc schirle_macrae_2012.pml
./makemovie.sh
