"""
to track lights
"""

from picamera.array import PiRGBArray
from picamera import PiCamera
from glob import glob
import numpy as np
import cv2, OSC
import time, math


##  object
class stateMachine:
	def __init__(self, lenVec=0):
		self.actCount=[0 for i in range(lenVec)]
		self.antCount=[0 for i in range(lenVec)]

	def update(self, binList):
		for i in range( len(self.actCount) ):
			if binList[i] > 0 and self.actCount[i] == 0:
				# start da note
				self.start_note(i)
				self.actCount[i] += 1
			elif binList[i] > 0 and self.actCount[i] > 0:
				# keep counting
				self.actCount[i] += 1
			elif binList[i] == 0 and self.actCount[i] == 0:
				# do nothing
				continue
			elif binList[i] == 0 and self.actCount[i] > 0:
				# stop a note
				self.stop_note(i,self.actCount[i])
				self.actCount[i] = 0

	def show(self):
		print self.actCount

	def start_note(self, i):
		msg = OSC.OSCMessage()
		msg.setAddress("/start_note")
		msg.append(i)
		cOsc.send(msg)

	def stop_note(self, i, t):
		msg = OSC.OSCMessage()
		msg.setAddress("/stop_note")
		msg.append(i)
		msg.append(t)
		cOsc.send(msg)


##  functions
def translate(value, inMin, inMax, outMin, outMax):
    """ like processing's map """
    inSpan = inMax - inMin
    outSpan = outMax - outMin
    transVal = float(value - inMin) / float(inSpan)
    return outMin + (transVal * outSpan)

def create_blank(w, h, rgb_color=(0, 0, 0)):
    """ create new image(numpy array) filled with certain color in rgb """
    image = np.zeros((h, w), np.uint8)
    color = tuple(reversed(rgb_color))
    image[:] = 0
    return image

def binarize_keypoints (binSize, w, kpList):
	""" the other binarization """
	nBin = int (w / binSize)
	a = np.zeros(nBin, int)
	for kp in kpList:
		cBin = kp[0] / binSize
		a[cBin] = 1
	return a



##  --- ----- --- ----- --- ----- ---- ------ ---- --- - -- --- - - -- - - ##
if __name__ == "__main__":
	## const init
	w=640
	h=480
	i=0
	posTr_x = 0
	posTr_y = 360
	binThreshold = 180
	maxVal = 255
	kp_bin = []
	track = create_blank(w, 100, rgb_color=(0,0,0))
	SM = stateMachine(w/20)

	## osc init
	send_addr = "192.168.0.10", 8338
	cOsc = OSC.OSCClient()
	cOsc.connect(send_addr)

	## capture init
	cam = PiCamera()
	cam.resolution = (w, h)
	cam.framerate = 30
	cam.contrast = 100
	cam.brightness = 20
	rawCapture = PiRGBArray(cam, size=(w, h))
	time.sleep(0.1)

	# detector init
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
	detector = cv2.SimpleBlobDetector(pp)

	## capture loop
	for frame in cam.capture_continuous(rawCapture, format="bgr", use_video_port=True):
															# update
		try:
			actImg = frame.array
			gImg = cv2.cvtColor(actImg,cv2.COLOR_BGR2GRAY)
			img = cv2.resize(gImg, (0,0), fx=1.0, fy=1.0)
		except:
			continue
															# preprocess
		bImg = cv2.medianBlur(img, 11)
		th, tImg = cv2.threshold(bImg, binThreshold, maxVal, cv2.THRESH_BINARY);
		keyPoints = detector.detect(tImg)
		kp_coo = [k.pt for k in keyPoints]
															# bin & count
		kp_bin = binarize_keypoints(20, w, kp_coo)
		SM.update(kp_bin)
		SM.show()
															# track & ntes
		cv2.rectangle(track, (i%w, 0), (i%w, w/5), (0,0,0))
		for k in keyPoints:
			cv2.rectangle(track, (i%w, int(k.pt[0]/5)), (i%w, int(k.pt[0]/5)+2), (255,255,255))
		tImg[ posTr_y:posTr_y+track.shape[0], posTr_x:posTr_x+track.shape[1] ] = track
															# show in window
		cv2.imshow("  ushldflwhtiflushldtkewhtitke", tImg)
		i = i+1
															# stop vIn
        rawCapture.truncate(0)
        key = cv2.waitKey(1) & 0xFF
        if key == ord("q"):
            break

	## exit
	cv2.destroyAllWindows()
