#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 00:30:00
#SBATCH -J 03_canu_assembly_annotation
#SBATCH --mail-user neh-eyong.langsi.0046@student.uu.se
#SBATCH --mail-type=ALL

#short cut to directories
ref_1=/home/nehlang/Genom-Analysis-Project-2023/Data/2_Christel_2017/reference/OBMB01.fasta
output=/home/nehlang/Genom-Analysis-Project-2023/Analysis


# Load modules
module load bioinfo-tools
module load quast

# load modules
module load bioinfo-tools
module load prokka

# Your commands
# Choose the names of the output files
# Choose the names of the output files
prokka --outdir $output --prefix 03_prokka_L_ferri $output/01_canu_dna_output.contigs.fasta --force
