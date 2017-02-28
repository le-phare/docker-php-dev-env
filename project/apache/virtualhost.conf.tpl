{{ $DOCUMENT_ROOT := default .Env.DOCUMENT_ROOT "/var/www/html" }}
{{ $APACHE_LOG_DIR := default .Env.APACHE_LOG_DIR "/var/log/apache2" }}
{{ $APACHE_LOG_PREFIX := default .Env.APACHE_LOG_PREFIX "html" }}

LoadModule deflate_module modules/mod_deflate.so
LoadModule rewrite_module modules/mod_rewrite.so
LoadModule expires_module modules/mod_expires.so
LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so

<VirtualHost *:80>
    UseCanonicalName Off

    RewriteEngine on
    RewriteCond {{ $DOCUMENT_ROOT }}/%{REQUEST_FILENAME} -f
    RewriteRule ^/(.*\.php(/.*)?)$ fcgi://php:9000{{ $DOCUMENT_ROOT }}/$1 [L,P]

    DirectoryIndex index.php

    DocumentRoot {{ $DOCUMENT_ROOT }}
    <Directory {{ $DOCUMENT_ROOT }}>
        Options FollowSymlinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog {{ $APACHE_LOG_DIR }}/{{ $APACHE_LOG_PREFIX }}_error.log
    CustomLog /proc/self/fd/1 combined
</VirtualHost>
