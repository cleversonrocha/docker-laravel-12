#!/bin/sh
set -e

# Cria projeto Laravel se não existir
if [ ! -f /var/www/html/artisan ]; then
    echo "Instalando Laravel..."
    composer create-project laravel/laravel='^12.0' /var/www/html --prefer-dist

    echo "Ajustando permissões..."
    chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

    echo "Configurando .env com variáveis do container..."
    cd /var/www/html
    sed -i "s/^DB_CONNECTION=.*/DB_CONNECTION=${MARIADB_CONNECTION}/" .env
    sed -i "s/^# DB_HOST=.*/DB_HOST=${MARIADB_HOST}/" .env
    sed -i "s/^# DB_PORT=.*/DB_PORT=${MARIADB_PORT}/" .env
    sed -i "s/^# DB_DATABASE=.*/DB_DATABASE=${MARIADB_DATABASE}/" .env
    sed -i "s/^# DB_USERNAME=.*/DB_USERNAME=${MARIADB_USER}/" .env
    sed -i "s/^# DB_PASSWORD=.*/DB_PASSWORD=${MARIADB_PASSWORD}/" .env    

    echo "Aguardando MARIADB..."
    until php -r "new PDO('mysql:host=${MARIADB_HOST};port=${MARIADB_PORT}', '${MARIADB_USER}', '${MARIADB_PASSWORD}');" 2>/dev/null; do
        echo "MARIADB (${MARIADB_HOST}) ainda não está pronto..."
        sleep 2
    done
    echo "MARIADB está pronto!" 
    echo "Instalando dependências do Laravel..."
    echo "Rodando migrations..."
    php artisan migrate 
fi   

exec "$@"
