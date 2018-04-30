FROM store/oracle/serverjre:8
LABEL maintainer="torsten.kleiber@web.de"
ARG SW_FILE1=default1
ARG SW_FILE2=default2
COPY ${SW_FILE1} /tmp/
COPY ${SW_FILE2} /tmp/
RUN yum -y install xterm xauth libXtst wget tar gzip which \
&& mkdir ideaIC \
&& mkdir ideaIU \
&& tar zxf /tmp/${SW_FILE1} --directory=ideaIC \
&& tar zxf /tmp/${SW_FILE2} --directory=ideaIU \
&& rm -f /tmp/${SW_FILE1} \
&& rm -f /tmp/${SW_FILE2}
# CMD ideaIC/idea-IC-173.4301.25/bin/idea.sh
# CMD ls -la ideaIU/idea-IU-181.4668.68/bin
CMD cd ideaIU && cd */. && cd bin && /idea.sh
