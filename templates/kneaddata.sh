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
    --threads 1 \
    --output-prefix "${sample}" \
    --log-level INFO \
    --sequencer-source "${params.sequencer_source}" \
    --decontaminate-pairs "${params.decontaminate_pairs}" \
    --run-fastqc-start \
    --run-fastqc-end \
    --remove-intermediate-output \
    --reorder \
    ${params.kneaddata_params}

# Make sure to compress the outputs
find . -name '*.fastq' | while read fastq; do
    echo "\$(date) Compressing \$fastq"
    gzip "\$fastq"
done

ls -lah "${sample}/"
