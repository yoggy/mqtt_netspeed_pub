#!/usr/bin/ruby
#
# mqtt_netspeed_pub.rb - Download speed measurement & publish the result using MQTT.
#

require 'rubygems'
require 'mqtt'
require 'json'
require 'time'
require 'pit'

$config = Pit.get("mqtt_pub", :require => {
  "remote_host" => "mqtt.example.com",
  "remote_port" => 1883,
  "username"    => "username",
  "password"    => "password",
  "topic"       => "topic",
  "url"         => "http://example.com/",

})

$conn_opts = {
        remote_host: $config["remote_host"],
        remote_port: $config["remote_port"].to_i,
        username:    $config["username"],
        password:    $config["password"],
}

def get_network_speed
  # kbps
  str = `ab -c 1 -n 1 #{$config['url']} 2>&1 | grep rate | awk '{print $3}'`

  val = 0.0
  if !str.nil? || str != "" 
    val = str.to_f
  end
  val
end

def publish_network_speed
  speed_kbps = get_network_speed

  h = {}
  h["speed_kbps"] = speed_kbps
  json_str = JSON.generate(h)

  puts json_str

  MQTT::Client.connect($conn_opts) do |c|
     c.publish($config["topic"], json_str)
  end
end

publish_network_speed


