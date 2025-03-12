nextflow run /pickett_centaur/project/Moulton_JHT/orthogarden_all/orthogarden/main.nf \
  --input metadata.csv \
  --publish_dir henckelia_OG/ \
  --threshold_val 0.75 \
  --masking_threshold 0.4 \
  -profile local,eight \
  -resume
