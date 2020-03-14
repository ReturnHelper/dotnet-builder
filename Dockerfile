FROM amazonlinux:2

RUN mkdir -p ~/.config/NuGet && mkdir -p ~/.nuget/NuGet

COPY NuGet.Config ~/.nuget/NuGet/NuGet.Config

RUN ln -s ~/.nuget/NuGet/NuGet.Config ~/.config/NuGet/NuGet.Config

RUN yum install which wget -y

RUN dotnet_ver=3.1 && \
    yum history sync && \    
    rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm && \
    yum install dotnet-sdk-$dotnet_ver -y

RUN yum install python3 -y && \
    curl -O https://bootstrap.pypa.io/get-pip.py && \
    python3.7 get-pip.py --user && \
    pip3 install awscli

RUN mkdir -p /tmp/mono && \
    cd /tmp/mono && \
    yum install -y yum-utils && \
    rpm --import "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF" && \
    yum-config-manager --add-repo http://download.mono-project.com/repo/centos/ && \
    yum clean all && \
    yum makecache && \
    yum install -y mono-complete && \
    rm -rf /tmp/mono

RUN curl -o /usr/local/bin/nuget.exe https://dist.nuget.org/win-x86-commandline/latest/nuget.exe && \
    echo 'alias nuget="mono /usr/local/bin/nuget.exe"' >> ~/.bashrc

CMD [ "dotnet","--info" ]

