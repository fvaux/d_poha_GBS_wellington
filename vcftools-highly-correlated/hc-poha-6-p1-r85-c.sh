#!/bin/sh
#SBATCH -A uoo02915
#SBATCH -t 00:30:00
#SBATCH --mem=3G
#SBATCH -J hc-poha-6-p1-r85-c
#SBATCH --hint=nomultithread
#SBATCH -D /nesi/nobackup/uoo02915/VCFtools

module load VCFtools #load VCFtools

vcftools --vcf poha-6-p1-r85-c.vcf  --interchrom-geno-r2 --min-r2 0.8
cut -f 1-2 out.interchrom.geno.ld | uniq > LD1snp.txt
#LD1snp.txt will be a exlcuded loci list that should be fed to the exclude function:
vcftools --vcf poha-6-p1-r85-c.vcf --exclude-positions LD1snp.txt --recode --recode-INFO-all