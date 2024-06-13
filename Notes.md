# Laboratorio 1 - Aplicación Web en NGINX (Manual)

En este laboratorio se describe el paso a paso para desplegar una aplicación web simple en un servidor NGINX, en este caso el 
proceso se hará manual, mediante un pull del codigo de un repositirio en Github.

En este caso aún no se aplica ningun proceso de CI/CD, pero considero que es importante poder experimentar el proceso para entennder de mejor manera al momento de que lo vayamos a automaitzar.

## 1. Crear un nuevo respositorio en Github

- Haz clic en el botón + en la esquina superior derecha y selecciona "New repository".
- Ingresa el nombre del repositorio, por ejemplo, my-webapp.
- Opcional: Agrega una descripción.
- Puedes dejar el repositorio como público o privado.
- No inicialices el repositorio con un README, .gitignore, o licencia, ya que lo haremos desde la línea de comandos.
- Haz clic en "Create repository".

## 2. Convertir el directorio local a un repo de Git y sincronizarlo con Github

El directorio donde tengamos el codigo de la aplicacion web (archivos html, css, js), lo convertimoos en un repositorio de Git y los sincronizaos con el repositirio remoto recien creado de Github.

- Inicializar el Repositorio de Git Localmente
```bash
cd ~/projects/my-web-app
git init
git add .
git commit -m "Initial commit"
```
- Conectar el Repositorio Local a Github

```bash
git remote add origin https://github.com/CarlosLRamirez/my-simple-web-app.git
git branch -M main
git push -u origin main
```


## 3. Instalación de NGINX en el servidor Ubuntu

TODO: Agregar el paso a paso

## 4. Configuración del sitio con la aplicaión Web en el servidor NGINX 

- Crear el directorio donde estara ubicada la aplicación Web  
```
sudo mkdir -p /var/www/my-webapp
```
- Modificar el archivo de configuración de sitios de NGINX
```
sudo nano /etc/nginx/sites-available/my-webapp
```

- Debe quedar con el siguiente contenido
 ```
 server {
    listen 80;
    server_name 172.16.101.128;

    root /var/www/my-webapp;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
} 
```

Cambiar server_name y la ip por el nombre del servidor y el url del servidor

- Completar la configuración de NGINX y reiniciar el servidor
```
sudo ln -s /etc/nginx/sites-available/my-webapp /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

## 5. Clonar el repositorio de la aplicación web en el servidor NGINX

- Cambiar el propietario del directorio
```
sudo chown -R ubuntu:ubuntu /var/www/my-webapp
```

- Cambiar los permisos del directorio
```
sudo chmod -R 755 /var/www/my-webapp
```
- Verificar el acceso a Github desde el servidor
```
ssh -T git@github.com
```

Se deveria ver un mensaje de bienvenida de GitHub si tu configuración SSH es correcta. En caso contrario se debe agregar una SSH Key en Github

## 6. Flujo para actualizar y re-desplegar la aplicación web.

Cuando hayamos echo un cambio en la aplicación web, ejemplo modificar el codigo html, debemos agregar los cambios, realizar un commit al repostiro y un push al repositirio remoto en Github

Esto es en la PC local, o donde estemos trabajando el desarrollo de la aplicación

```shell
cd  ~/projects/my-web-app
git add .
git commit -m "Update web app"
git push origin main
```

En el servidor NGINX ahora debemos hacer un pull del repositiro para actualizar el código de la aplicación web
```shell
cd /var/www/my-webapp
git pull origin main
```
Reiniciar el servidor NGINX si es necesario
```shell
sudo systemctl restart nginx
```

