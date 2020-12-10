#!/bin/sh
#SBATCH -A uoo02915
#SBATCH -t 00:30:00
#SBATCH --mem=3G
#SBATCH -J ld-poha-6-p1-r85
#SBATCH --hint=nomultithread
#SBATCH -D /nesi/nobackup/uoo02915/PLINK

module load PLINK

plink --file poha-6-p1-r85.plink --r2 --ld-window-r2 0.8 --out poha-6-p1-r85-ld --allow-extra-chr
