####set data#####
filename=("SRR12107011")
ref_gene=("susScr11")
detail=("pig_input")
#################
###PAIREND###

#use SRAToolkit
fastq-dump ${filename} --split-files --gzip

#quality check by fastp
fastp -i ${filename}_1.fastq.gz -I ${filename}_2.fastq.gz -o fastp_${filename}_1.fastq.gz -O fastp_${filename}_2.fastq.gz -h report_fastp.html -j report_fastp.json
mkdir fastp_report
mv report_fastp.html report_fastp.json fastp_report

#extract files
gunzip fastp_${filename}_1.fastq.gz
gunzip fastp_${filename}_2.fastq.gz

#######################
#######################

#ucsc

#mapping with bowtie2
bowtie2 -p 17 -x /home/ohganelab/analyzetools/bowtie2-2.3.5.1/bowtie2_ref/susScr11/susScr11 -1 fastp_${filename}_1.fastq -2 fastp_${filename}_2.fastq -S ${filename}.sam

#remove multi-mapped reads
cat ${filename}.sam | perl -e'while(<>){print $_ if(/\@SQ||\@PG/);}' > ${filename}.header.sam
grep -v "XS" ${filename}.sam > ${filename}.uq.sam

#quality check with samtools(MAPQ>4)
samtools view -q 4 ${filename}.uq.sam > ${filename}.uq.qc.sam

#from sam to bam, bed, bedgraph
cat ${filename}.header.sam ${filename}.uq.qc.sam > ${filename}.uq.qc.hb.sam
samtools view -b -S ${filename}.uq.qc.hb.sam > ${filename}.bam
samtools sort ${filename}.bam > ${filename}_sorted.bam
samtools index ${filename}_sorted.bam
bamToBed -i ${filename}_sorted.bam > ${filename}_sorted.bed
genomeCoverageBed -ibam ${filename}_sorted.bam -bg -trackline -trackopts 'name="Mytrack" visibility=2 color=225.0.0' > ${filename}_sorted.bedGraph

#organize directory
mkdir trush
mv ${filename}.sam ${filename}.uq.sam ${filename}.uq.qc.sam ${filename}.header.sam ${filename}.uq.qc.hb.sam ${filename}.bam trush

#peak calling(MACS2)
macs2 callpeak -t ${filename}_sorted.bam -f BAM -n ${filename} \--nomodel --keep-dup all --nolambda --call-summits -B
mkdir macs2data

#peaks annotation with homer
bed2pos.pl ${filename}_peaks.narrowPeak > ${filename}.mspeaks.hb
annotatePeaks.pl ${filename}.mspeaks.hb ${ref_gene} > ${filename}_peaks.annotated.txt

mv ${filename}_control_lambda.bdg ${filename}_summits.bed ${filename}_peaks.narrowPeak ${filename}_treat_pileup.bdg ${filename}_peaks.xls macs2data
mkdir peak_annotation
mv ${filename}_peaks.annotated.txt peak_annotation
mv ${filename}.mspeaks.hb trush
mkdir bowtie2
mv ${filename}_sorted.bam ${filename}_sorted.bam.bai ${filename}_sorted.bed ${filename}_sorted.bedGraph bowtie2
