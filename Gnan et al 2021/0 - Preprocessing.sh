
for i in *.bam;do
# filter quality higher of equal to 30 and properly paired
samtools view -b -f 3 -q 30 -@ 6 $i  >${i/%.bam/_filtered.bam}
# sort by reads names
samtools sort -n ${i/%.bam/_filtered.bam} -o ${i/%.bam/_filtered_sorted_name.bam} -O BAM -@ 6
#fix mates
samtools fixmate -@ 6 ${i/%.bam/_filtered_sorted_name.bam} ${i/%.bam/_filtered_sorted_name_fixedmate.bam}
#convert bam to bedpe
bedtools bamtobed -i ${i/%.bam/_filtered_sorted_name_fixedmate.bam} -bedpe > ${i/%.bam/_filtered_sorted_name_fixedmate.bedpe}
# select cols
less ${i/%.bam/_filtered_sorted_name_fixedmate.bedpe} | awk '{print $1"\t"$2"\t"$6}' > ${i/%.bam/_filtered_sorted_name_fixedmate.bed}

done
# convert into bed
for i in *.bedpe;do less $i | awk '{print $1"\t"$2"\t"$6}' > ${i/%.bedpe/.bed}; done
