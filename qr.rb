# Write your solution here!

require "rqrcode"

def generate_qr_code(data, file_name)
  qrcode = RQRCode::QRCode.new(data)
  png = qrcode.as_png({ size: 500 })
  IO.binwrite(file_name, png.to_s)
  puts "QR code saved as #{file_name}"
end

def menu
  puts "\nQR Code Generator"
  puts "1. Generate QR Code for a URL"
  puts "2. Generate QR Code for a WiFi Network"
  puts "3. Generate QR Code for a Text Message"
  puts "4. Exit"
  print "Select an option (1-4): "
end

loop do
  menu
  choice = gets.chomp

  case choice
  when "1"
    print "Enter the URL: "
    url = gets.chomp
    url = "http://#{url}" unless url.match?(/^https?:\/\//)
    if url.match?(/^https?:\/\/[\S]+$/)
      generate_qr_code(url, "url_qr.png")
    else
      puts "Invalid URL. Please try again."
    end
  when "2"
    print "Enter the WiFi network name (SSID): "
    ssid = gets.chomp
    print "Enter the password: "
    password = gets.chomp
    print "Enter the encryption type (WPA/WEP/None): "
    encryption = gets.chomp.upcase
    encryption = "WPA" if encryption.empty? # Default to WPA
    wifi_data = "WIFI:T:#{encryption};S:#{ssid};P:#{password};;"
    generate_qr_code(wifi_data, "wifi_qr.png")
  when "3"
    print "Enter the phone number (e.g., +1234567890): "
    phone_number = gets.chomp
    print "Enter the text message: "
    message = gets.chomp
    sms_data = "SMSTO:#{phone_number}:#{message}"
    generate_qr_code(sms_data, "sms_qr.png")
  when "4"
    puts "Exiting the program. Goodbye!"
    break
  else
    puts "Invalid option. Please enter 1, 2, 3, or 4."
  end
end
