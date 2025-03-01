#!/bin/bash

set -eu

echo "\$(date) Running KneadData"
echo "\$(date) Sample: ${sample}"
echo "\$(date) FASTQ 1: ${fastq_1}"
echo "\$(date) FASTQ 2: ${fastq_2}"

kneaddata \
    --input1 "${fastq_1}" \
    --input2 "${fastq_2}" \
    --reference-db _DB \
    --output "${sample}" \
    --threads ${task.cpus} \
    --output-prefix "${sample}" \
    --log-level INFO \
    --sequencer-source "${params.sequencer_source}" \
    --decontaminate-pairs "${params.decontaminate_pairs}" \
    --reorder \
    ${params.kneaddata_params}

# Make sure to compress the outputs
echo "\$(date) Compressing outputs"
gzip "${sample}/*fastq"

echo "\$(date) Done"

ls -lah "${sample}/"
