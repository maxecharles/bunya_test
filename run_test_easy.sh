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
#SBATCH --mail-user=max.charles@sydney.edu.au
#SBATCH --mail-type=BEGIN,END

# Load the necessary modules
module load anaconda3/23.9.0-0
source $EBROOTANACONDA3/etc/profile.d/conda.sh

# Activate conda environment
conda activate

# Execute your Python script
srun /scratch/user/uqldesdo/max/repos/bunya_test/printing_easy.py > output.txt
