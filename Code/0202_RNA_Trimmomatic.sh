#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 05:00:00
#SBATCH -J 0202_RNA_Trimmomatics
#SBATCH --mail-user neh-eyong.langsi.0046@student.uu.se
#SBATCH --mail-type=ALL

# Load modules
module load bioinfo-tools
module load trimmomatic



# Your commands
input_path=/home/nehlang/Genom-Analysis-Project-2023/Data/02_RNA_raw_data
#output_path=/home/nehlang/Genom-Analysis-Project-2023/Analysis/Trimmomatic_RNA_output
 
trimmomatic PE -phred64 -threads 4 $input_path/ERR2036629_1.fastq.gz $input_path/ERR2036629_2.fastq.gz\
ERR2036629_FP.fastq ERR2036629_FUP.fastq\
ERR2036629_RP.fastq ERR2036629_RUP.fastq\
LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 \
ILLUMINACLIP:$TRIMMOMATICS_ROOT/TruSeq3-PE.fa:2:30:10

trimmomatic PE -phred33 -threads 30 $input_path/ERR2036630_1.fastq.gz $input_path/ERR2036630_2.fastq.gz\
ERR2036630.trimed_FP.fastq ERR2036630.trim_FUP.fastq\
ERR2036630.trim_RP.fastq ERR2036630.trim_RUP.fastq\
LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36\
ILLUMINACLIP:$TRIMMOMATICS_ROOT/adapters/TruSeq3-PE.fa:2:30:10

trimmomatic PE -phred33 -threads 30 $input_path/ERR2036631_1.fastq.gz $input_path/ERR2036631_2.fastq.gz\
ERR2036631.trimed_FP.fastq ERR2036631.trim_FUP.fastq\
ERR2036631.trim_RP.fastq ERR2036631.trim_RUP.fastq\
LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36\
ILLUMINACLIP:$TRIMMOMATICS_ROOT/adapters/TruSeq3-PE.fa:2:30:10

trimmomatic PE -phred33 -threads 30 $input_path/ERR2036632_1.fastq.gz $input_path/ERR2036632_2.fastq.gz\
ERR2036632.trimed_FP.fastq ERR2036632.trim_FUP.fastq\
ERR2036632.trim_RP.fastq ERR2036632.trim_RUP.fastq\
LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36\
ILLUMINACLIP:$TRIMMOMATICS_ROOT/TruSeq3-PE.fa:2:30:10

trimmomatic PE -phred33 -threads 30 $input_path/ERR2036633_1.fastq.gz $input_path/ERR2036633_2.fastq.gz\
ERR2036633.trimed_FP.fastq ERR2036633.trim_FUP.fastq\
ERR2036633.trim_RP.fastq ERR2036633.trim_RUP.fastq\
LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36\
ILLUMINACLIP:$TRIMMOMATICS_ROOT/TruSeq3-PE.fa:2:30:10
