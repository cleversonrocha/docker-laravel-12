# Ambiente Laravel 12 com Docker (Simples e Rápido)

Este projeto cria um ambiente completo para rodar o **Laravel 12** usando **Docker**.
Você não precisa instalar PHP, Composer, Node ou banco de dados na sua máquina pois o Docker faz tudo por você.

## O que vem pronto

* **PHP 8.3 com Composer e Xdebug**
* **Nginx**
* **MariaDB**
* **Node.js 20**
* **Laravel 12 instalado automaticamente na primeira vez**

## Antes de começar

* Instale o **Docker** e o **Docker Compose**
* Use um editor de código, como o **VS Code**

## Como usar

1. **Baixe este projeto**

   ```bash
   git clone https://github.com/cleversonrocha/docker-laravel-12.git
   cd docker-laravel-12
   ```

2. **Suba o ambiente**

   ```bash
   docker compose up -d --build
   ```

   Na primeira vez, o ambiente vai:

   * Instalar o Laravel dentro de `src`
   * Configurar o arquivo `.env` do Laravel
   * Aguardar o banco de dados iniciar
   * Rodar `php artisan migrate`
   * Instalar pacotes do Node e iniciar o Vite

3. **Acompanhe os logs do serviço do PHP até que exiba a mensagem "NOTICE: ready to handle connections"**
   ```bash
   docker logs php
   ```

4. **Abra no navegador**

   * Aplicação Laravel: [http://localhost:8080](http://localhost:8080)
   * Banco de dados: `localhost:3306` (usuário e senha definidos no `.env`)

5. **Parar tudo**

   ```bash
   docker compose down
   ```

## Estrutura rápida dos serviços

* **php** → roda o Laravel e o Composer
* **node** → compila os arquivos do front-end (Vite)
* **nginx** → mostra o site no navegador
* **mariadb** → banco de dados
* **dbdata** → volume que guarda os dados mesmo se você parar o container

## Debug (opcional)

Se quiser depurar o código com Xdebug no VS Code:

1. Instale a extensão [PHP Debug](https://marketplace.visualstudio.com/items?itemName=xdebug.php-debug)
2. Aperte **Ctrl+Shift+D**, escolha **"Listen for Xdebug (Docker)"** e clique no Play verde
3. Coloque um breakpoint no código (ponto vermelho na lateral do editor)
4. Acesse a aplicação pelo navegador e o código vai parar no breakpoint

## Dados do banco

O Laravel e o banco usam as mesmas credenciais, que ficam no `.env`:

* `DB_HOST=mariadb`
* `DB_PORT=3306`
* `DB_DATABASE=laravel`
* `DB_USERNAME=laravel`
* `DB_PASSWORD=laravel`
