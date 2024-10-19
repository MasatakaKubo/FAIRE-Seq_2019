####set data#####
region=("")
filename1=("201117-NPM")
filename2=("201117-nonNPM")
ref_gene=("susScr11")
date="20.11.17"
#################

#import data in directory
dir=""
cd ${dir}/comparison/bedtools
mkdir ${date}
cd ${date}

#get intersect region
bedtools intersect -wa -a ${dir}/${filename1}/macs2data/${filename1}_peaks.narrowPeak -b ${dir}/${filename2}/macs2data/${filename2}_peaks.narrowPeak > uq_${filename1}_${filename2}.bt.bed
bedtools intersect -v -a ${dir}/${filename1}/macs2data/${filename1}_peaks.narrowPeak -b ${dir}/${filename2}/macs2data/${filename2}_peaks.narrowPeak > uq_${filename1}.bt.bed
bedtools intersect -v -a ${dir}/${filename2}/macs2data/${filename2}_peaks.narrowPeak -b ${dir}/${filename1}/macs2data/${filename1}_peaks.narrowPeak > uq_${filename2}.bt.bed
 
wc -l uq_${filename1}.bt.bed >venn.exl.bt.txt
wc -l uq_${filename2}.bt.bed >>venn.exl.bt.txt

#count Peaks
wc -l ${dir}/${filename1}/bowtie2/${filename1}_sorted.bed >>venn.exl.bt.txt
wc -l ${dir}/${filename2}/bowtie2/${filename2}_sorted.bed >>venn.exl.bt.txt
wc -l uq_${filename1}_${filename2}.bt.bed >>venn.exl.bt.txt

#peaks annotation with homer
annotatePeaks.pl uq_${filename1}_${filename2}.bt.bed ${ref_gene} > uq_${filename1}_${filename2}.bt.annotated.txt
annotatePeaks.pl uq_${filename1}.bt.bed ${ref_gene} > uq_${filename1}.bt.annotated.txt
annotatePeaks.pl uq_${filename2}.bt.bed ${ref_gene} > uq_${filename2}.bt.annotated.txt 

mkdir intersect
mkdir annotation

mv uq_${filename1}.bt.bed uq_${filename2}.bt.bed uq_${filename1}_${filename2}.bt.bed intersect
mv uq_${filename1}.bt.annotated.txt uq_${filename2}.bt.annotated.txt uq_${filename1}_${filename2}.bt.annotated.txt annotation







