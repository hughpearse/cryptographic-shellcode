#!/usr/bin/env ruby
#Ruby shell pipe AES program
#Usage: echo -ne 'Hello, World!' | ./pipe.rb

require "openssl"

cipher = OpenSSL::Cipher::Cipher.new('AES-128-CBC')
cipher.encrypt

key = cipher.random_key
iv = cipher.random_iv

plaintext = gets.chomp

ciphertext = cipher.update(plaintext) + cipher.final

puts "Key: " + key.unpack('H*').join(',')
puts "IV: " + iv.unpack('H*').join(',')
print "C-Style Key: "
key.each_byte{|b| print '\x' , b.to_s(16)}; puts " "
print "C-Style IV: "
iv.each_byte{|b| print '\x' , b.to_s(16)}; puts " "
puts "Plaintext: " + plaintext
print "Ciphertext: "
ciphertext.each_byte{|b| print '\x' , b.to_s(16)}; puts " "


