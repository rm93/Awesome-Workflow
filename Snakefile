# Imports
import os
from tqdm import tqdm

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
			for identifier in tqdm(input_file):
				# Remove whitespace
				identifier = "".join(identifier.split())
				os.system("""
				esearch -db gene -query \"{0}\" |
				efetch -format xml |
				xtract -pattern Dbtag -element Dbtag_db,Object-id_str |
				grep -m 1 \"UniProtKB\" |
				cut -f 2 >> \"{1}\"
				""".format(identifier, output[0]))

# Using wget to use KEGG RESTful API to get DNA sequences
rule retrieve_dna_sequences:
	input:
		"processing/gene_ids.txt"
	output:
		"output/sequences/kegg/"
	run:
		with open(input[0], "r") as input_file:
			for identifier in tqdm(input_file):
				# Remove whitespace
				identifier = "".join(identifier.split())
				output_filename = output[0]+identifier+".fasta"
				os.system("""
				wget -O \"{1}\" \"http://rest.kegg.jp/get/lpl:{0}/ntseq\"
				""".format(identifier, output_filename))

# Using R to calculate the GC-pecentage in sequences
rule calculate_gc_percentage:
	input:
		"output/sequences/kegg/"
	output:
		"output/sequences/"
	script:
		"scripts/GCperc.R"

# Create report
rule create_report:
	input:
		"processing/ncbi/uniprot_ids.txt"
	output:
		"processing/report.html"
	shell:
		"touch {output}"
