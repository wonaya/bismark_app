
################## Agave ######################
FROM cyverse/apps:python3

COPY --from=biocontainers/samtools:latest /opt/conda/bin/samtools /opt/bin/
ENV PATH "/opt/bin/:$PATH"
CMD ["samtools"]

# ADD config.yml /config.yml
# ADD src /opt/src
