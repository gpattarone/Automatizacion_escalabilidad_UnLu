// transcribe.nf
//
// Process: transcribe
// Description: Transcribes DNA to RNA using a Python script.
//

process transcribe {

    input:
        path dna_file

    output:
        stdout into rna_out

    script:
        """
        python3 scripts/transcribe.py \$(cat ${dna_file})
        """
}
