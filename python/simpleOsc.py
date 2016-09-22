from OSC import OSCClient, OSCMessage
import random


<<<<<<< Updated upstream


OSC_RECEIVE_ADDRESS = 'local', 7000 #RASPI Adress, Outgoing Port
OSC_SEND_ADDRESS = '10.40.24.105', 57121 #MAC Adress, Incoming Port
=======
OSC_OUT_HOST = "localhost"
OSC_OUT_PORT = 57120
>>>>>>> Stashed changes

if __name__ == "__main__":
    mOscClient = OSCClient()
    mOscClient.connect( (OSC_SEND_ADDRESS) )
    mOscMessage = OSCMessage()

    try:
                    mOscMessage.setAddress("/direccion")
                    mOscMessage.append(random.random())
                    mOscMessage.append(random.random())
<<<<<<< Updated upstream
                    mOscMessage.append(random.random())
=======
>>>>>>> Stashed changes
                    mOscClient.send(mOscMessage)

    except KeyboardInterrupt:
        mOscClient.close()
    finally:
        mOscClient.close()
