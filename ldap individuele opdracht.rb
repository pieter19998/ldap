require 'rubygems'
require 'net/ldap'

puts "enter a ldap address"
address = gets.chomp
puts "enter a first name"
name = gets.chomp
puts "enter a file name"
file = gets.chomp

begin
  ldap = Net::LDAP.new :host => address,
                       :port => 389,
                       :auth => {
                           :method => :anonymous,
                       }

  cn_filter = Net::LDAP::Filter.eq("ou", "Medical School - Faculty and Staff")
  ou_filter = Net::LDAP::Filter.eq("cn", "#{name}*")
  composite_filter = Net::LDAP::Filter.join(cn_filter, ou_filter)

  ldap.search(:base => "", :filter => composite_filter) do |entry|
    entry.each do |attribute, values|
      if attribute.to_s == "mail"
        entry.each do |attribute, values|
          File.open("#{file}.txt", 'a') { |f| f.write("#{attribute}: #{values[0]}\n") }
        end
        File.open("#{file}.txt", 'a') { |f| f.write("\n") }
      end
    end
  end
rescue
  puts "can't connect to LDAP address"
end