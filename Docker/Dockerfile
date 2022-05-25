FROM amazonlinux


RUN yum -y update 
RUN yum -y install httpd


RUN echo 'Hello worls from Docker!' > /ver/www/html/index.html
CMD ["/usr/sbin/httpd","-D", "FOREGROUND"]

EXPOSE 80