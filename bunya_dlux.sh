#!/bin/bash --login
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=96
#SBATCH --mem=2000000M
#SBATCH --job-name=test
#SBATCH --time=1:00:00
#SBATCH --partition=general
#SBATCH --account=a_astro
#SBATCH -o slurm.out
#SBATCH -e slurm.error

# Load the necessary modules
module load anaconda3/2022.05
source $EBROOTANACONDA3/etc/profile.d/conda.sh

conda activate dLux

srun /scratch/user/uqbpope/code/asimov/scripts/dlux_test.py > allcores.txt