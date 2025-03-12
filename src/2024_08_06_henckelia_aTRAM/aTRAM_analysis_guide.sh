#!/usr/bin/env bash
#eval "$(conda shell.bash hook)"

# conda env create --file=../phylogenomics.yml --name phylogenomics
#conda activate phylogenomics

source config

# Trimming paired end reads
#rm run_all.txt
for FILE_DIR in $(find $READS_DIR -mindepth 1 -type d); do
    BASE=$(basename $FILE_DIR)
    echo "trimmomatic PE $FILE_DIR/${BASE}_1.fastq.gz $FILE_DIR/${BASE}_2.fastq.gz $FILE_DIR/${BASE}_1_paired.fastq.gz $FILE_DIR/${BASE}_1_unpaired.fastq.gz $FILE_DIR/${BASE}_2_paired.fastq.gz $FILE_DIR/${BASE}_2_unpaired.fastq.gz ILLUMINACLIP:/pickett_centaur/software/Trimmomatic-0.39/adapters/all.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:25;" >> run_all.txt
done

# Building aTRAM shard database using trimmed paired end reads
rm run_all.txt
for FILE_DIR in $(find $READS_DIR -mindepth 1 -type d); do
    BASE=$(basename $FILE_DIR)
    echo "python3 /pickett_centaur/software/aTRAM_2/aTRAM/atram_preprocessor.py" \
         "--blast-db=${ATRAM_LIB}" \
         "--end-1=$FILE_DIR/${BASE}_1.fasta" \
         "--end-2=$FILE_DIR/${BASE}_2.fasta" \
         "--fasta" >> run_all.txt
done

# Assembly generation
rm run_all.txt
for FILE_DIR in $(find $READS_DIR -mindepth 1 -type d); do
    BASE=$(basename $FILE_DIR)
    echo "python3 /pickett_centaur/software/aTRAM/atram.py" \
         "--blast-db=${ATRAM_LIB}" \
         "-Q=${ATRAM_REF}" \
         "--protein" \
         "--assembler=velvet" \
         "-o=${ATRAM_OUT}/$BASE" >> run_all.txt
done

# Stitching assemblies into assembled genes
rm run_all.txt
cp ${ATRAM_OUT}/*/*.filtered_contigs.fasta $ATRAM_STITCH
for FILE_DIR in ${find $READS_DIR -mindepth 1 -type d); do
    BASE=$(basename $FILE_DIR)
    echo $BASE >> taxa_list.txt
done

echo "python3 /pickett_centaur/software/aTRAM/atram_stitcher.py --assemblies=${ATRAM_STITCH} --reference-genes=${ATRAM_REF} --taxa=taxa_list.fasta -o ${STITCHED_DIR}" >> run_all.txt

# Translating assembled genes
rm run_all.txt
for FILE in $(find $NUCL_SEQS -mindepth 1); do
    echo "seqkit translate $FILE > ${AA_SEQS}" >> run_all.txt
done

# Aligning translated assembled genes using PASTA
rm run_all.txt
for FILE in ${find $AA_SEQS -mindepth 1); do 
    echo "sed 's/*/N/g' $FILE > tmp && mv tmp $FILE" >> run_all.txt
done
rm run_all.txt
for FILE in $(find $AA_SEQS -mindepth 1); do
    echo "mafft $FILE > ${ALIGNED_AA}" >> run_all.txt
done

# Mapping nucleotide sequences to aligned translated assembled genes using TranslatorX
rm run_all.txt
for FILE in $(find $ALIGNED_AA -mindepth 1); do
    echo "cp $FILE > ${ALIGNED_NUCL_IN}" >> run_all.txt
done
rm run_all.txt
for FILE in $(find $ALIGNED_NUCL_IN -mindepth 1); do
    echo "mv $FILE ${FILE%%.fasta}.aln" >> run_all.txt
done
rm run_all.txt
for FILE in $(find $NUCL_SEQS -mindepth 1); do
    echo "cp $FILE ${ALIGNED_NUCL_IN}" >> run_all.txt
done
rm run_all.txt
for FILE in $(find $ALIGNED_NUCL_IN/*.aln -mindepth 1); do
    echo "python ryanscript.py $FILE ${FILE%%.aln}.fasta ${ALIGNED_NUCL_OUT}" >> run_all.txt
done

# Masking with Trimal
rm run_all.txt
for FILE in $(find $ALIGNED_NUCL_OUT -mindepth 1); do
    echo "trimal -in $FILE -out ${ALIGNED_MASKED} -gt .4" >> run_all.txt
done

# Removing third codon positions using Ryan Kuster's python script
rm run_all.txt
for FILE in $(find $ALIGNED_MASKED -mindepth 1); do
    echo "python3 pull_third_pos.py $FILE ${THIRDS_REMOVED}" >> run_all.txt
done

# Generating ML phylogeny using iqtree2
echo "iqtree2 -p ${THIRDS_REMOVED} -m MFP+MERGE -B 1000 -rcluster 10 -bnni -nt AUTO" >> run_all.txt
rm run_all.txt
