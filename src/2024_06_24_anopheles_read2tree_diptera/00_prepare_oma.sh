#!/bin/bash
source .env

wget -P $oma_dir https://omabrowser.org/media/markers/marker_genes_5b0cd270d1111d0e91cc57f3b2e91fd2.tgz
tar -xvzf ${oma_dir}/*.tgz -C $oma_dir
rm -rf ${oma_dir}/*.tgz
mv ${oma_dir}/marker_genes/* $oma_dir
rm -rf ${oma_dir}/marker_genes
