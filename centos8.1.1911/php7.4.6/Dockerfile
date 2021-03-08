FROM centos:8.1.1911

LABEL maintainer="梓月网络 <lxs@ziyuewl.com>" \
      reference="https://github.com/ziyuewl/lnmp/centos8.1.1911/php" \
      centos=8.1.1911 \
      nginx=1.18.0 \
      php=7.4.6 \
      mariadb=10.4.13-linux-glibc_214

#   更新系统、安装依赖
RUN dnf -y update &> /dev/null \
    && dnf -y upgrade &> /dev/null \
    && dnf -y install \
       wget \
       gcc-c++ \
       make \
       systemd-devel \
       libacl-devel \
       valgrind-devel \
       libxml2-devel \
       krb5-devel \
       openssl-devel \
       sqlite-devel \
       bzip2-devel \
       curl-devel \
       glib2-devel \
       libffi-devel \
       libpng-devel \
       libwebp-devel \
       libjpeg-devel \
       libXpm-devel \
       freetype-devel \
       gmp-devel \
       libicu-devel \
       openldap-devel \
       net-snmp-devel \
       expat-devel \
       libxslt-devel \
       libzip-devel &> /dev/null \

    && dnf -y --enablerepo=PowerTools install \
       enchant-devel \
       oniguruma-devel \
       aspell-devel \
       libedit-devel &> /dev/null \
    
    && cd /tmp \

#   下载php和其它依赖
    && wget -c http://ftp.ntu.edu.tw/php/distributions/php-7.4.6.tar.xz &> /dev/null \
    && wget -c https://mirrors.aliyun.com/epel/8/Everything/x86_64/Packages/l/libc-client-2007f-24.el8.x86_64.rpm &> /dev/null \
    && wget -c https://mirrors.aliyun.com/epel/8/Everything/x86_64/Packages/u/uw-imap-devel-2007f-24.el8.x86_64.rpm &> /dev/null \
    && wget -c https://mirrors.aliyun.com/epel/8/Everything/x86_64/Packages/l/libtidy-5.6.0-5.el8.x86_64.rpm &> /dev/null \
    && wget -c https://mirrors.aliyun.com/epel/8/Everything/x86_64/Packages/l/libtidy-devel-5.6.0-5.el8.x86_64.rpm &> /dev/null \
    && wget -c https://mirrors.aliyun.com/centos/8.1.1911/cloud/x86_64/openstack-train/Packages/l/libsodium-1.0.18-2.el8.x86_64.rpm &> /dev/null \
    && wget -c https://mirrors.aliyun.com/centos/8.1.1911/cloud/x86_64/openstack-train/Packages/l/libsodium-devel-1.0.18-2.el8.x86_64.rpm &> /dev/null \
    && wget -c https://mirrors.aliyun.com/epel/8/Everything/x86_64/Packages/l/libargon2-20171227-3.el8.x86_64.rpm &> /dev/null \
    && wget -c https://mirrors.aliyun.com/epel/8/Everything/x86_64/Packages/l/libargon2-devel-20171227-3.el8.x86_64.rpm &> /dev/null \

#   安装依赖
    && rpm -ivh libc-client-2007f-24.el8.x86_64.rpm &> /dev/null \
    && rpm -ivh uw-imap-devel-2007f-24.el8.x86_64.rpm &> /dev/null \
    && rpm -ivh libtidy-5.6.0-5.el8.x86_64.rpm &> /dev/null \
    && rpm -ivh libtidy-devel-5.6.0-5.el8.x86_64.rpm &> /dev/null \
    && rpm -ivh libsodium-1.0.18-2.el8.x86_64.rpm &> /dev/null \
    && rpm -ivh libsodium-devel-1.0.18-2.el8.x86_64.rpm &> /dev/null \
    && rpm -ivh libargon2-20171227-3.el8.x86_64.rpm &> /dev/null \
    && rpm -ivh libargon2-devel-20171227-3.el8.x86_64.rpm &> /dev/null \

#   php解压、编译、安装
    && tar -xJf php-7.4.6.tar.xz \
    && cd php-7.4.6 \

    && ./configure \
       --prefix=/usr/local/php \
       --with-config-file-path=/usr/local/php/etc \
       --with-libdir=lib64 \
       --disable-rpath \
       --enable-re2c-cgoto \
       --enable-embed \
       --enable-fpm \
       --with-fpm-user=nginx \
       --with-fpm-group=nginx \
       --with-fpm-systemd \
       --with-fpm-acl \
       --with-valgrind \
       --enable-rtld-now \
       --disable-short-tags \
       --with-openssl \
       --with-kerberos \
       --with-system-ciphers \
       --with-pcre-jit \
       --with-zlib \
       --enable-bcmath \
       --with-bz2 \
       --enable-calendar \
       --with-curl \
       --with-enchant \
       --enable-exif \
       --with-ffi \
       --enable-ftp \
       --with-openssl-dir \
       --enable-gd \
       --with-webp \
       --with-jpeg \
       --with-xpm \
       --with-freetype \
       --enable-gd-jis-conv \
       --with-gettext \
       --with-gmp \
       --with-mhash \
       --with-imap \
       --with-imap-ssl \
       --enable-intl \
       --with-ldap \
       --with-ldap-sasl \
       --enable-mbstring \
       --with-mysqli=mysqlnd \
       --with-mysql-sock \
       --enable-pcntl \
       --with-pdo-mysql=mysqlnd \
       --with-zlib-dir \
       --with-pspell \
       --with-libedit \
       --with-readline \
       --enable-shmop \
       --with-snmp \
       --enable-soap \
       --enable-sockets \
       --with-sodium \
       --with-password-argon2 \
       --enable-sysvmsg \
       --enable-sysvsem \
       --enable-sysvshm \
       --with-tidy \
       --with-expat \
       --with-xmlrpc \
       --with-expat \
       --with-iconv-dir \
       --with-xsl \
       --with-zip \
       --enable-mysqlnd \
       --with-pear \
       --enable-maintainer-zts &> /dev/null \

    && make &> /dev/null \
    && make install &> /dev/null \
    && make clean &> /dev/null \

#   建立php启动用户
    && groupadd nginx && useradd -g nginx -s /sbin/nologin nginx \
    
#   配置php
    && cp php.ini-production /usr/local/php/etc/php.ini \
    && cd /usr/local/php \
    && mv etc/php-fpm.conf.default etc/php-fpm.conf \
    && mv etc/php-fpm.d/www.conf.default etc/php-fpm.d/www.conf \
    
    && sed -i '379s/expose_php = On/expose_php = Off/g' etc/php.ini \
    && sed -i '1769s/;opcache.enable=1/opcache.enable=1/g' etc/php.ini \
    && sed -i '1775s/;opcache.memory_consumption=128/opcache.memory_consumption=512/g' etc/php.ini \
    && sed -i '1778s/;opcache.interned_strings_buffer=8/opcache.interned_strings_buffer=8/g' etc/php.ini \
    && sed -i '1782s/;opcache.max_accelerated_files=10000/opcache.max_accelerated_files=10000/g' etc/php.ini \
    && sed -i '1795s/;opcache.validate_timestamps=1/opcache.validate_timestamps=1/g' etc/php.ini \
    && sed -i '1800s/;opcache.revalidate_freq=2/opcache.revalidate_freq=300/g' etc/php.ini \
    && sed -i '1871s/;opcache.file_cache=/opcache.file_cache=\/tmp/g' etc/php.ini \
    && echo 'zend_extension=/usr/local/php/lib/php/extensions/no-debug-zts-20190902/opcache.so'>>etc/php.ini \

    && chown -R nginx:nginx var/log \

#   配置支持composer
    && ln -s /usr/local/php/bin/php /usr/local/bin/php \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php &> /dev/null \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer \ 

#   清理系统
    && dnf -y remove gcc-c++ make wget &> /dev/null \
    && dnf clean all &> /dev/null \
    && rm -rf /tmp/*

USER nginx
ENV TZ="Asia/Shanghai"
VOLUME ["/usr/local/php/etc", "/usr/local/php/var/log"]
ENTRYPOINT ["/usr/local/php/sbin/php-fpm", "-F", "-y", "/usr/local/php/etc/php-fpm.conf"]