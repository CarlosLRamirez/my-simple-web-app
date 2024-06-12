
En tu Máquina Virtual:

mkdir ~/temp-webapp
sudo mkdir -p /var/www/my-webapp
sudo mv ~/temp-webapp/* /var/www/my-webapp/
sudo chown -R www-data:www-data /var/www/my-webapp


sudo nano /etc/nginx/sites-available/my-webapp

server {
    listen 80;
    server_name 172.16.101.128;

    root /var/www/my-webapp;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}


sudo ln -s /etc/nginx/sites-available/my-webapp /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx


## Instrucciónes de Despliegue Manual en el servidor NGINX



Subir archivos a una carpeta temporal

```shell
scp index.html style.css script.js ubuntu@172.16.101.128:~/temp-webapp/
```
Mover archivos en el servidor NGINX a la carpeta de la aplicación web, y reinciar el servidor

```shell
sudo mv ~/temp-webapp/* /var/www/my-webapp/
sudo systemctl restart nginx
```

## Crear un nuevo respositorio en Github

- Haz clic en el botón + en la esquina superior derecha y selecciona "New repository".
- Ingresa el nombre del repositorio, por ejemplo, my-webapp.
- Opcional: Agrega una descripción.
- Puedes dejar el repositorio como público o privado.
- No inicialices el repositorio con un README, .gitignore, o licencia, ya que lo haremos desde la línea de comandos.
- Haz clic en "Create repository".

## Convertir el directorio local a un repo de Git y sincronizarlo con Github


Inicializar el Repositorio de Git Localmente
```bash
cd ~/projects/my-web-app
git init
git add .
git commit -m "Initial commit"
```
Conectar el Repositorio Local a 

```bash
git remote add origin https://github.com/CarlosLRamirez/my-simple-web-app.git
git branch -M main
git push -u origin main
```
