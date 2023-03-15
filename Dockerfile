FROM mcr.microsoft.com/dotnet/sdk:7.0.202-jammy

RUN mkdir -p /root/.config/NuGet && mkdir -p /root/.nuget/NuGet

COPY NuGet.Config /root/.nuget/NuGet/NuGet.Config

RUN ln -s /root/.nuget/NuGet/NuGet.Config /root/.config/NuGet/NuGet.Config

RUN apt update -y

RUN apt install wget -y 

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt install nodejs -y

RUN dotnet tool install Nuke.GlobalTool --global

RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py --no-warn-script-location && \
    pip3 install awscli


RUN python3 --version
RUN node -e "console.log('Running Node.js ' + process.version);" 

