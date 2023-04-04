#!/bin/bash
#SBATCH --job-name=Next_busco
#SBATCH -A fnrchook
#SBATCH -t 14-00:00:00
#SBATCH -N 1
#SBATCH -n 128
#SBATCH -e %x_%j.err
#SBATCH -o %x_%j.out
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=
#SBATCH --mem=240G

ml bioinfo
ml biocontainers
ml busco/5.4.1

busco -m genome -i purged_scaf.fa -o purge_busco -l aves_odb10 -c 128
