#####Extract "gene" from Sperm_analysis_Summary.txt#####
#header = Gene	Reads	MethylationRate	HypoMethylationCloneRate	HyperMethylationCloneRate
#
#Execution command
#perl extract_0923.pl cp_160114summary/Sperm_analysis_Summary.txt 12_intersect_out/20.11.17/intersect_allGene.txt > test1118.txt 
#perl extract_0923.pl cp_160114summary/Sperm_analysis_Summary.txt 12_intersect_out/20.11.17/uq_NPM_allGene.txt > test1118_NPM.txt
$summary=$ARGV[0];
$i = 0;
open(SUM, $summary);
while(<SUM>) {
	$line = $_;
	chomp($line);
	if($line =~ /(.*?)_./) {
		$i++;
		$all[$i] = $line;
		$gene_name[$i] = $1;		
	}
}
close(SUM);
#for($a = 0; $a <= $i; $a++) {
#	print("$gene_name[$a]\t$all[$a]\n");
#}
$common=$ARGV[1];
$a = 0;
open(CO, $common);
while(<CO>) {
	$uq_NPM_nonNPM = $_;
	chomp($uq_NPM_nonNPM);
	for ($a=0; $a<=$i; $a++) {
		if($gene_name[$a] =~ /$uq_NPM_nonNPM/) {
			print("$gene_name[$a]\t$all[$a]\n");
		}
	}	
}
close(CO);
