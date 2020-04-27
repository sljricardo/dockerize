## Dockerize 🐋🐋🐋
$ dockerize is a bash function that allows to provision a nginx, php and mysql stack in a project 

### Requirements
Docker
Windows 10
Bash

### Installation
1 - Clone Repo
2 - Enter in repo folder an run the folowing command in bash:
```bash
$ cat dockerize.sh | tee -a ~/.bashrc
```
Done!!

### Usage
1 - Create a project with public folder
2 - Create an index.php inside the public folder 
3 - Run the command ```$ dockerize ``` in terminal in folders root

### Note
You need to have permission to edit de hosts file inside c:/Windows/System32/drivers/etc