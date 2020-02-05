# CURSO GIT

## Flujo de trabajo básico
![CAT](https://raw.githubusercontent.com/edynsoncoronado/tux_the_penguin/master/src/images/gitflow.png)
#### Estado ------------ Area
1. Untracked ---------> Directorio de trabajo
1. Tracked -----------> Staging
1. VersionadoLocal ---> Repositorio Local
1. VersionadoGlobal --> Versionado Remoto

#### Branch y Merge
![CAT](https://raw.githubusercontent.com/edynsoncoronado/tux_the_penguin/master/src/images/gitflow2.png)

## Configuración
* git config --list
* git config --list --show-origin
* git config --global user.name “Edynson Coronado”
* git config --global user.email “edynsoncoronado@gmail.com”
* git config --global core.editor EDITOR

## Git reset vs Git rm
1. **git rm**  
Este comando nos ayuda a eliminar archivos de Git sin eliminar su historial del sistema de versiones. Esto quiere decir que si necesitamos recuperar el archivo solo debemos “viajar en el tiempo” y recuperar el último commit antes de borrar el archivo en cuestión.
    * **git rm --cached**  
    Elimina los archivos del área de Staging y del próximo commit pero los mantiene en nuestro disco duro.
    * **git rm --force**  
    Elimina los archivos de Git y del disco duro. Git siempre guarda todo.
1. **git reset**  
Este comando nos ayuda a volver en el tiempo. Pero no como git checkout que nos deja ir, mirar, pasear y volver. Con git reset volvemos al pasado sin la posibilidad de volver al futuro. Borramos la historia. No hay vuelta atrás.
    * **git reset HEAD --hard**  
    Borra todo. Todo todito, absolutamente todo. Toda la información de los commits y del área de staging se borra del historial.
    * **git reset HEAD --soft**  
    Borramos todo el historial y los registros de Git pero guardamos los cambios que tengamos en Staging, así podemos aplicar las últimas actualizaciones a un nuevo commit.
* **git reset HEAD**  
Este es el comando para sacar archivos del área de Staging.

## Flujo de trabajo con repositorio remoto
![CAT](https://raw.githubusercontent.com/edynsoncoronado/tux_the_penguin/master/src/images/gitfetch-gitmerge.png)
* **git fetch + git merge = git pull**

1.	**Agregar origin del repositorio**
    * git remote add origin *url-ssh-del-repositorio-en-github*
    * git remote -v
    * En caso suceda el siguiente error:  
    **# fatal: refusing to merge unrelated histories ::para este caso utilizar el siguiente comando:**  
        * git pull origin master --allow-unrelated-histories
        * git push origin master
    
1.	**Modificar origin del repositorio**
    * git remote set-url origin *url-ssh-del-repositorio-en-github*
1.	**Agregar tag**
    * git tag -a nombretag -m “mensaje” HEAD
    * **listar tag**  
    git tag
    * **ver la relación de tags y head del historial**  
    git show-ref --tags  
    * **subir tags al repositorio remoto**  
    git push origin --tags
    * **eliminar tag en repositorio local**  
    git tag -d nombre_tag
    * **eliminar tag en repositorio remoto**  
    git push origin :refs/tags/nombre_tag
1.	**Manejo de ramas**
    * **mostrar ramas y sus commit**  
    git show-branch
    * **mostrar ramas y sus commits con más detalle**  
    git show-branch --all
    * **interfaz gráfica para manejo de ramas**  
    gitk
1.	**Agregar colaboradores al proyecto**  
**Repositorio** > **Settings** > **Collaborators**; *y añadir el email o username de los nuevos colaboradores.*
1.	**Pull Requests**
    * git branch dev
    * git commit -a
    * **En github crear pull request dev -> master:** code review
1.	**.gitignore**  
No todos los archivos que agregas a un proyecto deberían ir a un repositorio, por ejemplo cuando tienes un archivo donde están tus contraseñas que comúnmente tienen la extensión .env o cuando te estás conectando a una base de datos; son archivos que nadie debe ver.
1.	**readme.md**  
README.md es una excelente práctica en tus proyectos, md significa Markdown es un especie de código que te permite cambiar la manera en que se ve un archivo de texto.
##	Github.io 
* **https://pages.github.com/**
##	Tricks
1.	**Rebase**  
Con rebase puedes recoger todos los cambios confirmados en una rama y ponerlos sobre otra.  
**master-----experiment**  
-----ao-----------  
-----bo-----------  
-----co-----co----  
-----|------ax----  
-----|------bx----  
-----do-----------  
    * git checkout experiment
    * git rebase master
    * git checkout master
    * git rebase experiment  
**--master---**  
-----ao-----  
-----bo-----  
-----co-----  
-----do-----  
-----ax-----  
-----bx-----  
1.	**Stash**
    * git stash
    * git stash list
    * git stash pop
    * git stash branch english-version
    * git stash drop
1.	**Git Clean**
    * Para saber qué archivos vamos a borrar tecleamos: **git clean --dry-run**
    * Para borrar todos los archivos listados (que no son carpetas) tecleamos: **git clean -f**
1.	**Git Cherry-pick**
    * Existe un mundo alternativo en el cual vamos avanzando en una rama pero necesitamos en master uno de esos avances de la otra rama, para eso utilizamos el comando: **git cherry-pick HEAD**.
1.	**--amend**
    * A veces hacemos un commit, pero resulta que no queríamos mandarlo porque faltaba algo más. Utilizamos git commit --amend, *amend en inglés es remendar* y lo que hará es agregar al commit anterior los cambios que hicimos.
        * git add file
        * git commit --amend
1.	**git reflog**  
Comando para saber la historia completa del repositorio. No olvida, no perdona.
1.	**Git grep**
    * Con **git grep -n <string>** nos saldrá un output el cual nos dirá en qué línea está lo que estamos buscando.
    * Con **git grep -c <string>** nos saldrá un output el cual nos dirá cuántas veces se repite esa palabra y en qué archivo.
    * **git log -S <string>**, este retorna los commit en que el texto aparece entre los cambios, no necesariamente en el mensaje de commit.
1.	**Git shortlog**
    * Commits realizados por persona  
    **git shortlog**
    * Contador de commits realizados por persona  
    **git shortlog -sn**
    * Contador de todos los commits (incluido los borrados del historial) realizados por persona  
    **git shortlog -sn --all**
    * Contados de commits, no incluidos los merge  
    **git shortlog -sn --all --no-merges**
    * creación de alias en git  
    **git config --global alias.*contador* "shortlog -sn --all --no-merges"**  
    **git *contador***
1.	**Git blame**
    * revisar quien hizo los cambios en cada lìnes de un archivo.  
    **git blame *file***
    * el parámetro -c muestra el archivo con las tabulaciones del archivo.  
    **git blame -c *file***
    * ver documentación  
    **git blame --help**
    * visualizar de tal lìnea a tal lìnea  
    **git blame *file* -L30,50**
    * visualizar de tal lìnea a tal lìnea con las tabulaciones del archivo  
    **git blame *file* -L30,50 -c**
    * ver las rama remotas  
    **git branch -r**
    * ver ramas remotas y locales  
    **git branch -a**


1) Al invocar el comando, "git branch -a" devolverá una lista con los nombres de todas las ramas conocidas.

2) git log <branch_name>

3) Si encuentras una referencia de confirmación al punto del historial que quieres visitar, puedes utilizar el comando "git checkout" para visitar dicha confirmación.Durante el curso normal del desarrollo, el HEAD generalmente apunta a la rama master u otra rama local, pero cuando extraes una confirmación anterior, el HEAD ya no apunta a una rama: apunta directamente a la confirmación. Este estado recibe el nombre de “HEAD desasociado” (detached HEAD)

4) Visualización de una versión antigua

$ git checkout HASH

Comprobar una confirmación específica pondrá el repositorio en un estado “HEAD desasociado”. Esto significa que ya no estás trabajando en ninguna rama.
En un estado desasociado, cualquier nueva confirmación que hagas quedará huérfana cuando vuelvas a cambiar las ramas a una rama establecida.
Las confirmaciones huérfanas están listas para que el recolector de basura de Git las elimine. El recolector de basura se ejecuta en un intervalo configurado y destruye de forma permanente las confirmaciones huérfanas. Para evitar que se recojan como basura confirmaciones huérfanas, es preciso asegurarse de que se está en una rama.A partir del estado HEAD desasociado, podemos ejecutar git checkout -b new_branch_without_crazy_commit. De este modo, se creará una nueva rama llamada new_branch_without_crazy_commit y se cambiará a ese estado.

5) Deshacer una confirmación con git reset

git reset --hard HASH

6) Modificar la última confirmación

$ git add FILE

$ git commit --amend

7) Directorio de trabajo

El directorio de trabajo se sincroniza generalmente con el sistema de archivos local. Para deshacer cambios en el directorio de trabajo, puedes editar los archivos como de costumbre utilizando tu editor favorito

$ git clean

$ git reset --mixed; git reset --hard

8) índice del entorno de ensayo
* El comando git add se emplea para añadir cambios en el índice del entorno de ensayo.
* Git reset se utiliza principalmente para deshacer los cambios del índice del entorno de ensayo.
* git reset --mixed ; devolverá los cambios pendientes del índice del entorno de ensayo al directorio de trabajo.

9) deshacer cambios públicos
* Por lo general, git reset debería considerarse como un método local para deshacer acciones.
* El método preferido para deshacer un historial compartido es "git revert".

10) herramientas más utilizadas para deshacer acciones:

$ git checkout

$ git revert

$ git reset
