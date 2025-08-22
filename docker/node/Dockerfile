FROM node:20-alpine

# Copia o entrypoint para dentro da imagem
COPY node_entrypoint.sh /usr/local/bin/node_entrypoint.sh

# Converte o arquivo para o formato Unix e dá permissão de execução
# O ideal é salvar o arquivo php_entrypoint.sh com o formato de linha (LF) correto no seu repositório.
# Se não for possível, o comando abaixo resolve.
RUN apk add --no-cache dos2unix && \
    dos2unix /usr/local/bin/node_entrypoint.sh && \
    apk del dos2unix && \
    chmod +x /usr/local/bin/node_entrypoint.sh

RUN apk add --no-cache netcat-openbsd

WORKDIR /var/www/html

# Define o entrypoint
ENTRYPOINT ["/usr/local/bin/node_entrypoint.sh"]

CMD ["npm", "run", "dev"]