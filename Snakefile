# Imports
import os
from tqdm import tqdm

# Necessary for executing all the steps in the workflow
rule all:
	input:
		"processing/gene_ids.txt", "processing/ncbi/uniprot_ids.txt", "processing/raw_kegg/", "output/sequences/", "output/pathways.txt", "output/", "output/uniprot_functions.txt", "processing/report.html"

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
rule retrieve_kegg_data:
	input:
		"processing/gene_ids.txt"
	output:
		"processing/raw_kegg/"
	run:
		with open(input[0], "r") as input_file:
			for identifier in tqdm(input_file):
				# Remove whitespace
				identifier = "".join(identifier.split())
				output_filename = output[0]+identifier+".fasta"
				os.system("""
				wget -O \"{1}\" \"http://rest.kegg.jp/get/lpl:{0}"
				""".format(identifier, output_filename))

# Parse KEGG outputs using Python
rule parse_kegg_output:
	input:
		"processing/raw_kegg/"
	output:
		"output/sequences/", "output/pathways.txt"
	script:
		"scripts/parse_kegg.py"

# Using R to calculate the GC-pecentage in sequences
rule calculate_gc_percentage:
	input:
		"output/sequences/"
	output:
		"output/"
	script:
		"scripts/GCperc.R"

# Using Biopython to retrieve and parse UniProt function data
rule get_uniprot_functions:
	input:
		"processing/ncbi/uniprot_ids.txt"
	output:
		"output/uniprot_functions.txt"
	script:
		"scripts/get_uniprot_functions.py"

# Create report
rule create_report:
	input:
		"processing/ncbi/uniprot_ids.txt"
	output:
		"processing/report.html"
	shell:
		"touch {output}"
