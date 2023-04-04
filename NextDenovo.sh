#!/bin/bash
#SBATCH --job-name=Next_Assemble
#SBATCH -A highmem
#SBATCH -t 1-00:00:00
#SBATCH -N 1
#SBATCH -n 128
#SBATCH -e %x_%j.err
#SBATCH -o %x_%j.out
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=
#SBATCH --mem=500G

module load use.own
module load conda-env/next-py3.7.6

~/NextDenovo/nextDenovo ~/NextDenovo/run.cfg

$cat ~/NextDenovo/run.cfg

#job_type = local # local, slurm, sge, pbs, lsf
#job_prefix = nextDenovo
#task = assemble # all, correct, assemble
#rewrite = yes # yes/no
#deltmp = yes
#parallel_jobs = 128 # number of tasks used to run in parallel
#input_type = corrected # raw, corrected
#read_type = hifi # clr, ont, hifi
#input_fofn = /scratch/bell/blackan/LEPC/assembly/raw/hifi/input.fofn
#workdir = /scratch/bell/blackan/LEPC/assembly/raw/hifi/next/01_rundir

#[correct_option]
#read_cutoff = 1k
#genome_size = 1g # estimated genome size
#sort_options = -m 100g -t 128
#minimap2_options_raw = -t 128
#pa_correction = 3 # number of corrected tasks used to run in parallel, each corrected task requires ~TOTAL_INPUT_BASES/4 bytes of memory usage.
#correction_options = -p 128

#[assemble_option]
#minimap2_options_cns = -t 128 -k17 -w17 
#nextgraph_options = -a 1

# see https://nextdenovo.readthedocs.io/en/latest/OPTION.html for a detailed introduction about all the parameters
