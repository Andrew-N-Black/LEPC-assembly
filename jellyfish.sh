#!/bin/bash
#SBATCH --job-name=Jellyfish
#SBATCH -A fnrpredator
#SBATCH -t 12-00:00:00
#SBATCH -N 1
#SBATCH -n 64
#SBATCH -e %x_%j.err
#SBATCH -o %x_%j.out
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=
#SBATCH --mem=100G

ml bioinfo
ml  biocontainers
ml hifiasm/0.16.0
ml BBMap
ml jellyfish/2.3.0
ml QUAST/5.0.2
ml genomescope2/2.0

#Concatentate the two SMRTcells of HiFi reads together
#cat m64108e_220921_182303.hifi_reads.fastq.gz m64108e_220923_051902.hifi_reads.fastq.gz > lepc_hifi_2smrt.fastq.gz

#Only keep reads that are greater than 1kb
#reformat.sh in=lepc_hifi_2smrt.fastq.gz out=lepc_hifi_2smrt_1k.fq.gz minlength=1000

#Unzip unfiltered fastq file for jellyfish kmer counting
#gzip -d ../../hifiasm/lepc_hifi_2smrt.fastq.gz ../../hifiasm/lepc_hifi_2smrt.fastq

#Create k-mer table for genomescope (to assess assembly predictions)
#jellyfish count -C -m 21 -s 1000000000 -t 128 ../../hifiasm/lepc_hifi_2smrt.fastq
#jellyfish histo -t 64 reads.jf > reads.histo
