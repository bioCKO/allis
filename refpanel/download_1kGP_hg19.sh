#!/bin/bash

export PATH=/g/funcgen/bin:${PATH}

# Genetic Map
wget "https://data.broadinstitute.org/alkesgroup/Eagle/downloads/tables/genetic_map_hg19_withX.txt.gz"

# Reference Panel
for CHR in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
do
    wget "ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr${CHR}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz"
    zcat ALL.chr${CHR}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz | bcftools annotate -O b -o chr${CHR}.bcf -x ^INFO/AC,INFO/AF,INFO/AN,INFO/NS,^FORMAT/GT -
    bcftools index chr${CHR}.bcf
    rm ALL.chr${CHR}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz
done
