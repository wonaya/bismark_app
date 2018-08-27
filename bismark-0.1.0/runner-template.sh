# Import Agave runtime extensions
. _lib/extend-runtime.sh

# Allow CONTAINER_IMAGE over-ride via local file
if [ -z "${CONTAINER_IMAGE}" ]
then
    if [ -f "./_lib/CONTAINER_IMAGE" ]; then
        CONTAINER_IMAGE=$(cat ./_lib/CONTAINER_IMAGE)
    fi
    if [ -z "${CONTAINER_IMAGE}" ]; then
        echo "CONTAINER_IMAGE was not set via the app or CONTAINER_IMAGE file"
        CONTAINER_IMAGE="cyverse/base:ubuntu17"
    fi
fi


#input
FASTQ1=${fastq1}
FASTQ2=${fastq2}
GENOME_FOLDER=${genome_folder}
PAIRED=${paired}
MISMATCHES=${mismatches}
SEED_LEN=${seed_len}
FASTQ1_F=$(basename ${FASTQ1})
if [ "${PAIRED}" -eq 1 ]; then FASTQ2_F=$(basename ${FASTQ2}); fi
ARGS=""
#if [ ${MISMATCHES} != 0 ]; then ARGS="${ARGS} -N ${MISMATCHES} "; fi
#if [ ${SEED_LEN} -ne 20  ]; then ARGS="${ARGS} -L ${SEED_LEN} "; fi
ARGS="${ARGS} ${SEED_LEN} ${MISMATCHES} ";

# Build up an ARGS string for the program
if [ "${PAIRED}" -eq 1 ]; then ARGS="${ARGS} -1 ${FASTQ1_F} -2 ${FASTQ2_F} "; fi
if [ "${PAIRED}" -eq 0 ]; then ARGS="${ARGS} --single_end ${FASTQ1_F} "; fi

# Usage: container_exec IMAGE COMMAND OPTIONS
#   Example: docker run centos:7 uname -a
#            container_exec centos:7 uname -a


echo container_exec ${CONTAINER_IMAGE} bismark -p 16 ${GENOME_FOLDER} ${FASTQ1_F}
container_exec ${CONTAINER_IMAGE} bismark -p 16 ${GENOME_FOLDER} ${FASTQ1_F}

# echo "bismark --genome_folder ${GENOME_FOLDER} ${FASTQ1_F}"
# # Run the actual program
# bismark -p 16 ${GENOME_FOLDER} ${FASTQ1_F}

# Clean up
# rm -Rf ${FASTQ1_F} ${GENOME_FOLDER}
# if [ ${PAIRED} -eq 1 ]; then rm -Rf ${FASTQ2_F} ; fi
