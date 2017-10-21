#!/usr/bin/env bash
cd /apollo/ && \
	rm -rf /scripts || true && \
    mkdir /scripts && \
    cp /apollo/docs/web_services/examples/groovy/*.groovy /scripts/ && \
    ./apollo clean-all && ./apollo deploy && \
    cp /apollo/target/apollo*.war /tmp/apollo.war && \
	# So we can remove ~1.6 GB of cruft from the image. Ignore errors because cannot remove parent dir /apollo/
	rm -rf /apollo/ || true && \
	# Before moving back into a standardized location (that we have write access to)
	mv /tmp/apollo.war /apollo/apollo.war
