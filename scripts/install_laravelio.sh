#! /bin/bash

sudo apt install -y \
lsb-release software-properties-common

sudo add-apt-repository -y ppa:ondrej/php
sudo apt update

sudo apt install -y php8.2 php8.2-{common,curl,mbstring,xml,mysql}

sudo apt install -y composer

sudo apt install -y npm

sudo apt install default-mysql-client -y

git clone https://github.com/laravelio/laravel.io.git

cd laravel.io/

composer install

sed -i 's/DB_PASSWORD=password/DB_PASSWORD=${DB_PASS}/' .env.example
RUN sed -i '/^DB_PASSWORD=/a DB_HOST=${DB_HOST}' .env.example
RUN sed -i '/^DB_HOST=/a DB_CONNECTION=${DB_CONNECTION}' .env.example
RUN sed -i '/^DB_CONNECTION=/a DB_DATABASE=${DB_DATABASE}' .env.example
RUN sed -i 's/DB_USERNAME=root/DB_USERNAME=${DB_USER}/' .env.example
mv .env.example .env

# mudar .env pra adicionar
# DB_DATABASE=laravel
# DB_USERNAME=vagrant
# DB_PASSWORD=12345
# DB_HOST=192.168.56.102

composer setup

php artisan serve --host 0.0.0.0