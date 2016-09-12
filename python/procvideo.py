import numpy as np
import cv2
import json
import sc
import time, threading
import OSC

FPS = 20.0
LOOP_PERIOD = 1.0/FPS
lastLoop = 0

receive_address = '192.168.1.165', 1234
s = OSC.OSCServer(receive_address)
s.addDefaultHandlers()

#OSC
# 3 GRUPOS DE 8 LAMPARAS CON UN ID: RP1 RP2 RP3
# Cada PI se indetifica para enviar un mensaje

# CADA LAMAPARA TIENE UN INDICE DE ACUERDO A SU POSICION del 0 al 7
# RELACION DE VALORES
#tiempo = envelop (por lampara)
#position = pitch (por lamapara)
#número de lamps = channel (cuantas lamparas se enciende determina el canal)
#ID del raspy = synth pallet (el id de cada PI determina el grupo de synthdefs)


def translate(value, inMin, inMax, outMin, outMax):
   """ like processing's map """
   inSpan = inMax - inMin
   outSpan = outMax - outMin
   transVal = float(value - inMin) / float(inSpan)
   return outMin + (transVal * outSpan)

def create_blank(width, height, rgb_color=(0, 0, 0)):
   """ Create new image(numpy array) filled with certain color in RGB """
   image = np.zeros((height, width), np.uint8)
   color = tuple(reversed(rgb_color))
   image[:] = 0
   return image


thresh = 250
maxValue = 255
fn = "IMG_1473.MOV"
cap = cv2.VideoCapture(fn)


# blob detection
pp=cv2.SimpleBlobDetector_Params()
pp.minThreshold=208
pp.maxThreshold=255
pp.filterByArea=True
pp.minArea=300
pp.maxArea=50000
pp.filterByColor=True
pp.blobColor=255
pp.filterByCircularity=False
pp.filterByConvexity=False
pp.filterByInertia=False

i=0
blob_list = []
detector = cv2.SimpleBlobDetector(pp)
track = image = create_blank(920, 100, rgb_color=(0,0,0))
x_off = 10
y_off = 420;


#para importar la camara del raspberry
try:
   from picamera.array import PiRGBArray
   from picamera import PiCamera


while(cap.isOpened()):
 try:
   ret, frame = cap.read()
   big=cv2.cvtColor(frame,cv2.COLOR_BGR2GRAY)
   img1 = cv2.resize(big, (0,0), fx=0.5, fy=0.5)


 except:
   break
 img2=cv2.medianBlur(img1, 11)
 th, img3 = cv2.threshold(img2, thresh, maxValue, cv2.THRESH_BINARY);
 keypoints = detector.detect(img3)
 kp_coo = [k.pt	for k in keypoints]
 blob_list.append(kp_coo)
 print i,":",len(kp_coo)
 #im_with_keypoints = cv2.drawKeypoints(img3, keypoints, np.array([]), (0,0,255), cv2.DRAW_MATCHES_FLAGS_DRAW_RICH_KEYPOINTS)
 #draw on img
 cv2.rectangle(track, (i%920, 0), (i%920, 200), (0,0,0))
 for k in keypoints:
   cv2.rectangle(track, (i%920, int(k.pt[0]/10)), (i%920, int(k.pt[0]/10)+2), (255,0,255))
 img3[y_off:y_off+track.shape[0], x_off:x_off+track.shape[1]] = track

 cv2.imshow(fn,img3)
 of = "IMG1496_PROC/"+'img_%05d.png'%(i,)
 cv2.imwrite(of, img3)
 i = i+1
 #cv2.imshow('blured_frame',im_with_keypoints)
 if cv2.waitKey(1) & 0xFF == ord('q'):
   break
json.dump(blob_list, open("keypoints"+fn[:-4]+".json",'w'))
cap.release()
cv2.destroyAllWindows()
