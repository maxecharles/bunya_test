#!/bin/bash --login
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=2000000M
#SBATCH --job-name=test
#SBATCH --time=0:01:00
#SBATCH --partition=general
#SBATCH --account=a_astro
#SBATCH -o slurm.out
#SBATCH -e slurm.error

# Load the necessary modules
module load miniconda3/23.9.0-0
source $EBROOTANACONDA3/etc/profile.d/conda.sh

conda activate dLux

srun /scratch/user/uqldesdo/max/repos/bunya_test/printing.py > output.txt