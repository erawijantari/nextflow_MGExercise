#!/bin/bash
#SBATCH --job-name=download_data           # Name of the job visible in the queue.
#SBATCH --account=project_2005073       # Choose the billing project. Has to be defined!
#SBATCH --partition=small          # Job queues: test, interactive, small, large, longrun, hugemem, hugemem_longrun
#SBATCH --time=01:00:00           # Maximum duration of the job. Max: depends of the partition. 
#SBATCH --mem=1G                  # How much RAM is reserved for job per node.
#SBATCH --ntasks=1                # Number of tasks. Max: depends on partition.
#SBATCH --cpus-per-task=1         # How many processors work on one task. Max: Number of CPUs per node.

wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR502/001/SRR5024281/SRR5024281_1.fastq.gz
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR502/000/SRR5024280/SRR5024280_1.fastq.gz
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR502/002/SRR5024282/SRR5024282_2.fastq.gz
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR502/003/SRR5024283/SRR5024283_2.fastq.gz
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR502/003/SRR5024283/SRR5024283_1.fastq.gz
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR502/000/SRR5024280/SRR5024280_2.fastq.gz
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR502/001/SRR5024281/SRR5024281_2.fastq.gz
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR502/002/SRR5024282/SRR5024282_1.fastq.gz