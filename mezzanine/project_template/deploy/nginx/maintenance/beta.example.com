server {
  # listen 80 deferred; # for Linux
  # listen 80 accept_filter=httpready; # for FreeBSD
  listen [::]:80;
  listen 80;

  # The host name to respond to
  server_name beta.example.com;

  # Path for static files
  root /opt/beta/example/current/maintenance;

  # try all request combinations including attempting to append .html
  location / {
    return 503;
  }

  #Specify a charset
  charset utf-8;

  # Custom 503 page
  error_page 503 /opt/beta/example/current/maintenance/index.html;


  # Include the basic h5bp config set
  include h5bp/basic.conf;
}