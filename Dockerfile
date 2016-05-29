# --------------------------------------------------------------------
# |
# |
# |
# |
# | todo: godoc on specific port
# | 
FROM ubuntu
MAINTAINER Payam Naderi <naderi.payam@gmail.com>

RUN apt-get update && \
    apt-get install -y curl && \
    mkdir -p /goroot && \
    curl https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz | tar xvzf - -C /goroot --strip-components=1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables.
ENV GOROOT /goroot
ENV GOPATH /gopath
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH

# Add scripts.
ADD bin/go-build /usr/local/bin/go-build
ADD bin/go-run /usr/local/bin/go-run

# Add executable permission to scripts.
RUN chmod +x /usr/local/bin/go-*

WORKDIR /gopath
CMD ["go"]
# ----------------------------------------------------------------

ONBUILD ADD . /gopath/src/app/
ONBUILD RUN go-build
