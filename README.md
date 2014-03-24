# Basic Grunt Pipeline

My custom Grunt Pipeline (inspired by Yeoman!) which uses:
- AngularJS
- Coffeescript
- [Slim](https://github.com/slim-template/slim) (like HAML)
- Compass (SCSS/SASS)
- Karma and PhantomJS (testing)

## Main Requirements

Here you can find software requirements, I'll put my version in brackets near
software, but you can try with a different one.

- **nodejs** (0.10.26)
- **Ruby** (2.0.0-p353)
- **grunt** (0.4.4)
- **grunt-cli** (0.1.13)
- [direnv](https://github.com/zimbatm/direnv) (no version I suppose)

nodejs, ruby and grunt are obvious requirements, what's "weird" is **direnv**.
This *supreme* tool allows me to inject ENV variables on a per-directory basis, allowing me expecially to
change path of executable files (by changing `$PATH`).  
This was really helpful because `grunt-slim` didn't use bundler (which should be the default!) and because
I wanted to inject some helper methods in my Slim templates. I achieved this with direnv, by placing my `bin`
directory as the first one in my path so I replaced `slimrb` with a custom one which runs bundler and includes
a gem with some helpers.

Simple and effective.

## Auto-installed Requirements
Just run `npm install`, `bundle install` and `bower install`. All requirements will be auto installed.

## Optional

- **rvm** (1.25.0)
- **nvm**

## Setup

You need to point an Nginx (or Apache or any other webserver) to the `.tmp` directory (development) or `dist`
directory if you want to see the production application.

Here is my very small and far from perfect nginx configuration:

```nginx
server {
        listen   8080;

        server_name dev.basicgruntpipeline.localhost;

        location / {
                allow 127.0.0.1;
                allow ::1;
                # You can remove this if you don't want LAN access, I use it to test with IE
                allow 192.168.1.0/24;
                deny all;

                root /home/francesco/projects/web/basic_grunt_pipeline/.tmp;
                index index.html;
                error_page 404 /404.html;

				# I found multiple ways to serve index.html page for angular servers, I performed 3 tries
                # and I've chosen the last one
                # 1
                #if (!-e $request_filename) {
                #       rewrite ^(.*)$ /index.html break;
                #}
                # 2
                #rewrite $uri /index.html;
                # 3
                try_files $uri /index.html;
        }
}
```

You need to point dev.basicgruntpipeline.localhost to `127.0.0.1` in your `/etc/hosts` file.

## Usage

It's very easy to use this tool: `grunt build` or `grunt build:dev` will build the `.tmp` directory for
development purposes. `grunt watch` will compile some files (coffee/compass/slim) and fire up livereload.

`grunt build:dist` will build your code in `.tmp` and prepare it for release in `dist` directory.

In any case, **the best way to use all these tasks** is by running: `grunt`, this will run `bundle install`,
`grunt build:dev` and then `grunt watch`

# Choices details

Some details about my choices:
- I don't use google cdn, it's more or less a personal choice, nothing more. 
- I don't use bower-install because bower packages can be cluttered with useless things, I prefer to list files
  manually
- I don't use htmlmin because Slim already minifies files and I want to keep spaces in a few places (like after
  each `li` tag), also `grunt-usemin` has a lot of issues with missing new lines, so I needed to keep the
  format.
- Jshint becomes useless since I use coffee and I'm not sure if coffeehint actually works fine

# Improvements & changes
- Fork and submit a pull request if you want to improve my pipeline
- Submit an issue if you want to suggest something, you noticed something weird or you want an explaination