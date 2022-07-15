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
#SBATCH --mem-per-cpu=2000


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
mkdir $OUT_PATH

# read sample to process
export SMPLE=`head -n +${SLURM_ARRAY_TASK_ID} $IN_LIST | tail -n 1`
IFS=',' read -ra my_array <<< $SMPLE

SAMPLE_ID=${my_array[0]}
PAIR1=${my_array[1]}
PAIR2=${my_array[2]}

# run megahit
OUT_DIR=$OUT_PATH/$SAMPLE_ID
megahit -1 $PAIR1 -2 $PAIR2 -o $OUT_DIR --min-contig-len 400

# run stat script
python $SLURM_SUBMIT_DIR/scripts/stats.py -f $OUT_DIR/final.contigs.fa

# echo for log
echo "job done"; date
