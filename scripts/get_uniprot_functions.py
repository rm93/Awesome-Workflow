from Bio import SeqIO
import urllib.request

#Open output file
file = open(snakemake.output[0], "w")

#Get the xml files from uniprot and parse on the fly and write the results to the output file.
with open(snakemake.input[0], "r") as input_file:
    for line in input_file:
        handle = urllib.request.urlopen("http://www.uniprot.org/uniprot/"+line.replace("\n","")+".xml")
        record = SeqIO.read(handle, "uniprot-xml")
        file.write(record.description + "\t|\t" + ", ".join(record.annotations["keywords"])+"\n")
