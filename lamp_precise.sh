#!/bin/bash
clear
echo "Olá $USER precione qualquer tecla para instalar apache2, php, phpmyadmin e git"
read $tecla
clear
echo " Iniciando com Update e Upgrade"
sleep 4	
	sudo apt-get update &&
	sudo apt-get -y upgrade
clear
echo "Instalando apache2 e php5 e modulos php"
sleep 4	
	sudo apt-get -y install apache2 &&
	sudo apt-get -y install php5 libapache2-mod-php5 php5-mcrypt 
clear
echo "Agora vamos fazer a instalação no Banco de Dados MySQL, Inserir senha root do banco de dados no inicio da instalação, O usuário padrão é 'root'"
sleep 4
	read -p "Entre com a senha Mysql somente uma vez::" senha
    sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $senha"
	sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $senha"
	sudo apt-get -y install mysql-server 	
clear
echo "Instalando modulos MySQL"
sleep 4
	sudo apt-get -y install libapache2-mod-auth-mysql php5-mysql &&
	sudo /etc/init.d/apache2 restart
clear
echo "instalando PHPMyAdmin, inserir a senha MySQL"
sleep 4
	read -p "Entre com a senha PHPmyadmin somente uma vez::" senha
    sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
    sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $senha"
    sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $senha"
    sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $senha"
    sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
    sudo apt-get -y install phpmyadmin
clear
echo "Instalando Vim"
sleep 4
	sudo apt-get -y install vim
clear
echo "Instalando e Configurando Git"
sleep 4
	sudo apt-get -y install git
	read -p "Entre com seu nome::" name
	git config --global user.name "$name"
	read -p "Entre com seu email::" email
	git config --global user.email "$email"
	git config --list    
clear
echo "Inserindo Permisão na pasta de desenvolvimento"
sleep 4
	sudo chmod -R 777 /var/www
clear
echo "Reiniciando apache"
sleep 4
	sudo /etc/init.d/apache2 restart
clear
echo "Obrigado $USER, até a próxima!"