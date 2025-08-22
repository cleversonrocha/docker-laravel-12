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

# Verifica se node_modules existe
if [ ! -d "node_modules" ]; then
    echo "node_modules não encontrado. Instalando dependências..."
    npm install
    echo "Dependências instaladas com sucesso."
else
    echo "node_modules já existe. Pulando npm install."
fi

# Executa o comando passado como argumento ao script;
exec "$@"
