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
CMD cd ideaIU && cd */. && cd bin && ./idea.sh
# CMD cd ideaIU && cd */. && cd bin && ls -la
