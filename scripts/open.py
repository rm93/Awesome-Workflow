first = True
with open(snakemake.input[0], "r") as fin:
    with open(snakemake.output[0], "w") as fout:
        for line in fin:
            if line[0] != "#" and line != "":
                if first:
                    first = False
                else:
                    fout.write(line.split("\t")[0]+"\n")
fin.close()
fout.close()
