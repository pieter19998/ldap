require 'rubygems'
require 'net/ldap'

puts "enter a ldap address"
address = gets.chomp
puts "enter a first name"
name = gets.chomp

ldap = Net::LDAP.new :host => "ldap.itd.umich.edu",
# ldap = Net::LDAP.new :host => address,
                     :port => 389,
                     :auth => {
                         :method => :anonymous,
                     }

# filter = Net::LDAP::Filter.eq("cn", "Amy Newman")
# filter = Net::LDAP::Filter.eq("cn", "#{name}*")
filter = Net::LDAP::Filter.eq("cn", "aio epsilon")
treebase = "ou=User"
# treebase = "ou=Medical School"
# filter2 = Net::LDAP::Filter.eq("ou", "User")
# joined_filter = Net::LDAP::Filter.join(filter, filter2)


# ldap.search(:base => treebase, :filter => filter) do |entry|
ldap.search(:base => "", :filter => filter) do |entry|
  entry.each do |attribute, values|

    # if attribute.to_s == "mail"
      print  "   #{attribute}: "
      values.each do |value|
        puts "#{value}"
      end
    # end
  end
end
