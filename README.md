# nf-kneaddata
Nextflow workflow used to run kneaddata

## KneadData (BioBaker)

The KneadData utility is used to preprocess metagenomic data for
microbiome analysis by removing contaminating host sequences and
running quality trimming.

![](https://huttenhower.sph.harvard.edu/wp-content/uploads/elementor/thumbs/kneaddata_workflow.drawio-pffevcxp8t0xbevc5vo6hv3zc4hlapsvv6p793lm80.png)

A selection of reference database is provided so that the appropriate
host genome can be used for decontamination.

#### Outputs

Four types of output files will be created (where $INPUTNAME is the basename of $INPUT):

1. The final file of filtered sequences after trimming

  - $OUTPUT_DIR/$INPUTNAME_kneaddata.fastq

2. The contaminant sequences from testing against a database

  - $OUTPUT_DIR/$INPUTNAME_kneaddata_$DATABASE_$SOFTWARE_contam.fastq

3. The log file from the run

  - $OUTPUT_DIR/$INPUTNAME_kneaddata.log

4. The FASTQ file of trimmed sequences

  - $OUTPUT_DIR/$INPUTNAME_kneaddata.trimmed.fastq

  - Trimmomatic is run with the following arguments by default “SLIDINGWINDOW:4:20 MINLEN:70”. The minimum length is computed as 70 percent of the length of the input reads.
