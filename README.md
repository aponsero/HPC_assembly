# HPC_assembly
HPC pipeline for parrallel assembly of WGS metagenomes (SLURM)

## Installation

First, create the needed conda environment from the assembly_env.yml file in config folder.
```  
conda env create -f assembly_env.yml
``` 

## Run pipeline

1- Edit the config.sh file with relevant informations

2- Create a list of file to process (see example_list.txt)

3- Run assembly 

This command will read the number of files in the list of files to process and submit an array job accordingly.
```  
./1_run_megahit.sh
``` 
4- Run coverage

Once the assemblies are done and complete, coverage for each contig can be obtained running the command:
```  
./2_get_coverage.sh
``` 
