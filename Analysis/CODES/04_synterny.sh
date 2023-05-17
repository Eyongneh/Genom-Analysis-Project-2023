#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 05:00:00
#SBATCH -J 04_synteny_script
#SBATCH --mail-user neh-eyong.langsi.0046@student.uu.se
#SBATCH --mail-type=ALL

module load bioinfo-tools blast
input_contigs="/home/nehlang/Genom-Analysis-Project-2023/Code/canu_L_Ferri_combined.contigs.fasta"
output="/home/nehlang/Genom-Analysis-Project-2023/Analysis/synteny_output"


blastn -subject ML04FILE.fasta -query $input_contigs -outfmt 6 -out $output/syntenyRisa_out.tab
