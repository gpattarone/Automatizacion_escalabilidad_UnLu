#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// ===================================================
// DNA → RNA → Protein Pipeline (Biopython Local Image)
// ===================================================

params.input = params.input ?: 'input/*.txt'

// ---------------------------------------------------
// Complement DNA
// ---------------------------------------------------
process complement {
    container 'biopython_local:latest'
    cpus 1
    memory '1 GB'
    time '10m'
    publishDir "${projectDir}/results", mode: 'copy', saveAs: { f -> "complement/${f}" }
    tag { id }

    input:
    tuple val(id), path(dna_file)
    path comp_py

    output:
    tuple val(id), path("${id}.complement.txt")

    script:
    """
    python3 $comp_py \$(cat $dna_file) > ${id}.complement.txt
    """
}

// ---------------------------------------------------
// Transcribe DNA → RNA
// ---------------------------------------------------
process transcribe {
    container 'biopython_local:latest'
    cpus 1
    memory '1 GB'
    time '10m'
    publishDir "${projectDir}/results", mode: 'copy', saveAs: { f -> "rna/${f}" }
    tag { id }

    input:
    tuple val(id), path(comp_file)
    path trans_py

    output:
    tuple val(id), path("${id}.rna.txt")

    script:
    """
    python3 $trans_py \$(cat $comp_file) > ${id}.rna.txt
    """
}

// ---------------------------------------------------
// Translate RNA → Protein
// ---------------------------------------------------
process translate {
    container 'biopython_local:latest'
    cpus 1
    memory '1 GB'
    time '10m'
    publishDir "${projectDir}/results", mode: 'copy', saveAs: { f -> "protein/${f}" }
    tag { id }

    input:
    tuple val(id), path(rna_file)
    path transl_py

    output:
    tuple val(id), path("${id}.protein.txt")

    script:
    """
    python3 $transl_py \$(cat $rna_file) > ${id}.protein.txt
    """
}

// ---------------------------------------------------
// Workflow definition
// ---------------------------------------------------
workflow {
    dna_ch = Channel
      .fromPath(params.input)
      .map { f -> tuple(f.baseName, f) }

    comp_script   = Channel.value(file("${projectDir}/scripts/complement.py"))
    trans_script  = Channel.value(file("${projectDir}/scripts/transcribe.py"))
    transl_script = Channel.value(file("${projectDir}/scripts/translate.py"))

    comp_ch = complement(dna_ch, comp_script)
    rna_ch  = transcribe(comp_ch, trans_script)
    prot_ch = translate(rna_ch, transl_script)
}
