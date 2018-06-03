
######## Snakemake header ########
import sys; sys.path.insert(0, "/usr/lib/python3/dist-packages"); import pickle; snakemake = pickle.loads(b'\x80\x03csnakemake.script\nSnakemake\nq\x00)\x81q\x01}q\x02(X\x05\x00\x00\x00inputq\x03csnakemake.io\nInputFiles\nq\x04)\x81q\x05X\x17\x00\x00\x00processing/gene_ids.txtq\x06a}q\x07X\x06\x00\x00\x00_namesq\x08}q\tsbX\x06\x00\x00\x00outputq\ncsnakemake.io\nOutputFiles\nq\x0b)\x81q\x0cX\x18\x00\x00\x00processing/ncbi/test.txtq\ra}q\x0eh\x08}q\x0fsbX\x06\x00\x00\x00paramsq\x10csnakemake.io\nParams\nq\x11)\x81q\x12}q\x13h\x08}q\x14sbX\t\x00\x00\x00wildcardsq\x15csnakemake.io\nWildcards\nq\x16)\x81q\x17}q\x18h\x08}q\x19sbX\x07\x00\x00\x00threadsq\x1aK\x01X\t\x00\x00\x00resourcesq\x1bcsnakemake.io\nResources\nq\x1c)\x81q\x1d(K\x01K\x01e}q\x1e(h\x08}q\x1f(X\x06\x00\x00\x00_coresq K\x00N\x86q!X\x06\x00\x00\x00_nodesq"K\x01N\x86q#uh K\x01h"K\x01ubX\x03\x00\x00\x00logq$csnakemake.io\nLog\nq%)\x81q&}q\'h\x08}q(sbX\x06\x00\x00\x00configq)}q*X\x04\x00\x00\x00ruleq+X\t\x00\x00\x00good_nameq,ub.'); from snakemake.logging import logger; logger.printshellcmds = False
######## Original script #########
import os
open("TEST.TXT", "w")
with open(snakemake.input[0], "r") as fin:
    for line in fin:
        print(line)
        os.system('wget "https://www.ncbi.nlm.nih.gov/gene/?term={1}&report=xml&format=text" > {0}{1}.xml'.format(snakemake.output[0], line))
fin.close()
