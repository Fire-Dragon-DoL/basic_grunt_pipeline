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