import OSC

send_addr = '127.0.0.1', 57121
c = OSC.OSCClient()
c.connect(send_addr)

msg = OSC.OSCMessage()
msg.setAddress("/print")
msg.append('hello')

c.send(msg)
