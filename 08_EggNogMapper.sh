#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J eggNOGMapper_job.sh
#SBATCH  --mail-user neh-eyong.langsi.0046@student.uu.se
#SBATCH  --mail-type=ALL

#Define variables
INPUT_FILE=/home/nehlang/Genom-Analysis-Project-2023/Code/canu_L_Ferri_combined.contigs.fasta
REF=/home/nehlang/Genom-Analysis-Project-2023/Data/2_Christel_2017/reference/OBMB01.fasta
OUTPUT_FILE=/home/nehlang/Genom-Analysis-Project-2023/Analysis/08_EggNogMapper

#load modules
module load bioinfo-tools hmmer
# check database through $EGGNOG_DATA_ROOT/hmmer
emmaper.py -m hmmer -d Nitrospirae -i $INPUT_FILE -o 08_EggNogMapper --output_dir $OUTPUT_FILE --itype genome --genepred 'prodigal'

