nextflow run /pickett_centaur/project/Moulton_JHT/orthogarden_all/orthogarden \
  --input 2_10_25_metadata.csv \
  --publish_dir 2_10_25_output/ \
  --threshold_val 0.6 \
  --masking_threshold 0.4 \
  --kraken_db /pickett_centaur/databases/k2_pluspf_20230314 \
  -profile local,eight \
  -resume
