#!/bin/sh

# Interrompe o script se algum comando falhar;
set -e

echo "Esperando PHP estar pronto na porta 9000..."

# Testa a porta até ficar disponível
until nc -z php 9000; do
    echo "PHP ainda não está pronto..."
    sleep 2
done

echo "PHP está pronto!"

# Verifica se o diretório node_modules existe, se não existir, instala as dependências;
npm install

# Executa o comando passado como argumento ao script;
exec "$@"
