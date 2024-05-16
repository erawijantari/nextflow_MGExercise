#!/bin/bash
#SBATCH --job-name=test_nextflow
#SBATCH --time=72:00:00          #adjust for the time needed
#SBATCH --partition=large        #for multinode, large partition should be use
#SBATCH --nodes=4                #max nodes allowed 26
#SBATCH --account=project_200xxxx
#SBATCH --cpus-per-task=4
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=80G


export SINGULARITY_TMPDIR=$PWD
export SINGULARITY_CACHEDIR=$PWD
unset XDG_RUNTIME_DIR

# Activate  Nextflow on Puhti
module load nextflow
module load hyperqueue

# Create a per job directory

export HQ_SERVER_DIR=$PWD/.hq-server-$SLURM_JOB_ID
mkdir -p $HQ_SERVER_DIR

hq server start &
srun --cpu-bind=none --hint=nomultithread --mpi=none -N $SLURM_NNODES -n $SLURM_NNODES -c 4 hq worker start --cpus=$SLURM_CPUS_PER_TASK &

num_up=$(hq worker list | grep RUNNING | wc -l)
while true; do

    echo "Checking if workers have started"
    if [[ $num_up -eq $SLURM_NNODES ]];then
        echo "Workers started"
        break
    fi
    echo "$num_up/$SLURM_NNODES workers have started"
    sleep 1
    num_up=$(hq worker list | grep RUNNING | wc -l)

done

#run the nextflow 
#for testing (in profile params use test,singularity flag )

nextflow run nf-core/taxprofiler -r 1.1.5 -c ./config/nextflow.config -resume\
   -profile singularity \
   --input /scratch/project_201xxx/USERS/pande/samplesheet.csv \
   --databases /scratch/project_201xxx/config/database.csv \
   --outdir ./RESULTS  \
   --perform_shortread_qc \
   --perform_shortread_complexityfilter  --shortread_complexityfilter_tool bbduk \
   --perform_shortread_hostremoval \
   --hostremoval_reference /projappl/project_20xxxx/DB/T2T-CHM13v2.0.zip \
   --shortread_hostremoval_index /projappl/project_200xxx/DB/human_CHM13/ \
   --save_analysis_ready_fastqs \
   --run_profile_standardisation \
   --run_metaphlan


# Make sure we exit cleanly once nextflow is done
hq worker stop all
hq server stop    