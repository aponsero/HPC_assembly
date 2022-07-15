#!/bin/bash -l
#SBATCH --job-name=qc_humanfilt
#SBATCH --account=
#SBATCH --output=errout/outputr%j.txt
#SBATCH --error=errout/errors_%j.txt
#SBATCH --partition=small
#SBATCH --time=12:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=40
#SBATCH --mem-per-cpu=1000


# load job configuration
cd $SLURM_SUBMIT_DIR
source config/config.sh

# load environment
source $CONDA/etc/profile.d/conda.sh
conda activate assembly 

# echo for log
echo "job started"; hostname; date

# go to folder
cd $IN_DIR 

# read sample to process
export SMPLE=`head -n +${SLURM_ARRAY_TASK_ID} $IN_LIST | tail -n 1`
IFS=',' read -ra my_array <<< $SMPLE

SAMPLE_ID=${my_array[0]}
PAIR1=${my_array[1]}
PAIR2=${my_array[2]}

# get coverage info
bbwrap.sh ref=assembly/${SAMPLE_ID}_megahit.fa in=$PAIR1 in2=$PAIR2 out=assembly/${SAMPLE_ID}_aln.sam.gz kfilter=22 subfilter=15 maxindel=80 nodisk

# coverage log
pileup.sh in=assembly/${SAMPLE_ID}_aln.sam.gz out=assembly/${SAMPLE_ID}_cov.txt

rm assembly/${SAMPLE_ID}_aln.sam.gz


echo "job done"; date
