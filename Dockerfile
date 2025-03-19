# Usa uma imagem base do Python
FROM python:3.9

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia os arquivos da aplicação para o container
COPY requirements.txt requirements.txt

# Instala as dependências do projeto
RUN pip install -r requirements.txt

# Copia o código-fonte para o container
COPY . .

# Expõe a porta 5000 para acesso externo
EXPOSE 5000

# Comando para iniciar a aplicação
CMD ["python", "app.py"]
# Usa uma imagem base do Python
FROM python:3.9

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia os arquivos da aplicação para o container
COPY requirements.txt requirements.txt

# Instala as dependências do projeto
RUN pip install -r requirements.txt

# Copia o código-fonte para o container
COPY . .

# Expõe a porta 5000 para acesso externo
EXPOSE 5000

# Comando para iniciar a aplicação
CMD ["python", "app.py"]
