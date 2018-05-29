rule open_file:
	input:
		"data/RNA-Seq-counts_fix.txt"
	output:
		"processing/gene_ids.txt"
	script:
		"scripts/open.py"
