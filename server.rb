require 'socket'

	host = 'localhost'
	port = 2000

server = TCPServer.open(host, port)
puts "Server started on #{host}: #{port} ..."

loop do 
	client = server.accept

	lines = []
	while (line = client.gets) && !line.chomp.empty?
		lines << line.chomp
	end
	
	puts lines

	
	filename = lines[0].gsub(/GET \//, '').gsub(/\ HTTP.*/, '')
	notfound = "file_not_found.html"

	 
	
	puts filename
	# GET /index.html HTTP/1.1e

	if File.exists?(filename)
		response_body = File.read(filename)
			
			success_header = Array.new
			success_header << ["HTTP/1.1 200 OK", "Content-Type: text/html", "Content-Length: #{response_body.length}" "Connection: close"]
			
			header1 = success_header.join("\r\n")
		
		response_success = [header1, response_body].join("\r\n\r\n")
		
		puts response_success
	else
			response_body = File.read(notfound)
  
			not_found_header = Array.new
			not_found_header << ["HTTP/1.1 404 Not Found", "Content-Type: text/plain", "Content-Length: #{response_body.length}", "Connection: close"] 
			
			header2 = not_found_header.join("\r\n")
		
		response_failure = [header2, response_body].join("\r\n\r\n")
		
		puts response_failure
	end

	client.puts response_body
	client.close 

end


