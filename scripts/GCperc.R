library(HELP)
library(Biostrings)

#source_directory <- dirname(rstudioapi::getActiveDocumentContext()$path)
# Assumption that the script is in the folder 'scripts' of the Git repository
#git_directory <- substring(source_directory, 1, nchar(source_directory)-7)
#git_directory <- file.path("..", source_directory)

#setwd(git_directory)

# Assumption that the working directory is the folder of the Git repository
git_directory <- getwd()

# Create path
#inputPath <- paste(git_directory, "output/sequences/kegg/", sep="")
#outputPath <- paste(git_directory, "output/sequences/", sep="")
inputPath <- paste(git_directory, "/", snakemake@input[[1]], sep="")
outputPath <- paste(git_directory, "/", snakemake@output[[1]], sep="")

setwd(inputPath)

# Get the files in the folder
filenames <- list.files(path=getwd()) 
# Get total of files
numfiles <- length(filenames)  

# Create empty dataframe
df <- data.frame()

# Loop over the fasta files and calculate the gc% and set results in dataframe
i = 1  
for (i in c(1:numfiles)){
  fastaFile <- readDNAStringSet(filenames[i])
  seq_name = names(fastaFile)
  sequence = paste(fastaFile)
  gcPerc = calcGC(sequence)
  
  newrow = data.frame(seq_name, gcPerc)
  df = rbind(df,newrow)
  
  i = i+1
}

# Setwd to outputPath
setwd(outputPath)

# Write dataframe as txt file
write.table(df,"gc_percentages.txt",sep=",",row.names=FALSE)
