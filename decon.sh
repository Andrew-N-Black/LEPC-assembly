#!/bin/bash    
#SBATCH --job-name=blob_next    
#SBATCH -A fnrchook    
#SBATCH -t 14-00:00:00    
#SBATCH -n 64    
    

module load bioinfo
module load samtools

#Map reads to use for coverage information
minimap2 -ax map-hifi purged_scaf.fa ../../../raw/hifi/m64108e_220921_182303.hifi_reads.fastq.gz ../../../raw/hifi/m64108e_220923_051902.hifi_reads.fastq.gz -t 60 > aln.sam
#convert to bam
samtools view -Sb aln.sam > aln.bam  
#Sort bam
samtools sort -@ 64 aln.bam > aln_sort.bam
#index
samtools index -@ 64 aln_sort.bam  

module purge
ml biocontainers
ml blobtools
ml blast
ml minimap2

#produce hits file
blastn -task megablast -query purged_scaf.fa -db nt -outfmt 6 -max_target_seqs 10 -max_hsps 1 -num_threads 64 -out blast_out_lepc.txt -evalue 1e-25
#produce coverage file
blobtools map2cov -i purged_scaf.fa -b aln_sort.bam -o aln_sort.bam.cov
#create blobdir
blobtools create -i purged_scaf.fa -c aln_sort.bam.cov -o db -t blast_out_lepc.txt --names /home/blackan/blobtools/data/names.dmp --nodes /home/blackan/blobtools/data/nodes.dmp
#VIew output table
blobtools view  -i db.blobDB.json  -o results_table.txt --rank order
