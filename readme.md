# Como testar

> docker-compose up
> docker-compose run app ruby /app/insert.rb

Olhar o output do container `app`, o loop do listen printou o evento

> docker-compose run app ruby /app/delete.rb

A trigger tambem funciona para eventos de delete e update


Inline-style: 
![alt text](https://raw.githubusercontent.com/cpgo/rb-listen-notify/master/example.gif "Example")
