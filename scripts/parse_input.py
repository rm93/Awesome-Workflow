from tqdm import tqdm
# For debugging reasons, remove num_lp and replace elif in full version
num_lp = 0
first = True
with open(snakemake.input[0], "r") as input_file:
    with open(snakemake.output[0], "w") as output_file:
        for line in tqdm(input_file):
            if line[0] != "#" and line != "":
                if first:
                    first = False
                elif num_lp < 10:
                    output_file.write(line.split("\t")[0]+"\n")
                    num_lp += 1
