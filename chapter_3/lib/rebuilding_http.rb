require 'socket'
require 'time'

module RHTTP
  def get_request(sock)
    req_text = read_request(sock)
    RHTTP::Request.new(req_text)
  end

  def read_request(sock)
    out = ""
    loop do
      line = sock.gets
      out << line.chomp << "\n"
      return(out) if line.strip == ""
    end
  end

  def default_headers 
    { "time": "#{Time.now.httpdate}" }
  end
end

class RHTTP::Request
  attr_reader :method
  attr_reader :url
  attr_reader :http_version
  attr_reader :headers
  
  def initialize(text)
    lines = text.split %r{\r\n|\n\r|\n|\r}
    @method, @url, rest = lines[0].split(/\s/, 3)

    if rest =~ /HTTP\/(\d+)\.(\d+)/ 
      @http_version = "#{$1}.#{$2}"
    end
    @headers = lines[1..-1].join("\n")
  end
end


class RHTTP::Response
  def initialize(body,
                 version: "1.1",
                 status: 200,
                 message: "OK",
                 headers: default_headers)
    @version = version
    @status = status
    @message = message
    @headers = default_headers.merge(headers)
    @body = body
  end

def to_s
    <<RESPONSE
HTTP/#{@version} #{@status} #{@message}\r
Content-Type: text/html\r
#{@headers.map {|k,v| "#{k}: #{v}"}.join("\r\n")}
\r
#{@body}
RESPONSE
  end
end
