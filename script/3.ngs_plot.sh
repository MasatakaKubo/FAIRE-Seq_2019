####set data#####
filename1=("201117-NPM")
filename2=("201117-nonNPM")
ngs_ref=("susScr11")
date="20.11.18"
#################

#import data in directory
dir=""
cd ${dir}/comparison/ngsplot
mkdir ${date}
cd ${date}

cp ${dir}/${filename1}/bowtie2/${filename1}_sorted.bam .
cp ${dir}/${filename2}/bowtie2/${filename2}_sorted.bam .

#make filelist
echo ${filename1}_sorted.bam -1 "${filename1}" > list.txt
echo ${filename2}_sorted.bam -1 "${filename2}" >> list.txt


ngs.plot.r -G ${ngs_ref} -R genebody -C list.txt -O comparison_genebody -L 4000 -FL 100
ngs.plot.r -G ${ngs_ref} -R tss -C list.txt -O comparison_tss -L 4000 -FL 200
ngs.plot.r -G ${ngs_ref} -R genebody -C list.txt -O k_means -L 4000 -FL 200 -GO km -KNC 3 -NRS 400

mkdir genebody
mkdir tss
mkdir k-means 
mkdir trush

mv comparison_genebody.avgprof.pdf comparison_genebody.heatmap.pdf comparison_genebody.zip genebody
mv comparison_tss.avgprof.pdf comparison_tss.heatmap.pdf comparison_tss.zip tss
mv k_means.avgprof.pdf k_means.heatmap.pdf k_means.zip k-means
mv ${filename1}_sorted.bam ${filename1}_sorted.bam.bai ${filename1}_sorted.bam.cnt ${filename2}_sorted.bam ${filename2}_sorted.bam.bai ${filename2}_sorted.bam.cnt list.txt trush  


