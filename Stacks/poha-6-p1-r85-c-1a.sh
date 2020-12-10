#!/bin/sh
#SBATCH -A uoo02915
#SBATCH -t 12:00:00
#SBATCH --mem=12G
#SBATCH -c 10
#SBATCH -J poha-6-p1-r85-c
#SBATCH -D /nesi/nobackup/uoo02915/STACKS/stacks_out/poha-6

module load Stacks/2.53-gimkl-2020a

populations -t 10 -P /nesi/nobackup/uoo02915/STACKS/stacks_out/poha-6 -M /nesi/nobackup/uoo02915/STACKS/maps/poha-5.txt -B /nesi/nobackup/uoo02915/STACKS/excluded-lists/poha-6-p1-r85-EL2.list -r 0.85 -p 1 --min-maf 0.05 --write-single-snp --write-single-snp --structure --fstats --genepop --plink --vcf --hzar --fasta-loci --fasta-samples --phylip --phylip-var