FROM centos:6.6
RUN yum -y install \
    gcc \
    httpd \
    mysql-server \
    php \
    php-devel \
    php-mbstring \
    php-mcrypt \
    php-mysql \
    php-gd \
    php-pear \
    ImageMagick \
    ImageMagick-devel \
    sendmail \
    xinetd

RUN /bin/rm -f /etc/xinetd.d/*
RUN printf "\n" | pecl install imagick-3.0.1
RUN mkdir /base
RUN mkdir /base/application
RUN mkdir /base/public_html
COPY ./assets/httpd.conf /etc/httpd/conf/
COPY ./assets/php.conf   /etc/httpd/conf.d/
COPY ./assets/php.ini    /etc/
COPY ./assets/index.php  /base/public_html/
COPY ./assets/phpMyAdmin /base/phpmyadmin/
COPY ./assets/smtp       /etc/xinetd.d/smtp
EXPOSE 80

CMD bash -c "/usr/sbin/xinetd -dontfork && /usr/sbin/httpd -DFOREGROUND"
