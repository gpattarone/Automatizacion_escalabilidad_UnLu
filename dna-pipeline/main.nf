// main.nf
//
// DNA Processing Pipeline
// Steps: Complement → Transcribe → Translate
//

nextflow.enable.dsl = 2

// Input parameter
params.input = file('input/dna.txt')

// Load processes
include { complement } from './complement.nf'
include { transcribe } from './transcribe.nf'
include { translate } from './translate.nf'

// Define workflow
workflow {

    // Create initial channel from input file
    dna_ch = Channel.fromPath(params.input)

    // Sequential execution
    complement(dna_ch)
    transcribe(comp_out)
    translate(rna_out)
}
