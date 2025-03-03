#!/bin/bash
source .env

wget -P $oma_dir https://omabrowser.org/media/markers/marker_genes_04a14bb95a970775cfbf373047392c03.tgz
tar -xvzf ${oma_dir}/*.tgz -C $oma_dir
rm -rf ${oma_dir}/*.tgz
mv ${oma_dir}/marker_genes/* $oma_dir
rm -rf ${oma_dir}/marker_genes
