#!/bin/sh
#SBATCH -A uoo02915
#SBATCH -t 00:30:00
#SBATCH --mem=3G
#SBATCH -J cd-poha-6-p1-r85
#SBATCH --hint=nomultithread
#SBATCH -D /nesi/nobackup/uoo02915/VCFtools

module load VCFtools #load VCFtools

vcftools --vcf poha-6-p1-r85.vcf --minDP 8 --recode --out poha-6-p1-r85-X
vcftools --vcf poha-6-p1-r85-X.recode.vcf --max-missing .8 --recode --out poha-6-p1-r85-Y
diff poha-6-p1-r85-X.recode.vcf poha-6-p1-r85-Y.recode.vcf | grep -v "^#" | cut -f1-3 > low-coverage-loci.txt
