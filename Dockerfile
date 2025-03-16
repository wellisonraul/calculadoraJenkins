# Etapa 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

ARG data1
ARG data2

ENV DATA1=$data1
ENV DATA2=$data2


# Define o diretório de trabalho
WORKDIR /src


RUN echo printenv

# Copia o arquivo de projeto e restaura as dependências
COPY . .

RUN dotnet build

RUN dotnet test

ENTRYPOINT ["dotnet", "run", "sleep 300"]