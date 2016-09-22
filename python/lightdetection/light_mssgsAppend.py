"""
light_messsages 0.2
multime messages
- - - - - - - - - -
?better OSC
"""

from picamera.array import PiRGBArray
from picamera import PiCamera
from glob import glob
import numpy as np
import cv2, OSC
import time, math, io, cPickle, sys


##  object
class stateMachine:
	"""
	max(bin) -> synth
	bins -> notes
	cluster -> channel
	"""
	def __init__(self, rPi_id, lenVec=0):
		self.actCount=[0 for i in range(lenVec)]
		self.antCount=[0 for i in range(lenVec)]
		self.rPi_id = rPi_id

	def update(self, binList, l):
		for i in range( len(self.actCount) ):
			if binList[i] > 0 and self.actCount[i] == 0:
				# start da note
				#self.start_note(i, l, sum(binList)%7)
				#self.actCount[i] += 1
			    elif binList[i] > 0 and self.actCount[i] > 0:
				# keep counting
				self.actCount[i] += 1
			elif binList[i] == 0 and self.actCount[i] == 0:
				# do nothing
				continue
			elif binList[i] == 0 and self.actCount[i] > 0:
				# stop a note
				self.stop_note(i,l, sum(binList)%7, self.actCount[i])
				self.actCount[i] = 0

	def show(self):
		print self.actCount


   def stop_note(self, i, l ,s, t):
		route = "/raspi%d/" % self.rPi_id
		msg = OSC.OSCMessage()
		msg.setAddress(route)
		msg.append(s)
		msg.append(i)
		msg.append(t)
		msg.append(l)
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

def recognize(kp_vect, centroids):
	""" classify pattern on the fly """
	v = np.array(kp_vect, np.float32)
	dists = [np.linalg.norm(v - c) for c in centroids]
	return dists.index(min(dists))


##  --- ----- --- ----- --- ----- ---- ------ ---- --- - -- --- - - -- - - ##
if __name__ == "__main__":
	## const init
        rId=int(sys.argv[1])
	w=320
	h=240
	i=0
	frameR = 30
	period = 10
	posTr_x = 0
	posTr_y = 180
	binThreshold = 180
	maxVal = 255
	kp_bin = []
	nD=[]
	track = create_blank(w, 50, rgb_color=(0,0,0))
	SM = stateMachine(rId, w/10)

	## osc init
	send_addr = '192.168.1.55', 57121
	#send_addr = "localhost", 8300

	cOsc = OSC.OSCClient()
	cOsc.connect(send_addr)

	## ml init
	n_clusters = 6
	means = cPickle.load(open('centroids.cpk','r'))

	# detector init
	pp=cv2.SimpleBlobDetector_Params()
	pp.minThreshold=208
	pp.maxThreshold=255
	pp.filterByArea=True
	pp.minArea=50
	pp.maxArea=1000
	pp.filterByColor=True
	pp.blobColor=255
	pp.filterByCircularity=False
	pp.filterByConvexity=False
	pp.filterByInertia=False
	detector = cv2.SimpleBlobDetector(pp)

	with PiCamera() as cam:
		cam.resolution = (w, h)
		cam.framerate = frameR
		cam.contrast = 100
		cam.brightness = 20
		#cam.start_preview()
		time.sleep(2)
		stream = PiRGBArray(cam)
		## capture loop
		for foo in cam.capture_continuous(stream, format="bgr", use_video_port=True):
			try:
				actImg = stream.array
				gImg = cv2.cvtColor(actImg,cv2.COLOR_BGR2GRAY)
				img = cv2.resize(gImg, (0,0), fx=1.0, fy=1.0)
			except:
				print "ouch"
				continue
																# preprocess
			bImg = cv2.medianBlur(img, 11)
			th, tImg = cv2.threshold(bImg, binThreshold, maxVal, cv2.THRESH_BINARY);
			keyPoints = detector.detect(tImg)
			kp_coo = [k.pt for k in keyPoints]
																# bin & count
			kp_bin = binarize_keypoints(10, w, kp_coo)
			cluster = recognize(kp_bin, means)
			print i,"[",cluster,"] - ",kp_bin
			SM.update(kp_bin, cluster)
			#SM.show()
																# track & ntes
			cv2.rectangle(track, (i%w, 0), (i%w, 50), (0,0,0))
			for k in keyPoints:
				cv2.rectangle(track, (i%w, int(k.pt[0]*(50.0/w))), (i%w, int(k.pt[0]*(50.0/w))+2), (255,255,255))
			tImg[ posTr_y:posTr_y+track.shape[0], posTr_x:posTr_x+track.shape[1] ] = track
			#cv2.imshow(" lights! ", tImg)
			i = i+1
																# stop vIn
			stream.seek(0)
			stream.truncate()
																# self training
			if (i > frameR*period):
				if ( len(nD)<1000 ):
					nD.append(kp_bin)
				else:
					print "< TRRainNing >"
					try:
						samples = np.array(nD, np.float32)
						temp, clusters_label, means = cv2.kmeans(data=np.asarray(samples),
																	K=n_clusters,
																	bestLabels=None,
																	criteria=(cv2.TERM_CRITERIA_EPS | cv2.TERM_CRITERIA_MAX_ITER, 1, 100),
																	attempts=1,
																	flags=cv2.KMEANS_RANDOM_CENTERS)
						cPickle.dump(nD, open('last_data.cpk','w'))
						cPickle.dump(means, open('centroids.cpk','w'))
						nD = []
						i=0
					except:
						print "can't train w/dat"
						nD = [];
						continue

																# if q quit
			key = cv2.waitKey(1) & 0xFF
			if key == ord("q"):
				break

		## exit
		cv2.destroyAllWindows()
