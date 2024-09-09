#!/bin/bash
source .env

wget -P $oma_dir https://omabrowser.org/media/markers/marker_genes_213a4fa40e33ddf7935fffeb9fca0f10.tgz
tar -xvzf ${oma_dir}/*.tgz -C $oma_dir
rm -rf ${oma_dir}/*.tgz
mv ${oma_dir}/marker_genes/* $oma_dir
rm -rf ${oma_dir}/marker_genes
