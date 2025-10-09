params.input = 'input/dna.txt' workflow { 
complement(params.input) 
transcribe(params.input) 
translate(params.input) } 
