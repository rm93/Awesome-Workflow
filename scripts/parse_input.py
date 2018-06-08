# Used for progress of iterations in command line
from tqdm import tqdm
# Num_lp is used to limit the amount of locus tags in the output for testing
num_lp = 0
first = True
# Open the input data
with open(snakemake.input[0], "r") as input_file:
    # Create a output file
    with open(snakemake.output[0], "w") as output_file:
        for line in tqdm(input_file):
            if line[0] != "#" and line != "":
                # Skip header
                if first:
                    first = False
                # Write the locus tags to files
                elif num_lp < 10:
                    output_file.write(line.split("\t")[0]+"\n")
                    num_lp += 1
