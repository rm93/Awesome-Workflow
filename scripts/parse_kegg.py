import os

# Get all files in the folder
root, dirs, files = next(os.walk(snakemake.input[0]))

# Create a file for the pathways
with open(snakemake.output[1], "w") as pathway_output:
    # Loop through KEGG raw data files from wget
    for file in files:
        # Open file
        with open(root+"/"+file, "r") as file:
            seq = False
            name = "none"
            pathway = "none"
            sequence = ""
            # Parse file line by line, get name, pathway and sequence
            for line in file:
                clean_line = line.strip()
                if line != "":
                    splitted = [i for i in clean_line.split(" ") if i != ""]
                    if seq and clean_line != "///":
                        sequence += line.lstrip()
                    elif splitted[0] == "ENTRY":
                        name = splitted[1]
                    elif splitted[0] == "PATHWAY":
                        pathway = " ".join(splitted[1:])
                    elif splitted[0] == "NTSEQ":
                        seq = True
            # Write pathway to file
            pathway_output.write(name+"\t"+pathway+"\n")
            # Create sequence file of KEGG entry
            with open(snakemake.output[0]+name+".fasta", "w") as sequence_output:
                sequence_output.write(">"+name+"\n")
                sequence_output.write(sequence)
