#!/bin/bash

#SBATCH -J bismakr-api
#SBATCH -o bismark.%j.out
#SBATCH -e bismark.%j.err
#SBATCH -p serial
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -t 03:00:00
#SBATCH -A iPlant-Collabs
#SBATCH --mail-user=jawon@tacc.utexas.edu
#SBATCH --mail-type=end

# module part
module load bowtie/2.3.2
module load samtools
chmod a+rx bismark 
export PATH=$PATH:"$PWD"

#input
FASTQ1=$PWD/SRR1333851.fastq
FASTQ2=
GENOME_FOLDER=/work/02114/wonaya/iplant/tmp/
PAIRED=0
MISMATCHES=0
SEED_LEN=20

FASTQ1_F=$(basename ${FASTQ1})
FASTQ2_F=$(basename ${FASTQ2})

#ARGS=" -N ${MISMATCHES} -L ${SEED_LEN} "
if [ ${MISMATCHES} != 0 ]; then ARGS="${ARGS} -N ${MISMATCHES} "; fi
if [ ${SEED_LEN} -ne ""   ]; then ARGS="${ARGS} -L ${SEED_LEN} "; fi
# Build up an ARGS string for the program
echo ${PAIRED}
if [ ${PAIRED} -eq 1 ]; then ARGS="${ARGS} -1 ${FASTQ1_F}-2 ${FASTQ2_F} "; fi
if [ ${PAIRED} -eq 0 ]; then ARGS="${ARGS} --single_end ${FASTQ1_F} "; fi

# Run the actual program
bismark --parallel 16 -p 4 $GENOME_FOLDER ${ARGS}

