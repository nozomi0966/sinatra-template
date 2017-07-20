require "sequel"
require "sqlite3"

module Rack
  class Lint
    def assert message, &block
    end
  end
end

DB = Sequel.sqlite('db/sensor.sqlite3')
class Sensor
  def initialize
    DB.create_table? :sensor do
        primary_key :id
        REAL :temperature
        REAL :humidity
        String :timestanp
    end
    @sensor = DB[:sensor]
  end
  def insert(temp, hum)
    t = Time.now.to_s.split(" ")
    @sensor.insert(:temperature => temp, :humidity => hum, :timestanp => t[0] + " "+ t[1])
  end
end
