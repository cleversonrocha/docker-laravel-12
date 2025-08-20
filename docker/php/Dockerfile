# Use a imagem base do PHP 8.3 com Alpine Linux
FROM php:8.3-fpm-alpine

# Instala dependências do sistema, extensões PHP, Xdebug e Composer
# O padrão no Alpine é instalar dependências de build como um pacote virtual e removê-las na mesma camada.
RUN apk update && \
    # Dependências permanentes (runtime)
    apk add --no-cache \
        curl \
        unzip \
        git \
        zip \
        mariadb-client \
        oniguruma \
    # Dependências de build (serão removidas no final para manter a imagem enxuta)
    && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        linux-headers \
        libxml2-dev \
        curl-dev \
        oniguruma-dev \
        mariadb-dev \
    # Instala as extensões PHP
    && docker-php-ext-install \
        ctype \
        dom \
        fileinfo \
        mbstring \
        pdo \
        pdo_mysql \
        session \
        xml \
        pcntl \
        bcmath \
    # Instala o Xdebug via PECL
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    # Remove as dependências de build que não são mais necessárias
    && apk del .build-deps \
    # Instala o Composer
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Adiciona as configurações do Xdebug
COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# Copia o entrypoint para dentro da imagem
COPY php_entrypoint.sh /usr/local/bin/php_entrypoint.sh

# Converte o arquivo para o formato Unix e dá permissão de execução
# O ideal é salvar o arquivo php_entrypoint.sh com o formato de linha (LF) correto no seu repositório.
# Se não for possível, o comando abaixo resolve.
RUN apk add --no-cache dos2unix && \
    dos2unix /usr/local/bin/php_entrypoint.sh && \
    apk del dos2unix && \
    chmod +x /usr/local/bin/php_entrypoint.sh

# Define o entrypoint
ENTRYPOINT ["/usr/local/bin/php_entrypoint.sh"]

WORKDIR /var/www/html

CMD ["php-fpm"]