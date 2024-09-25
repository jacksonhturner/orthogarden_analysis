#!/bin/bash
source .env

cat worst_parallel_read2tree.txt | parallel -j 10
cat best_parallel_read2tree.txt | parallel -j 10
