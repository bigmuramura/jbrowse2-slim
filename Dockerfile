FROM node:slim

RUN apt-get update && apt-get install -y \
	wget \
	genometools \
	samtools \
	tabix \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*


RUN npm install -g @jbrowse/cli && jbrowse create /var/www/html/jbrowse2

WORKDIR /var/www/html/jbrowse2

RUN wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/215/GCF_000001215.4_Release_6_plus_ISO1_MT/GCF_000001215.4_Release_6_plus_ISO1_MT_genomic.fna.gz
RUN gunzip GCF_000001215.4_Release_6_plus_ISO1_MT_genomic.fna.gz
RUN samtools faidx GCF_000001215.4_Release_6_plus_ISO1_MT_genomic.fna
RUN jbrowse add-assembly  GCF_000001215.4_Release_6_plus_ISO1_MT_genomic.fna --out /var/www/html/jbrowse2 --load copy
