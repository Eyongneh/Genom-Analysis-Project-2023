#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J mum_job.sh
#SBATCH  --mail-user  neh-eyong.langsi.0046@student.uu.se
#SBATCH  --mail-type=ALL

module load bioinfo-tools  MUMmer/4.0.0rc1


INPUT_FILE=/home/nehlang/Genom-Analysis-Project-2023/Code
REF=/home/nehlang/Genom-Analysis-Project-2023/Data/2_Christel_2017/reference
OUTPUT_FILE=/home/nehlang/Genom-Analysis-Project-2023/Analysis

mummer -mum -b -c ${INPUT_FILE}/canu_L_Ferri_combined.contigs.fasta ${REF}/OBMB01.fasta > 07_mumerplot
mummerplot -x "[0,3179422]" -y "[0,2919198]" -png -p mummer 07_mumerplot
