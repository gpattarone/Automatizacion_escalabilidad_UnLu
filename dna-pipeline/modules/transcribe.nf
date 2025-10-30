// modules/transcribe.nf
process transcribe {
  tag { sample_id }
  publishDir "results/${sample_id}", mode: 'copy', pattern: "*.rna.txt"

  input:
  tuple val(sample_id), path(comp_file)
  path tr_py from "${projectDir}/scripts/transcribe.py"

  output:
  tuple val(sample_id), path("${sample_id}.rna.txt")
  publishDir 'results/complement', mode: 'copy'


  script:
  """
  set -euo pipefail
  python3 ${tr_py} ${comp_file} ${sample_id}.rna.txt
  """
}
