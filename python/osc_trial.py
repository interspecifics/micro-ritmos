
import OSC
import time, random
client = OSC.OSCClient()
client.connect( ( '192.168.1.132', 57120 ) )
msg = OSC.OSCMessage()
msg.setAddress("/print")
msg.append(100)
msg.append(1)
client.send(msg)
