Started Update UTMP about System Runlevel Changes...

Solution1:
https://forums.kali.org/showthread.php?31257-No-Boot-system-hang-on-quot-Started-Update-UTMP-about-System-Runlevel-Changes-quot&fbclid=IwAR0NtHwL_6mb0RkJJXQLbRX5u2qPZ_zwLkBrbcJ4pp7jENXVLe_DWbvk_J8
- use alt+f2 and login into a separate terminal session
- remove gnome with
$sudo apt-get autoremove gnome-core gnome-shell gnome-session
- reinstall it 
$sudo apt-get install gnome-core gnome-shell gnome-session
- reboot

Solution2:
https://www.youtube.com/watch?v=kM__yadgbek&feature=youtu.be&fbclid=IwAR1NlGkUg1DqF0xsMsx4vQ82rVMck1-Qnmr8fB7gNzrBfGu8L4AAS_g-NmY
- alt+f2 go to root user login with CLI and login root with your password.
$ apt-get update
$ apt-get upgrade
$ updatedb
$ dpkg --configure -a
$ update-grub
$ startx

Solution3:
My solution!
- alt+f2 no me funcionó, probé alt+f[1-12], no recuerdo cual me funcionó, pero creo que fue alt+f4
- ya en la console:
$ apt-get update
$ apt-get upgrade
$ updatedb
- el dpkg y update-grup no le dí, porque mi problema inicial era que no me cargaba las extensiones en tweaks para poder habilitar y deshabilitar el dash to dock (huevada que se me dio), y por ello volvì a instalar tweaks, por ello, seguro en un problema con el gnome, por eso solo necesitaba actualizar el sistema y reconfigurar el entorno de variables del sistema y el grub de booteo(si esto no funcionaba hubiera optado por la solución 1).
