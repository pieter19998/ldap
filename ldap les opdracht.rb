require 'rubygems'
require 'net/ldap'

ldap = Net::LDAP.new :host => "ldap.itd.umich.edu",
                     :port => 389,
                     :auth => {
                         :method => :anonymous,
                     }

filter = Net::LDAP::Filter.eq("cn", "Amy Newman")


ldap.search(:base => "", :filter => filter) do |entry|
  entry.each do |attribute, values|

    if attribute.to_s == "mail"
      print  "   #{attribute}: "
      values.each do |value|
        puts "#{value}"
      end
    end
  end
end