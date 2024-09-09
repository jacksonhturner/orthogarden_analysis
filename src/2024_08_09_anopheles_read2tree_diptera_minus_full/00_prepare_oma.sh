#!/bin/bash
source .env

wget -P $oma_dir https://omabrowser.org/media/markers/marker_genes_1848a559dac2c330b03c314ffa3f7e85.tgz
tar -xvzf ${oma_dir}/*.tgz -C $oma_dir
rm -rf ${oma_dir}/*.tgz
mv ${oma_dir}/marker_genes/* $oma_dir
rm -rf ${oma_dir}/marker_genes
