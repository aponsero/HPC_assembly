for fam in Perhe* 
do 
	cp $fam/final.contigs.fa ${fam}_megahit.fa 
	cp $fam/final.contigs_length.csv ${fam}_contigs_length.csv 
	cp $fam/log ${fam}_megahit.log 
done
