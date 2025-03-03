#!/bin/bash
source .env

cat parallel_read2tree.txt | parallel -j 20
