// complement.nf
//
// Process: complement
// Description: Computes the DNA complement using a Python script.
//

process complement {

    input:
        path dna_file

    output:
        stdout into comp_out
        publishDir 'results/complement', mode: 'copy'


    script:
        """
        python3 scripts/complement.py \$(cat ${dna_file})
        """
}
