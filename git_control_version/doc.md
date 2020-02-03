# CURSO GIT

## Flujo de trabajo básico
![CAT](https://raw.githubusercontent.com/edynsoncoronado/tux_the_penguin/master/src/images/gitflow.png)
### Estado ------------ Area
1. Untracked ---------> Directorio de trabajo
1. Tracked -----------> Staging
1. VersionadoLocal ---> Repositorio Local
1. VersionadoGlobal --> Versionado Remoto

## Configuración
## Git reset vs Git rm
## Flujo de trabajo con repositorio remoto
1.	Clonar repositorio
1.	Modificar url origin del repositorio
1.	Agregar tag
1.	Manejo de ramas
1.	Agregar colaboradores al proyecto
1.	Pull Requests
1.	.gitignore
1.	readme.md
##	Github.io 
##	Tricks
1.	Rebase
1.	Stash
1.	Git Clean
1.	Git Cherry-pick
1.	--amend
1.	Git reset y reflog
1.	Git grep
1.	Git shortlog
1.	Git blame


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
