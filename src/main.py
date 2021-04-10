import sys
import time

from MyMQTT.src import MyMQTT as myqtt

##########################################################################################

device_name = "device_name"
host_address = "192.168.1.1"
user_login = "hassio"
user_pass = "hassquitto"
mqtt_topic = "debug/helloworld"
mqtt_data = "hello there!"

if __name__ == "__main__":
    try:
        device_name = sys.argv[1]
        host_address = sys.argv[2]
        user_login = sys.argv[3]
        user_pass = sys.argv[4]
        mqtt_topic = sys.argv[5]
        mqtt_data = sys.argv[6]
        print("success:", device_name, host_address, user_login,user_pass,mqtt_topic, mqtt_data)
    except:
        print("FAILED!")
        quit()

# Setup client connection
client = myqtt.MyMQTT(device_name, host_address, user_login, user_pass)
client.start()
print("> setup complete.")

# Call functions & loop
print("> publishing data...")
client.publish(mqtt_topic, mqtt_data)
time.sleep(2)

# End of program, clean shutdown
client.stop()
print("> Program finished.")
time.sleep(5)

