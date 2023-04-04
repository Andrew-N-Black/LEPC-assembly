#SBATCH --job-name=Next_purge
#SBATCH -A fnrchook
#SBATCH -t 14-00:00:00 
#SBATCH -N 1
#SBATCH -n 128
#SBATCH -e %x_%j.err
#SBATCH -o %x_%j.out
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=
#SBATCH --mem=80G

module load use.own
module load conda-env/purge-py3.9.12
ml bioinfo
ml biocontainers
ml minimap2

PB_list=$`cat hifi.fofn`
PRI_ASM=/scratch/bell/blackan/LEPC/assembly/next/01_rundir/03.ctg_graph/nd.asm.v1.fasta

#Step 1. Run minimap2 to align pacbio data and generate paf files, then calculate read depth histogram and base-level read depth. Commands are as follows:
for i in $PB_list
do
	minimap2 -xmap-pb $PRI_ASM $i | gzip -c - > $i.paf.gz
done
~/purge_dups/bin/pbcstat *.paf.gz #(produces PB.base.cov and PB.stat files)
~/purge_dups/bin/calcuts PB.stat > cutoffs 2>calcults.log

#Step 1. Split an assembly and do a self-self alignment. Commands are following:
~/purge_dups/bin/split_fa $PRI_ASM > $PRI_ASM.split
minimap2 -xasm5 -DP $PRI_ASM.split $PRI_ASM.split | gzip -c - > $PRI_ASM.split.self.paf.gz

#Step 2. Purge haplotigs and overlaps with the following command.
~/purge_dups/bin/purge_dups -2 -T cutoffs -c PB.base.cov $PRI_ASM.split.self.paf.gz > dups.bed 2> purge_dups.log

#Step 3. Get purged primary and haplotig sequences from draft assembly.
~/purge_dups/bin/get_seqs -e dups.bed $PRI_ASM 

#Check the coverage plot to validate the purged assembly
#Do Busco again and compare
