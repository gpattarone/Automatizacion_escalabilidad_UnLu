// main.nf
// DNA Processing Pipeline: Complement → Transcribe → Translate

nextflow.enable.dsl = 2

// Parámetro de entrada
params.input = file('input/dna.txt')

// Import de procesos desde la carpeta modules/
include { complement } from './modules/complement.nf'
include { transcribe } from './modules/transcribe.nf'
include { translate  } from './modules/translate.nf'

workflow {

    // Canal inicial a partir del archivo de entrada
    Channel.fromPath(params.input).set { dna_ch }

    // Encadenamiento de procesos con variables explícitas
    comp_out = complement(dna_ch)
    rna_out  = transcribe(comp_out)
    prot_out = translate(rna_out)

    // Mostrar salida final (opcional)
    prot_out.view { "Protein: $it" }
}
