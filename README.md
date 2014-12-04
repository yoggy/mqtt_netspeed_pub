mqtt_netspeed_pub.rb
====
Download speed measurement & publish the result using MQTT.

how to use
====
<pre>
$ gem install mqtt
$ gem install pit

$ cd ~/work/
$ git clone https://github.com/yoggy/mqtt_netspeed_pub.git
$ cd mqtt_netspeed_pub
$ EDITOR=vi ./mqtt_netspeed_pub.rb

  #### configure MQTT parameters ####

$ crontab -e
  
  #### append this line ####
  */10 * * * *  ~/work/mqtt_netspeed_pub/mqtt_netspeed_pub.rb 2>&1 >/dev/null
</pre>


