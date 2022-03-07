FROM amazonlinux:2

RUN mkdir -p /root/.config/NuGet && mkdir -p /root/.nuget/NuGet

COPY NuGet.Config /root/.nuget/NuGet/NuGet.Config

RUN ln -s /root/.nuget/NuGet/NuGet.Config /root/.config/NuGet/NuGet.Config

RUN yum install which wget tar gzip libicu60 -y 

RUN yum install -y gcc-c++ make && \
    curl -sL https://rpm.nodesource.com/setup_16.x | bash - && \
    yum install nodejs -y

RUN curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin -c 6.0

ENV PATH="${PATH}:/root/.dotnet"

RUN yum install python3 -y && \
    curl -O https://bootstrap.pypa.io/get-pip.py && \
    python3.7 get-pip.py --no-warn-script-location && \
    pip3 install awscli


RUN python3 --version && \
    node -e "console.log('Running Node.js ' + process.version);" 

