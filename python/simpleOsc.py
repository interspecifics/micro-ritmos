from OSC import OSCClient, OSCMessage
import random


OSC_OUT_HOST = 10.40.24.105
OSC_OUT_PORT = 57121

if __name__ == "__main__":
    mOscClient = OSCClient()
    mOscClient.connect( (OSC_OUT_HOST,OSC_OUT_PORT) )
    mOscMessage = OSCMessage()

    try:
                    mOscMessage.setAddress("/direccion")
                    mOscMessage.append(random.random())
                    mOscMessage.append(random.random())
                    mOscMessage.append(random.random())
                    mOscClient.send(mOscMessage)

    except KeyboardInterrupt:
        mOscClient.close()
    finally:
        mOscClient.close()
