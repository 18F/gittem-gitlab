# gittem-gitlab

Take a CSV of URLs of tar.gz git repositories, extract them, and load them into gitlab


## USAGE

First things first
```
docker-compose up # Courtesy of http://www.damagehead.com/docker-gitlab/
```

You'll need to point your browser to http://dockerhost:10080 (I set dockerhost in ``/etc/hosts`). If you use boot2docker, the dockerhost can be found by running `boot2docker ip`.

The first time you log in, you'll need to use these credentials:
```
username: root
password: 5iveL!fe
```

You'll then need to create a new password. Next, log in and add an SSH key to gitlab. Finally, get your "private_token".

Once you've done that, it's as simple as:

```
export PRIVATE_TOKEN=private_token
export DOCKERHOST=docker_host
./gittem-gitlab.sh
```
