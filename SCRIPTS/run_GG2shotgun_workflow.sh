#!/bin/bash

module load snakemake/7.15.2
export PATH="/projappl/project_2005073/erawijan/project/qiime2-shotgun-2023.09/bin:$PATH"

snakemake  -s ./workflow/Snakefile_gg2_shotgun  --cluster \
    " sbatch --account=project_2005073 \
    --partition small --mem 150G --time=2-00:00:00 \
    --ntasks=1 --cpus-per-task=32 \
     -e LOGS/shotgun_err_%A_%a.txt" -j 400 \
    --stats ./comp_jobs_stats.json --keep-going --rerun-incomplete