# Awesome-Workflow

**Licence: GNU General Public License v3.0 (copy provided in directory)**<br />
<br />
**Authors**:
- Alex Staritsky
- Rick Medemblik

**Contact**:
- alexstaritsky@hotmail.nl
- rmedemblik93@gmail.com

### Description

Automated workflow for analyzing data from <i>Lactobacillus plantarum</i> written in Snakemake and working in a Docker container.

### Requirements

#### System

- Linux operating system. The software is developed on Linux Ubuntu 18.04<br />
**WARNING: Experiences when using different operating systems may vary.**

#### Dependencies

- Python 3.6
- Tqdm 4.19.8
- Docker version 17.12.1-ce, build 7390fc6
- Anaconda 4.4.10
- NCBI E-utilities 6.10
- Snakemake 5.1.4
- Biopython 1.71
- R version 3.3.3 (2017-03-06) -- "Another Canoe"
- Graphviz version 2.40.1 (20161225.0304)
- Biostrings 2.42.1
- HELP 1.32.0

### Preparations

To download the project files via the terminal use the following command: `git clone "https://github.com/rm93/Awesome-Workflow.git"`

To download our docker environment use the docker image on: https://hub.docker.com/r/alexstaritsky/snakemake/

To manually create the docker container and conda envrionment and the needed installs follow the following steps.

#### (Manual) Creation of the Docker image

- Install Docker<br>
`sudo apt update`<br>
`sudo apt install docker.io`<br>

- Add user to Docker group<br>
`sudo groupadd docker`<br>
`sudo gpasswd -a $USER docker`<br>

- Test<br>
`docker run hello-world`<br>

- Setup Portainer.io to controle the containers with a graphical interface<br>
`docker volume create portainer_data`<br>
`docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v --name=portainer portainer_data:/data portainer/portainer`<br>

- Pull<br>
`docker pull continuumio/anaconda3`<br>

- Container<br>
`docker run -i -t -v ~/GitHub/Awesome-Workflow:/Awesome-Workflow --name=snakemake continuumio/anaconda3 /bin/bash`<br>

- Portainer management, get back console<br>
`docker attach snakemake`<br>

#### Conda environment

- Create Conda env<br>
`conda create --name snakemake`<br>

- Change env<br>
`source activate snakemake`<br>

##### Snakemake

- Install Snakemake<br>
`conda install -c bioconda -c conda-forge snakemake`<br>

##### Biopython

- Install Biopython<br>
`conda install -c bioconda biopython`<br>

##### NCBI

- Install NCBI command line utils<br>
`apt install ncbi-entrez-direct`<br>

##### R

- Install R<br>
`apt update`<br>
`apt -y install r-base`<br>

- In R (R-packages)<br>
`source("https://bioconductor.org/biocLite.R")`<br>
`biocLite()`<br>
`biocLite("Biostrings")`<br>
`biocLite("HELP")`<br>

##### Graphviz
`conda install -c anaconda graphviz`

### Usage

To start the script you use the terminal.

#### Terminal
- Make sure all requirements are installed on your computer or in a virtual environment
- Go to the folder where the snakefile is.
- And run the script with the command: `snakemake`

### Alternative usage using Docker
- Get the docker image using pull from https://hub.docker.com/r/alexstaritsky/snakemake/
- Run the image so that it creates a container with the right environment and dependencies
- If necessary, get to the terminal of the container by `docker attach <container_name/id>`
- Activate the right Conda environment by `source activate snakemake`
- Go to `/Awesome-Workflow` or if it doesn't exist clone it from our GitHub into the container and navigate to it
- Execute the workflow using `snakemake`

### Output

After running the script several folders are created. The output map is the most interesting because here the report.html is stored.
