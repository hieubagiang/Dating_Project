import http.server, ssl, socketserver

context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)

context.load_cert_chain("fullchain.pem") # PUT YOUR cert.pem HERE

server_address = ("localhost", 5000) # CHANGE THIS IP & PORT

handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(server_address, handler) as httpd:

httpd.socket = context.wrap_socket(httpd.socket, server_side=True)

httpd.serve_forever()

