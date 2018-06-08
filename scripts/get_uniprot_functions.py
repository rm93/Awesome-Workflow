from Bio import SeqIO
import urllib.request

file = open(snakemake.output[0], "w")

with open(snakemake.input[0], "r") as input_file:
    for line in input_file:
        handle = urllib.request.urlopen("http://www.uniprot.org/uniprot/"+line.replace("\n","")+".xml")
        record = SeqIO.read(handle, "uniprot-xml")
        file.write(record.description + "\t|\t" + ", ".join(record.annotations["keywords"])+"\n")
