module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)
  require('time-grunt')(grunt)

  grunt.initConfig(

    yeoman:
      app:  require('./bower.json').appPath or 'app'
      dist: 'dist'
      tmp:  '.tmp'
      test: 'test'

    watch:
      coffee:
        files: [
          '<%= yeoman.app %>/scripts/{,*/}*.{coffee,litcoffee,coffee.md}'
        ]
        tasks: ['newer:coffee:scripts']
      coffeeTest:
        files: [
          '<%= yeoman.test %>/spec/{,*/}*.{coffee,litcoffee,coffee.md}'
          '<%= yeoman.test %>/mock/{,*/}*.{coffee,litcoffee,coffee.md}'
        ]
        tasks: ['newer:coffee:tests', 'karma']
      compass:
        files: ['<%= yeoman.app %>/styles/{,*/}*.{scss,sass}']
        tasks: ['compass:dev', 'autoprefixer']
      slim:
        files: [
          '<%= yeoman.app %>/index.slim'
          '<%= yeoman.app %>/views/{,*/}*.slim'
        ]
        tasks: ['newer:slim:all']
      copy_compile:
        files: [
          '*.{ico,png,txt}'
          '.htaccess'
          'images/{,*/}*.{webp}'
          'fonts/*'
          'package.json'
        ]
        tasks: ['newer:copy:compile']
      imagemin:
        files: [
          '<%= yeoman.tmp %>/images/{,*/}*.{png,jpg,jpeg,gif}'
        ]
        tasks: ['newer:imagemin:dev']
      svgmin:
        files: [
          '<%= yeoman.app %>/images/{,*/}*.svg'
        ]
        tasks: ['newer:svgmin:dev']
      gruntfile:
        options:
          reload: true
        files: [
          'Gruntfile.coffee'
          'Gemfile'
        ]
      livereload:
        options:
          livereload: true
        files: [
          '<%= yeoman.tmp %>/index.html'
          '<%= yeoman.tmp %>/{,*/}*.html'
          '<%= yeoman.tmp %>/styles/{,*/}*.css'
          '<%= yeoman.tmp %>/scripts/{,*/}*.js'
          '<%= yeoman.tmp %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}'
          '<%= yeoman.tmp %>/fonts/{,*/}*.woff'
        ]

    # Utils

    open:
      nodewebkit_dev:
        path: '<%= yeoman.tmp %>'
        app:  'nw'
      nodewebkit_dist:
        path: '<%= yeoman.dist %>'
        app:  'nw'

    shell:
      bundle_install:
        options:
          failOnError: true
          stdout:      true
          stderr:      true
        command: 'bundle install'

    # Tasks
    clean:
      dev:
        files: [{
          expand: true
          cwd:    '.'
          dot:    true
          src:    '<%= yeoman.tmp %>/*'
        }]
      dist:
        files: [{
          expand: true
          cwd:    '.'
          dot:    true
          src: [
            '<%= yeoman.dist %>/*'
            '!<%= yeoman.dist %>/.git*'
          ]
        }]

    autoprefixer:
      all:
        files: [{
          expand: true
          cwd:    '<%= yeoman.tmp %>/styles'
          src:    '{,*/}*.css'
          dest:   '<%= yeoman.tmp %>/styles'
        }]
        options:
          browsers: ['last 1 version']

    coffee:
      scripts:
        options:
          sourceMap: true
        files: [{
          expand: true
          cwd:    '<%= yeoman.app %>/scripts'
          src:    '{,*/}*.coffee'
          dest:   '<%= yeoman.tmp %>/scripts'
          ext:    '.js'
        }]
      tests:
        options:
          sourceMap: true
        files: [{
          expand: true
          cwd:    '<%= yeoman.test %>/spec'
          src:    '{,*/}*.coffee'
          dest:   '<%= yeoman.tmp %>/test/spec'
          ext:    '.js'
        }]

    compass:
      dev:
        options:
          sassDir:                 '<%= yeoman.app %>/styles'
          cssDir:                  '<%= yeoman.tmp %>/styles'
          generatedImagesDir:      '<%= yeoman.tmp %>/images'
          imagesDir:               '<%= yeoman.tmp %>/images'
          javascriptsDir:          '<%= yeoman.tmp %>/scripts'
          fontsDir:                '<%= yeoman.tmp %>/fonts'
          relativeAssets:          true
          assetCacheBuster:        false
          bundleExec:              true
          environment:             'development'
          importPath: [
            '<%= yeoman.app %>/bower_components'
            '<%= yeoman.app %>/styles'
          ]
          raw: 'Sass::Script::Number.precision = 10\n'
      dist:
        options:
          sassDir:                 '<%= yeoman.app %>/styles'
          cssDir:                  '<%= yeoman.tmp %>/styles'
          generatedImagesDir:      '<%= yeoman.tmp %>/images'
          imagesDir:               '<%= yeoman.tmp %>/images'
          javascriptsDir:          '<%= yeoman.tmp %>/scripts'
          fontsDir:                '<%= yeoman.tmp %>/fonts'
          httpImagesPath:          'images'
          httpGeneratedImagesPath: 'images'
          httpFontsPath:           'fonts'
          httpStylesheetsPath:     'styles'
          httpJavascriptsPath:     'scripts'
          relativeAssets:          false
          assetCacheBuster:        false
          bundleExec:              true
          environment:             'production'
          importPath: [
            '<%= yeoman.app %>/bower_components'
            '<%= yeoman.app %>/styles'
          ]
          raw: 'Sass::Script::Number.precision = 10\n'

    slim:
      all:
        options:
          trace:  true
          pretty: false
        files:  [
          {
            "<%= yeoman.tmp %>/index.html": '<%= yeoman.app %>/index.slim'
          }, {
            expand: true
            cwd:   '<%= yeoman.app %>/views'
            src:   '{,*/}*.slim'
            dest:  '<%= yeoman.tmp %>/views'
            ext:   '.html'
          }
        ]

    rev:
      assets:
        files:
          src: [
            '<%= yeoman.tmp %>/application.js'
            '<%= yeoman.tmp %>/application.css'
            '<%= yeoman.tmp %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}'
            '<%= yeoman.tmp %>/fonts/{,*/}*.woff'
          ]

    useminPrepare:
      # No purpose of having any other file here, only index references all js and css
      html: ['<%= yeoman.tmp %>/index.html']
      options:
        dest: '<%= yeoman.tmp %>'

    usemin:
      # Must parse ALL html files, must replace img tags
      html: [
        '<%= yeoman.tmp %>/index.html'
        '<%= yeoman.tmp %>/{,*/}*.html'
      ]
      # Star used because application file will be revved
      css:  [
        '<%= yeoman.tmp %>/{,*\\.}application.css'
        '<%= yeoman.tmp %>/styles/{,*/}*.css'
      ]
      options:
        assetsDirs: [
          '<%= yeoman.tmp %>'
          '<%= yeoman.tmp %>/images'
          '<%= yeoman.tmp %>/images/**/*'
        ]

    imagemin:
      dev:
        options:
          optimizationLevel: 0
          progressive:       false
          interlaced:        false
        files: [{
          expand: true
          cwd:    '<%= yeoman.app %>/images'
          src:    '{,*/}*.{png,jpg,jpeg,gif}'
          dest:   '<%= yeoman.tmp %>/images'
        }]
      dist:
        files: [{
          expand: true
          cwd:    '<%= yeoman.app %>/images'
          src:    '{,*/}*.{png,jpg,jpeg,gif}'
          dest:   '<%= yeoman.tmp %>/images'
        }]
    svgmin:
      dev:
        options:
          plugins: []
        files: [{
          expand: true
          cwd:    '<%= yeoman.app %>/images'
          src:    '{,*/}*.svg'
          dest:   '<%= yeoman.tmp %>/images'
        }]
      dist:
        files: [{
          expand: true
          cwd:    '<%= yeoman.app %>/images'
          src:    '{,*/}*.svg'
          dest:   '<%= yeoman.tmp %>/images'
        }]

    copy:
      compile:
        files: [
          {
            expand: true
            dot:    true
            cwd:    '<%= yeoman.app %>'
            dest:   '<%= yeoman.tmp %>'
            src: [
              '*.{ico,png,txt}'
              '.htaccess'
              'bower_components/**/*'
              'images/{,*/}*.{webp}'
              'fonts/*'
              'package.json'
            ]
          }
        ]
      distribute:
        files: [
          {
            expand: true
            dot:    true
            cwd:    '<%= yeoman.tmp %>'
            dest:   '<%= yeoman.dist %>'
            src: [
              '*.{ico,png,txt,html}'
              '.htaccess'
              'images/{,*/}*.{png,jpg,jpeg,gif,webp}'
              'fonts/*'
              'package.json'
              '*\\.application.js'
              '*\\.application.css'
              'views/{,*/}*.html'
            ]
          }
        ]

    concurrent:
      dev: [
        'coffee'
        'compass:dev'
        'imagemin:dev'
        'svgmin:dev'
      ]
      dist: [
        'coffee'
        'compass:dist'
        'imagemin:dist'
        'svgmin:dist'
      ]

    karma:
      unit:
        configFile: 'karma.conf.js'
        singleRun:  true
  )

  grunt.registerTask('build', (target, run_nw) ->
    target = 'dev' unless target?

    if target is 'dev'
      grunt.task.run([
        'clean:dev'
        'slim:all'
        'copy:compile'
        'useminPrepare'
        # Concurrent temporary disabled, it takes less without it
        # 'concurrent:dev'
        'coffee'
        'compass:dev'
        'imagemin:dev'
        'svgmin:dev'
        #
        'autoprefixer'
      ])
      grunt.task.run('open:nodewebkit_dev') if run_nw is 'open'

    if target is 'dist'
      grunt.task.run([
        'clean'
        'slim:all'
        'copy:compile'
        'useminPrepare'
        # Concurrent temporary disabled, it takes less without it
        # 'concurrent:dist'
        'coffee'
        'compass:dist'
        'imagemin:dist'
        'svgmin:dist'
        #
        'autoprefixer'
        'concat'
        'cssmin'
        'uglify'
        'rev'
        'usemin'
        'copy:distribute'
        # No htmlmin or it will break <li> tags
      ])
      grunt.task.run('open:nodewebkit_dist') if run_nw is 'open'
  )

  grunt.registerTask('default', ->
    grunt.task.run([
      'shell:bundle_install'
      'build:dev'
      'watch'
    ])
  )