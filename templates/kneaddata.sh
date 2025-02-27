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
    --output "${sample}"
