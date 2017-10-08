
# Micro-rhythms 
is a bio-driven installation where small variations in voltage inside microbial cells generate combining arrays of light patterns. A pattern recognition algorithm detects matching sequences and turns them in to sound. The algorithm written in Python uses three Raspberry Pi cameras with Open Computer Vision to track light changes creating a real-time graphic score for an octophonic audio system to be played with SuperCollider. The cells are fuelled using soil samples from every place where the piece is presented, growing harmless bacteria that clean their environment and produce the micro signal that detonates all the processes in the piece. Understood as an interspecies system, the installation amplifies the microvoltage produced by these microscopic organisms and transduces their oscillations into pure electronic signals with which they create an audiovisual system that evokes the origins of coded languages.

https://vimeo.com/190665110

![the system](https://github.com/interspecifics/micro-ritmos/blob/master/img/28092016-IMG_4917.jpg?raw=true)

# HARDWARE.
- RaspberryPi B+
- Camara module for raspberry 
- Micro sd cards  
- Arduino
- Celda bacteriana
- Arreglo de relays
- Lamparas
- MOTU
- 8 loudspeakers


![the system](https://github.com/interspecifics/micro-ritmos/blob/master/img/micro_ritmos_1.jpg?raw=true)



# CONFIGURACIÓN RASPBERRY

1 - Instalar OpenCV:
http://www.pyimagesearch.com/2015/02/23/install-opencv-and-python-on-your-raspberry-pi-2-and-b/:

2 - Nombrar la raspberry como raspi1.local modificando su nombre.

> ssh pi@raspi1.local
> ssh pi@raspi2.local
> ssh pi@raspi3.local

> pass: 1234

navegar:
> cd /micro-ritmos/python/lightdetector

comando:

> sudo python light_mssgsM.py 1 (el número cambia segundo el número de pi)
