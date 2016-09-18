from OSC import OSCClient, OSCMessage

OSC_OUT_HOST = "localhost"
OSC_OUT_PORT = 57120

if __name__ == "__main__":
    mOscClient = OSCClient()
    mOscClient.connect( (OSC_OUT_HOST,OSC_OUT_PORT) )
    mOscMessage = OSCMessage()

    try:
                    mOscMessage.setAddress("/direccion/")
                    mOscMessage.append('nombre')
                    mOscMessage.append('valor')
                    mOscClient.send(mOscMessage)

    except KeyboardInterrupt:
        mOscClient.close()
    finally:
        mOscClient.close()
