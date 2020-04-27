
dockerize() {

project_name=${PWD##*/} &&
project_directory=$(pwd -W) &&

# Copy the content from echo to file docker-compose.yml
echo "version: \"3\"
services:
  web:
      image: nginx:latest
      ports:
          - \"8080:80\"
      volumes:
          - ./:/code
          - ./site.conf:/etc/nginx/conf.d/site.conf
      depends_on:
          - php
  php:
      image: php:7.4-fpm
      volumes:
          - ./:/code
      environment:
        - MYSQL_USER=root
        - MYSQL_PASS=secret
      depends_on:
        - mysql
  mysql:
      image: mysql:5.7.20
      volumes:
        - \"db_data:/var/lib/mysql\"
      ports:
        - \"3306:3306\"
      environment:
        - MYSQL_ROOT_PASSWORD=secret
volumes:
  db_data:" > docker-compose.yml &&

echo "
-----------------------------------------------------
🐳🐳🐳🐳🐳 Docker-compose file created" && sleep 1 &&

# Copy the content from echo to file site.conf
echo "server {
    index index.php index.html;
    server_name ${project_name}.local;
    error_log  /var/log/nginx/error.log;
    access_log /var/log/nginx/access.log;
    root /code/public;

    location ~ \.php$ {
        try_files \$uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass php:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_param PATH_INFO \$fastcgi_path_info;
    }
}" > site.conf &&


echo "
🐳🐳🐳🐳 Nginx file created" && sleep 1 &&

echo "
🐳🐳🐳 Initialize Containers" && sleep 1 &&

# Run comand docker-compose up detached (-d)
docker-compose up -d &&

echo "
🐳🐳 Contaires runing" && sleep 1 &&

# In windows go where the host file is [IMPORTANT add permission to edit the file hosts]
cd /c/Windows/System32/drivers/etc &&
# Append at the end the line below to hosts file
echo "192.168.99.100   ${project_name}.local #### Added by dockerize script automatic ####" >> hosts && 

echo "
🐳 Host created" && sleep 1 &&

# Go back to project directory
cd $project_directory &&

# put in clipboard the line below
echo "http://${project_name}.local:8080" | clip &&

echo "
🎉🎉🎉 ${project_name}.local was copied to clipboard paste in browser 🎉🎉🎉
-----------------------------------------------------"

}