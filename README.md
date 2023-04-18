ExpressionEngine Docker Image
========

![Docker images](images/expressionengine-logo.svg)  

##
* Official website [`https://expressionengine.com/`](https://expressionengine.com/) 
* Documentation [`https://docs.expressionengine.com`](https://docs.expressionengine.com/latest/index.html) 
* ExpressionEngine on Github [`https://github.com/ExpressionEngine`](https://github.com/ExpressionEngine)

### How to run with Docker
1. Go to directory with this repo (in console) on your computer
2. Run command `$ docker-compose up -d` it will create three images - `ExpressionEngine`, `Mysql` and `Adminer`
3. ExpressionEngine app files, are located in `expressionengine` directory at your computer, and `/var/www/html` inside of the container

Now you have working environment based on Docker. Below are few links, where you can go and start working with ExpressionEngine.

[`http://localhost:7215/admin.php`](http://localhost:7215/admin.php) - ExpressionEngine administration panel  
[`http://localhost:7215`](http://localhost:7215) - Main page  
[`http://localhost:8181`](http://localhost:8181) - Adminer to management MySQL database  

### ExpressionEngine installation
After first time running docker containers, we need to set up ExpressionEngine site. 
1. Got to [`http://localhost:7215/admin.php`](http://localhost:7215/admin.php) page
2. You should have seen installer of ExpressionEngine. Fill required fields with this data: 
 
    **Server Address:** `db`  
    **DB name:** `expressionengine`  
    **DB username:** `expressionengine`  
    **DB password:** `expressionengine`  
    **Email:** `your@email.com`  
    **Username:** `some_user`  
    **Password:** `some_password`  

    New to ExpressionEngine? Install the default theme to get up and running faster with dummy front-end and back-end data. To do this, please check `Install default theme?` option.   
    Check checkbox `I agree to the license Terms and Conditions` and click **Install** button. 
    
    After successfully installation, you should be able to see info-box
    
    ![Docker containers](images/docker-ee-install.png)  

3. According to information from install complete box, we need to remove `system/ee/installer` directory. Without that we won't be able to log in into administration panel. To remove this directory, we need to go into docker container with ExpressionEngine page. To do that, go to console and run command:
   
    `$ docker exec -it expressionengine-7.2.15 bash`  
    
    This command will move you to container console with a path `/var/www/html`. In this console write and execute command:
    
    `$ rm -rf system/ee/installer/`
    
    This command will delete `installer` directory in Docker container. After that you can type `$ exit` in a console to exit from container.
    
    Now if you go to admin panel page [`http://localhost:7215/admin.php`](http://localhost:7215/admin.php) you will get login page
    
    ![Docker containers](images/docker-ee-login-page.png) 

    You can log in with credentials passed during installation process `Username: some_user` and `Password: some_password`

    Main page url is [`http://localhost:7215`](http://localhost:7215). If you checked `Install default theme?` option during installation, you should be able to see page with some data.
    
### Connection with MySQL database
If you want to connect directly with MySQL database, there is an simple application called `Adminer` included to this ExpressionEngine docker image. If you go to:

[`http://localhost:8181`](http://localhost:8181)

You should've seen login page to MySQL database

![Docker containers](images/docker-ee-adminer-login.png) 
   
If you fill fields with the data (same as during ExpressionEngine installation process):

**Server:** `db`  
**Username:** `expressionengine`  
**Password:** `some_password`  
**Database:** `expressionengine` 

Click **Login** button and you will connect to database assigned to your ExpressionEngine page. 

### Technologies

**Type** | **Version**   |
--- |---------------| 
ExpressionEngine | 7.2.15        |
PHP | 8.0.28-apache |
MySQL | 8.0.33        |
Adminer | latest        |
