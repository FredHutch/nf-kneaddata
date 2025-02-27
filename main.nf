process kneaddata {
    container "${params.container}"
    input:
        tuple val(sample), path(fastq_1), path(fastq_2)
        path "_DB"

    output:
        path "${sample}/*"

    script:
    template "kneaddata.sh"
}


workflow {
    log.info"""
Nextflow Workflow: KneadData (FredHutch/nf-kneaddata)

Usage:
  --samplesheet: CSV with columns sample,fastq_1,fastq_2
  --db: Folder with reference database
  --outdir: Output directory

Optional:
  --container: Software container used (default: ${params.container})
    """

    if(!params.samplesheet) error "Must provide --samplesheet"
    if(!params.db) error "Must provide --db"
    if(!params.outdir) error "Must provide --outdir"

    // Point to the reference database
    db = file(params.db, checkIfExists: true)

    Channel
        .fromPath(params.samplesheet)
        .splitCsv(header: true)
        .map {
            [
                it.sample,
                file(it.fastq_1, checkIfExists: true),
                file(it.fastq_2, checkIfExists: true),
            ]
        }
        .set {inputs}
    
    kneaddata(inputs, db)
}