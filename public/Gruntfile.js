// Generated on 2014-09-30 using generator-angular 0.9.8
'use strict';

// # Globbing
// for performance reasons we're only matching one level down:
// 'test/spec/{,*/}*.js'
// use this if you want to recursively match all subfolders:
// 'test/spec/**/*.js'

module.exports = function (grunt) {

  // Load grunt tasks automatically
  require('load-grunt-tasks')(grunt);

  // Time how long tasks take. Can help when optimizing build times
  require('time-grunt')(grunt);

  // Configurable paths for the application
  var appConfig = {
    app: 'app/src',
    dist: 'app/dist'
  };

  // Define the configuration for all the tasks
  grunt.initConfig({

    // Project settings
    appConfig: appConfig,


    // Make sure code styles are up to par and there are no obvious mistakes
    jshint: {
      options: {
        jshintrc: '.jshintrc',
        reporter: require('jshint-stylish')
      },
      all: {
        src: [
          'Gruntfile.js',
          '<%= appConfig.app %>/scripts/{,*/}*.js'
        ]
      },
      test: {
        options: {
          jshintrc: 'test/.jshintrc'
        },
        src: ['test/spec/{,*/}*.js']
      }
    },

    /**
     * Nettoyer le répertoire dist
     */
    clean: {
      dist: {
        files: [{
          dot: true,
          src: ['<%= appConfig.dist %>/**']
        }]
      }
    },


    // Reads HTML for usemin blocks to enable smart builds that automatically
    // concat, minify and revision files. Creates configurations in memory so
    // additional tasks can operate on them
    useminPrepare: {
      html: '<%= appConfig.dist %>/main/index.html',

        options: {
            dest: '<%= appConfig.dist %>/main',
            flow: {
                html: {
                    steps: {
                        js: ['concat', 'uglifyjs'],
                        css: ['cssmin']
                    },
                    post: {}
                }
            }
        }
//      options: {
//        dest: '<%= appConfig.dist %>',
//        flow: {
//          html: {
//            steps: {
//              js: ['concat', 'uglifyjs'],
//              css: ['cssmin']
//            },
//            post: {}
//          }
//        }
//      }
    },

    // Performs rewrites based on filerev and the useminPrepare configuration
    usemin: {
      html: ['<%= appConfig.dist %>/main/index.html'],
//      css: ['<%= appConfig.dist %>/styles/{,*/}*.css'],
//      js: ['<%= appConfig.dist %>/main/modules/common/*js'],
      options: {
        revmap: '<%= appConfig.dist %>/main/filerev.json'
      }
    },


      /**
       * Copies des sources vers le répertoire dist
       */
      copy: {
          main: {
              expand: true,
              dot: true,
              cwd: '<%= appConfig.app %>/main',
              dest: '<%= appConfig.dist %>/main',
              src: [
                  '**'
              ]
          }
          ,
          test: {
              expand: true,
              dot: true,
              cwd: '<%= appConfig.app %>/test',
              dest: '<%= appConfig.dist %>/test',
              src: [
                  '**'
              ]
          }
      },

      /**
       * Ajouter les annotations Angular pour l'injection de dépendance
       * Nécessaire avant la minification javascript
       */
      ngAnnotate: {
          main: {
              files: [{
                  expand: true,
                  src: ['<%= appConfig.dist %>/main/**/*.js', '!<%= appConfig.dist %>/main/resources/**']
              }]
          },
          test: {
              files: [{
                  expand: true,
                  src: ['<%= appConfig.dist %>/test/**/*.js']
              }]
          }
      },

      /**
       * Ajout d'un numéro de révision aux fichiers de l'application afin
       * qu'ils puissent être mis en cache par les navigateurs
       */
      filerev: {
          dist: {
//              src: [
//                  '<%= appConfig.dist %>/main/**/*.*',
//                  '!<%= appConfig.dist %>/main/resources/**'
//              ]
//              src: [
//                  '<%= appConfig.dist %>/main/app.js'
//              ]
          }
      },

      filerev_assets: {
          dist: {
              options: {
                  dest: '<%= appConfig.dist %>/main/filerev.json',
                  cwd: '<%= appConfig.dist %>/main/'
              }
          }
      },

      filerev_replace: {
          options: {
              assets_root: '<%= appConfig.dist %>/main/'
          },
          src: '<%= appConfig.dist %>/main/modules/common/*js'
//          views: {
//              options: {
//                  views_root: [
//                      '<%= appConfig.dist %>/main/',
//                      '!<%= appConfig.dist %>/main/resources/**'
//                  ]
//              },
//              src: '<%= appConfig.dist %>/main/**/*.html'
//          }
      },

    /**
     * Compression du javascript
     */
    uglify: {
       dist: {
           files: [{
               expand: true,
               cwd: '<%= appConfig.dist %>/main',
               src: ['**/*.js', '!resources/**']

           }]
       }
    },

   /**
    * Compression du html
    */
    htmlmin: {
      dist: {
          options: {
              removeComments: true,
              collapseWhitespace: true
          },
        files: [{
          expand: true,
          cwd: '<%= appConfig.dist %>/main',
          src: ['**/*.html', '!resources/**']
        }]
      }
    },


   /**
    * Exécution de tâches en parallèle
    */
    concurrent: {
      copy: [
        'copy:main', 'copy:test'
      ],
      annotate: [
        'ngAnnotate:main', 'ngAnnotate:test'
      ],
      dist: [

      ]
    },

  /**
   * Tests unitaires
   */
    karma: {
      unit: {
        configFile: 'app/src/test/karma.conf.js',
        singleRun: true
      }
    }
  });


  grunt.registerTask('serve', 'Compile then start a connect web server', function (target) {
    if (target === 'dist') {
      return grunt.task.run(['build', 'connect:dist:keepalive']);
    }

    grunt.task.run([
      'clean:server',
      'concurrent:server',
      'connect:livereload',
      'watch'
    ]);
  });

  grunt.registerTask('test', [
    'clean:server',
    'concurrent:test',
    'connect:test',
    'karma'
  ]);

    /**
     * Build de l'application
     */
    grunt.registerTask('build', [
        'clean:dist',
        'concurrent:copy',
        'concurrent:annotate',

        'useminPrepare',
        'concat',
        'uglify',
        'filerev',
        'filerev_assets',
        'usemin'


//        'concat:generated',



//        'uglify',
//        'htmlmin'

    ]);

  grunt.registerTask('default', [
    'newer:jshint',
    'test',
    'build'
  ]);
};
