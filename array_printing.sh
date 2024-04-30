#!/bin/bash --login
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=2000000M
#SBATCH --job-name=array_test
#SBATCH --time=0:01:00
#SBATCH --partition=general
#SBATCH --account=a_astro
#SBATCH -o outputs/slurm.out
#SBATCH -e outputs/slurm.error
#SBATCH --mail-user=max.charles@uq.edu.au
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --array=0-9

# Load the necessary modules
module load anaconda3
source $EBROOTANACONDA3/etc/profile.d/conda.sh

# Activate conda environment
conda activate dlux

# Execute your Python script
srun python /scratch/user/uqmchar4/code/bunya_test/scripts/printing.py $SLURM_ARRAY_TASK_ID > outputs/print_$SLURM_ARRAY_TASK_ID.txt
