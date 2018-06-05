from tqdm import tqdm
first = True
with open(snakemake.input[0], "r") as input_file:
    with open(snakemake.output[0], "w") as output_file:
        for line in tqdm(input_file):
            if line[0] != "#" and line != "":
                if first:
                    first = False
                else:
                    output_file.write(line.split("\t")[0]+"\n")
