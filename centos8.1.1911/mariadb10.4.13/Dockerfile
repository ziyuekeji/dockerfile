FROM centos:8.1.1911

LABEL maintainer="梓月网络 <lxs@ziyuewl.com>" \
      reference="https://github.com/ziyuewl/lnmp/centos8.1.1911/mariadb" \
      centos=8.1.1911 \
      nginx=1.18.0 \
      php=7.4.6 \
      mariadb=10.4.13-linux-glibc_214

# 复制依赖
COPY cnf /etc/mysql/

#   更新系统、安装依赖
RUN dnf -y update &> /dev/null \
    && dnf -y upgrade &> /dev/null \
    && dnf -y install \
       wget \
       libaio \
       ncurses-compat-libs &> /dev/null \

#   建立mysql用户    
    && groupadd mysql && useradd -g mysql -M -s /sbin/nologin mysql \  

    && cd /tmp \

#   下载mariadb
    && wget -c https://mirrors.tuna.tsinghua.edu.cn/mariadb/mariadb-10.4.13/bintar-linux-glibc_214-x86_64/mariadb-10.4.13-linux-glibc_214-x86_64.tar.gz &> /dev/null \

#   解压、安装、配置mariadb
    && tar -zxf mariadb-10.4.13-linux-glibc_214-x86_64.tar.gz \
    && mv mariadb-10.4.13-linux-glibc_214-x86_64 /usr/local/mysql \
    && mkdir -p /var/lib/mysql /var/run/mariadb /var/log/mariadb \
    && chown -R mysql:mysql /var/lib/mysql /var/run/mariadb /var/log/mariadb \
    && chown -R root:root /usr/local/mysql \
    && mv /etc/mysql/mysql-entrypoint.sh /usr/local/bin \

#   清理系统
    && dnf -y remove wget &> /dev/null \
    && dnf clean all &> /dev/null \
    && rm -rf /tmp/*

USER mysql
ENV TZ="Asia/Shanghai"
EXPOSE 3306
VOLUME ["/etc/mysql", "/var/lib/mysql", "/var/log/mariadb"]
ENTRYPOINT ["/usr/local/bin/mysql-entrypoint.sh"]