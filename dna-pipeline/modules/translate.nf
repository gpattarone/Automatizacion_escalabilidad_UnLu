// translate.nf
//
// Process: translate
// Description: Translates DNA to protein using a Python script.
//

process translate {

    input:
        path dna_file

    output:
        stdout into prot_out
        publishDir 'results/complement', mode: 'copy'


    script:
        """
        python3 scripts/translate.py \$(cat ${dna_file})
        """
}
