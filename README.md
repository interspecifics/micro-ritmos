# micro-ritmos
sistema de espacialización sonora donde utilizamos reconocimiento de patrones generados por variaciones de potencial en celdas bacterianas. El sistema selecciona distintos synthDefs y posiciones por canal en Supercollider a partir de comunicación OSC con un sistema de reconocimiento - learning machine escrito en python y que corre sobre raspberry pi. El sistema arroja una especie de partitura gráfica que se genera de forma autónoma y en tiempo real. 

librerías instaladas

python opencv
guía de instalación:

ssh pi@raspi1.local
ssh pi@raspi2.local
ssh pi@raspi3.local

pass: 1234


navegar:

cd /micro-ritmos/python/lightdetector

comando:

sudo python light_mssgsM.py 1 (el número cambia segundo el número de pi)
