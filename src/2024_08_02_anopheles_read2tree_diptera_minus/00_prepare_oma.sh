#!/bin/bash
source .env

wget -P $oma_dir https://omabrowser.org/media/markers/marker_genes_a88dcfb04d92bf89efa1f457d99c370c.tgz
tar -xvzf ${oma_dir}/*.tgz -C $oma_dir
rm -rf ${oma_dir}/*.tgz
mv ${oma_dir}/marker_genes/* $oma_dir
rm -rf ${oma_dir}/marker_genes
