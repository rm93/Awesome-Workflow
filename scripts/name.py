import os
with open(snakemake.input[0], "r") as fin:
    for line in fin:
        os.system("esearch -db gene -query \"{0}\" | efetch -format xml | xtract -pattern Dbtag -element Dbtag_db,Object-id_str | grep -m 1 \"UniProtKB\" | cut -f 2 >> \"/home/rm93/Documents/Blok_11/InformaticaProject/project/Awesome-Workflow/processing/ncbi/test.txt\"".format(line, snakemake.output[0]))
fin.close()
