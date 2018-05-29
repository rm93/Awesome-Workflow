rule open_file:
	input:
		"data/RNA-Seq-counts.txt"
	output:
		"processing/gene_ids.txt"
	script:
		"scripts/open.py"
