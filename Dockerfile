FROM registry.access.redhat.com/ubi8/ubi:8.0

ENV JAVA_OPTIONS -Xmx512m

RUN yum install -y --disableplugin=subscription-manager java-1.8.0-openjdk-headless && \
    yum clean all --disableplugin=subscription-manager -y && \
    mkdir -p /opt/app/bin
    
ADD https://github.com/BharathPapegowda/custom/releases/download/1.0/openshift.jar /opt/app/bin/

COPY startService.sh /opt/app/bin/

RUN chgrp -R 0 /opt/app && \
    chmod -R g=u /opt/app && \
    chmod 777 /opt/app/bin/startService.sh

USER 1001

#Run the app using executable jar
CMD /opt/app/bin/startService.sh