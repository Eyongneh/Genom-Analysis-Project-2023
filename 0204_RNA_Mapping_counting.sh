#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 15:00:00
#SBATCH -J mapping_jobS.sh
#SBATCH  --mail-user neh-eyong.langsi.0046@student.uu.se
#SBATCH  --mail-type=ALL

#Define variable
INPUT_FILE=/home/nehlang/Genom-Analysis-Project-2023/Analysis/Trimmomatic_RNA_output
REFERENCE=/home/nehlang/Genom-Analysis-Project-2023/Analysis/canu_L_Ferri_comEdited.contigs.fasta
OUTPUT_FILE=/home/nehlang/Genom-Analysis-Project-2023/Analysis/0204_RNA_Mapping
ANNOTATION_FILE=/home/nehlang/Genom-Analysis-Project-2023/Analysis

# Load modules
module load bioinfo-tools  bamtools/2.5.1 samtools/1.17 htseq/2.0.2 bwa/0.7.17

#Now we do the mapping and counting
for SAMPLE in ERR2036629 ERR2036630 ERR2036631 ERR2036632 ERR2036633
do
    #Index the genome assembly
    bwa index $REFERENCE
    #Map the reads
    bwa mem $REFERENCE $INPUT_FILE/${SAMPLE}_1P.fq.gz $INPUT_FILE/${SAMPLE}_2P.fq.gz | samtools sort -o ${SAMPLE}.bam -
    #Index the sorted alignments to improve search speed
    samtools index ${SAMPLE}.bam
    #Count features
    htseq-count --format=bam --stranded=reverse --type=CDS --order=pos --idattr=ID ${SAMPLE}.bam $ANNOTATION_FILE/03_prokkamodified_L_ferri.gff > ${SAMPLE}_htseq_counts.txt
done
