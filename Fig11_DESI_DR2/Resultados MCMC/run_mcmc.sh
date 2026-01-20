#!/bin/bash
#SBATCH --job-name=desi_figure
#SBATCH --time=4-00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=7
#SBATCH --array=1-4
#SBATCH --output=/home/paulamachado/cocoa/Cocoa/projects/desi_figure/%x_%A_%a.out
#SBATCH --error=/home/paulamachado/cocoa/Cocoa/projects/desi_figure/%x_%A_%a.err
#SBATCH --mail-user=pas.machado@unesp.br
#SBATCH --mail-type=ALL

YAML=MCMC${SLURM_ARRAY_TASK_ID}.yaml

echo "Job started on $(hostname) at $(date)"
echo "Running ${YAML}"

cd /home/paulamachado/cocoa/Cocoa/projects/desi_figure || exit 1

source /home/paulamachado/miniconda3/etc/profile.d/conda.sh
conda activate cocoa

export COBAYA_PACKAGES_PATH=/home/paulamachado/cobaya_packages

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export MKL_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export OPENBLAS_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export NUMEXPR_NUM_THREADS=${SLURM_CPUS_PER_TASK}

srun cobaya-run ${YAML} -r

echo "Job ended at $(date)"
