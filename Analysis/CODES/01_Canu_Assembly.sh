#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 15:00:00
#SBATCH -J 01_canu_Dna
#SBATCH --mail-user neh-eyong.langsi.0046@student.uu.se
#SBATCH --mail-type=ALL

# load modules
module load bioinfo-tools
module load canu

#canu commands
canu -p 01_canu_dna_output \
-d /home/nehlang/Genom-Analysis-Project-2023/Analysis genomeSize=2.41m useGrid=false -pacbio \
/home/nehlang/Genom-Analysis-Project-2023/Data/2_Christel_2017/DNA_raw_data/E*

