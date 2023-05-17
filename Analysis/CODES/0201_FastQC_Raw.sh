#Running FastQc on RNA raw data to check data qulity 
#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 05:00:00
#SBATCH -J 0201_RNA_Raw_FastQC
#SBATCH --mail-user neh-eyong.langsi.0046@student.uu.se
#SBATCH --mail-type=ALL


# runing fastqc on untrimmed raw rna reads data

input_file=/proj/genomeanalysis2023/Genome_Analysis/2_Christel_2017/RNA_raw_data
output_files=/home/nehlang/Genom-Analysis-Project-2023/Analysis/Fastqc_Rna_raw
# loading modules
module load bioinfo-tools FastQC

fastqc -t 2 $input_file/* $output_files/*
