#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 05:00:00
#SBATCH -J 0203_RNA_Trimmed_FastQC
#SBATCH --mail-user neh-eyong.langsi.0046@student.uu.se
#SBATCH --mail-type=ALL


# runing fastqc on Trimmed Raw Rna reads data

input_file="/home/nehlang/Genom-Analysis-Project-2023/Analysis/Trimmomatic_RNA_output"
output_files=/home/nehlang/Genom-Analysis-Project-2023/Analysis/FastQC_Trimmed
# loading modules
module load bioinfo-tools FastQC

fastqc -t 2 ${input_file}/* -o ${output_files}/
