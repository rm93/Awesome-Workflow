# Imports
import os

# Necessary for executing all the steps in the workflow
rule all:
	input:
		"processing/report.html"

# Using Python as tool
rule parse_input:
	input:
		"data/RNA-Seq-counts_fix.txt"
	output:
		"processing/gene_ids.txt"
	script:
		"scripts/parse_input.py"

# Using shell commands and NCBI command line tools (e-utils)
rule convert_identifiers:
	input:
		"processing/gene_ids.txt"
	output:
		"processing/ncbi/uniprot_ids.txt"
	run:
		with open(input[0], "r") as input_file:
			for identifier in input_file:
				os.system("""
				esearch -db gene -query \"{0}\" |
				efetch -format xml |
				xtract -pattern Dbtag -element Dbtag_db,Object-id_str |
				grep -m 1 \"UniProtKB\" |
				cut -f 2 >> \"{1}\"
				""".format(identifier, output[0]))

# Create report
rule create_report:
	input:
		"processing/ncbi/uniprot_ids.txt"
	output:
		"processing/report.html"
	shell:
		"touch {output}"
