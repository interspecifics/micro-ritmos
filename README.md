# micro-ritmos
Sistema de espacialización sonora donde utilizamos reconocimiento de patrones generados por variaciones de potencial en celdas bacterianas. El sistema selecciona distintos synthDefs y posiciones por canal en Supercollider a partir de comunicación OSC con un sistema de reconocimiento - learning machine escrito en python y que corre sobre raspberry pi. El sistema arroja una especie de partitura gráfica que se genera de forma autónoma y en tiempo real. 


#Guía de Instalación en la raspberry pi.

1 - Instalar OpenCV http://www.pyimagesearch.com/2015/02/23/install-opencv-and-python-on-your-raspberry-pi-2-and-b/:

2 - Nombrar la raspberry como raspi1.local modificando su nombre.

ssh pi@raspi1.local
ssh pi@raspi2.local
ssh pi@raspi3.local

pass: 1234


navegar:
cd /micro-ritmos/python/lightdetector

comando:

sudo python light_mssgsM.py 1 (el número cambia segundo el número de pi)
