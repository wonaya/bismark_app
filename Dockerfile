
############### TACC BASE IMAGE ###################
FROM cyverse/apps:python3
RUN mkdir /home1

################## SAMTOOLS ######################
COPY --from=biocontainers/samtools:1.3.1 /opt/conda/bin/samtools /opt/bin/

################## Bowtie2 ######################
COPY --from=biocontainers/bowtie2:2.2.9 /home/biodocker/bin /opt/bin/
ENV PATH "/opt/bin/:$PATH"

################## BISMARK ######################
ADD src /opt/src
ENV PATH "/opt/src/:$PATH"
