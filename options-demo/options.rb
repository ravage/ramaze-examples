require 'rubygems'
require 'ramaze'

class MyApp
  include Ramaze::Optioned
  
  options.dsl do
    o "Application name", :name, "Ramaze DSL Demo"
    
    o "Application version",
      :version, "0.5 Alpha"
    
    sub(:db) {
      o "Database name",
        :name, "default"
        
      o "Credential login name",
        :login, "oz"
      
      o "Credential password",
        :password, "123456"
      
      o "Database host",
        :host, "localhost"
    }
  end
end

puts MyApp.options.name         #=> Ramaze DSL Demo
puts MyApp.options.version		  #=> 0.5 Alpha
puts MyApp.options.db.name	    #=> default
puts MyApp.options.db.login		  #=> oz
puts MyApp.options.db.password  #=> 123456
puts MyApp.options.db.host		  #=> localhost