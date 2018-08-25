
############### TACC BASE IMAGE ###################
FROM cyverse/apps:python3

################## SAMTOOLS ######################
COPY --from=biocontainers/samtools:1.3.1 /opt/conda/bin/samtools /opt/bin/
ENV PATH "/opt/bin/:$PATH"

################## BISMARK ######################
ADD src /opt/src
ENV PATH "/opt/src/:$PATH"
