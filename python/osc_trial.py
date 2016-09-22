
import OSC
import time, random
client = OSC.OSCClient()
client.connect( ( '127.0.0.1', 57121 ) )
msg = OSC.OSCMessage()
msg.setAddress("/print")
msg.append(100)
msg.append(1)
client.send(msg)
