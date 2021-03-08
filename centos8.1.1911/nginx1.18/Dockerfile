FROM centos:8.1.1911

LABEL maintainer="梓月网络 <lxs@ziyuewl.com>" \
      reference="https://github.com/ziyuewl/lnmp/centos8.1.1911/nginx" \
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
       pcre-devel \
       openssl-devel \
       libxslt-devel \
       gd-devel \
       perl-devel \
       perl-ExtUtils-Embed &> /dev/null \

    && cd /tmp \

#   下载依赖
    && wget -c http://nginx.org/download/nginx-1.18.0.tar.gz &> /dev/null \
    && wget -c https://mirrors.aliyun.com/centos/8.1.1911/AppStream/x86_64/os/Packages/libatomic_ops-7.6.2-3.el8.x86_64.rpm &> /dev/null \
    && wget -c https://mirrors.aliyun.com/centos/8.1.1911/PowerTools/x86_64/os/Packages/libatomic_ops-devel-7.6.2-3.el8.x86_64.rpm &> /dev/null \
    && wget -c https://mirrors.aliyun.com/epel/8/Everything/x86_64/Packages/g/GeoIP-GeoLite-data-2018.06-5.el8.noarch.rpm &> /dev/null \
    && wget -c https://mirrors.aliyun.com/epel/8/Everything/x86_64/Packages/g/GeoIP-1.6.12-7.el8.x86_64.rpm &> /dev/null \
    && wget -c https://mirrors.aliyun.com/epel/8/Everything/x86_64/Packages/g/GeoIP-devel-1.6.12-7.el8.x86_64.rpm &> /dev/null \

#   安装依赖
    && rpm -ivh libatomic_ops-7.6.2-3.el8.x86_64.rpm &> /dev/null \
    && rpm -ivh libatomic_ops-devel-7.6.2-3.el8.x86_64.rpm &> /dev/null \
    && rpm -ivh GeoIP-GeoLite-data-2018.06-5.el8.noarch.rpm &> /dev/null \
    && rpm -ivh GeoIP-1.6.12-7.el8.x86_64.rpm &> /dev/null \
    && rpm -ivh GeoIP-devel-1.6.12-7.el8.x86_64.rpm &> /dev/null \

#   nginx解压、编译、安装
    && tar -zxf nginx-1.18.0.tar.gz \
    && cd nginx-1.18.0 \

    && sed -i '172s/CFLAGS="$CFLAGS -g"/#CFLAGS="$CFLAGS -g"/' auto/cc/gcc \
    && sed -i '49s/Server: nginx/Server: ziyuewl.com/' src/http/ngx_http_header_filter_module.c \
    && sed -i '12s/1018000/1000000/' src/core/nginx.h \
    && sed -i '13s/1.18.0/1.00.0/' src/core/nginx.h \
    && sed -i '14s/nginx/ziyuewl.com/' src/core/nginx.h \
    && sed -i '36s/nginx/ziyuewl.com/' src/http/ngx_http_special_response.c \

    && CFLAGS=-fPIC \
       ./configure \
       --user=nginx \
       --group=nginx \
       --with-select_module \
       --with-poll_module \
       --with-threads \
       --with-file-aio \
       --with-http_ssl_module \
       --with-http_v2_module \
       --with-http_realip_module \
       --with-http_addition_module \
       --with-http_xslt_module \
       --with-http_image_filter_module \
       --with-http_geoip_module \
       --with-http_sub_module \
       --with-http_dav_module \
       --with-http_flv_module \
       --with-http_mp4_module \
       --with-http_gunzip_module \
       --with-http_gzip_static_module \
       --with-http_auth_request_module \
       --with-http_random_index_module \
       --with-http_secure_link_module \
       --with-http_degradation_module \
       --with-http_slice_module \
       --with-http_stub_status_module \
       --with-http_perl_module \
       --with-mail \
       --with-mail_ssl_module \
       --with-stream \
       --with-stream_ssl_module \
       --with-stream_realip_module \
       --with-stream_geoip_module \
       --with-stream_ssl_preread_module \
       --with-cpp_test_module \
       --with-pcre \
       --with-pcre-jit \
       --with-libatomic \
       --with-compat &> /dev/null \

    && make &> /dev/null \
    && make install &> /dev/null \
    && make clean &> /dev/null \

    && cd /usr/local/nginx \

#   建立nginx启动用户
    && groupadd nginx && useradd -g nginx -M -s /sbin/nologin nginx \

#   配置
    && sed -i '2s/#user  nobody;/user  nginx;/' conf/nginx.conf \
    && sed -i '36s/80/8008/' conf/nginx.conf \
    && sed -i '65s/#/ /' conf/nginx.conf \
    && sed -i '67s/#/ /' conf/nginx.conf \
    && sed -i '68s/#    fastcgi_index  index.php;/    try_files $uri = 404;/g' conf/nginx.conf \
    && sed -i '70s/#    include        fastcgi_params;/    include        fastcgi.conf;/' conf/nginx.conf \
    && sed -i '71s/#/ /' conf/nginx.conf \
    && mkdir client_body_temp proxy_temp fastcgi_temp uwsgi_temp scgi_temp \
    && chown -R nginx:nginx logs client_body_temp proxy_temp fastcgi_temp uwsgi_temp scgi_temp \
    
#   清理系统
    && dnf -y remove gcc-c++ make wget &> /dev/null \
    && dnf clean all &> /dev/null \
    && rm -rf /tmp/*

USER nginx
EXPOSE 8008
ENV TZ="Asia/Shanghai"
VOLUME ["/usr/local/nginx/conf", "/usr/local/nginx/logs"]
ENTRYPOINT ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]