#!/bin/bash --login
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=96
#SBATCH --mem=2000000M
#SBATCH --job-name=test
#SBATCH --time=0:01:00
#SBATCH --partition=general
#SBATCH --account=a_astro
#SBATCH -o slurm.out
#SBATCH -e slurm.error
#SBATCH --mail-user=max.charles@sydney.edu.au
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END

# Load the necessary modules
module load anaconda3
source $EBROOTANACONDA3/etc/profile.d/conda.sh

conda activate dlux

srun python /scratch/user/uqmchar4/code/asimov/scripts/dlux_test.py > allcores.txt