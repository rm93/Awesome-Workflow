first = True
with open(snakemake.output[0], "w") as fin:
    with open(snakemake.output[0], "w") as fout:
        for line in in:
            if line[0] != "#" and line != "":
                if first:
                    first = False
                else:
                    out.write(line.split("\t")[0])
fin.close()
fout.close()
