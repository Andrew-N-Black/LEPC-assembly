#!/bin/bash
#SBATCH --job-name=Next_arcs
#SBATCH -A fnrpredator
#SBATCH -t 12-00:00:00 
#SBATCH -N 1
#SBATCH -n 64
#SBATCH -e %x_%j.err
#SBATCH -o %x_%j.out
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=
#SBATCH --mem=100G

ml biocontainers
ml arcs/1.2.4

arcs-make arks draft=purged reads=../../../raw/tell/F22_nobc_T500_4ARCS k=60
