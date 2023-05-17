#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 00:30:00
#SBATCH -J ML04_annotation
#SBATCH --mail-user neh-eyong.langsi.0046@student.uu.se
#SBATCH --mail-type=ALL

#short cut to directories
#ref_1=/home/nehlang/Genom-Analysis-Project-2023/Data/2_Christel_2017/reference/OBMB01.fasta
output=/home/nehlang/Genom-Analysis-Project-2023/Analysis/ML_04_prokka

module load bioinfo-tools
module load prokka

prokka --outdir $output --proteins ML_04.faa --prefix ML_04_prokka 01_canu_dna_output.contigs.fasta --force
