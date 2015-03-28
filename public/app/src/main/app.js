'use strict';

/**
 * @ngdoc overview
 * @name angularApp
 * @description
 * # angularApp
 *
 * Main module of the application.
 */
angular.module('caisseServices', []);

var services = 'caisseServices';

angular
    .module('caisseApp', [
        'tmh.dynamicLocale',
        'ngResource',
        'ngRoute',
        'ngSanitize',
        'pascalprecht.translate',
        'ngCookies',
        'mgcrea.ngStrap',
        'ngMessages',
        'ui.router',
        'ui.sortable',
        services,
        'home',
        'stocks',
        'sale',
        'ngMaterial'
    ])

    // Décorateur du service $log
    .config(function($provide) {
        $provide.decorator('$log', function ($delegate) {
                return {
                    debug: function (text) { $delegate.debug(text); },
                    info: function (text) { $delegate.info(text); },
                    error: function (text) { $delegate.error(text); }
                };
        });
    })

    .config(function($translateProvider) {
        // Translation
        $translateProvider
	        .useStaticFilesLoader({
	            prefix: '/resources/i18n/langue_',
	            suffix: '.json'
	        })
	        .registerAvailableLanguageKeys(['fr', 'en'])
	        .determinePreferredLanguage()
	        .fallbackLanguage('fr')
	        .useCookieStorage();

    })

    .config(['tmhDynamicLocaleProvider',function(tmhDynamicLocaleProvider) {
        tmhDynamicLocaleProvider.localeLocationPattern("resources/bower_components/angular-i18n/angular-locale_{{locale}}.js");
        tmhDynamicLocaleProvider.useCookieStorage();
    }])

    // Service d'initialisation de l'application
    .factory('InitService',
        function($log, $rootScope, $q, $translate, tmhDynamicLocale, $location,$cookieStore) {
            return {
                init: init
            };

            function init() {
                $log.info("Initialisation de l'application");

                tmhDynamicLocale.set($translate.use());


                //var colorNumber = $cookieStore.get('color');
                //if(colorNumber == undefined){
                //    //style un par défaut
                //    $rootScope.changeStyle(1);
                //}else{
                //    $rootScope.changeStyle(colorNumber);
                //}

            }
        }
    )

    .config(function ($stateProvider, $urlRouterProvider, $locationProvider) {
      $urlRouterProvider.otherwise("/");
      $locationProvider.html5Mode(true);
    })

    .run(function($log, $rootScope, $location, InitService, $state,$translate,tmhDynamicLocale,$cookieStore) {

            // Listener de changement d'url
            $rootScope.$on('$locationChangeSuccess', function () {
                $log.info("Changement d'url " + $location.path());
            });

            $rootScope.changeLanguage = function (key) {
                $translate.use(key);
                tmhDynamicLocale.set(key);
                $state.go($state.current, {}, {reload: true});
            };

            //$rootScope.changeStyle = function (style) {
            //
            //   var color;
            //
            //   var pinkMod = { 'accent-color' : '@LVBrown',
            //       'accent-color-2' : '@LVYellow',
            //       '@backgroundImage' : '@vuitton'};
            //
            //    var psgMod = { 'accent-color' : '@psgBlue',
            //        'accent-color-2' : '@psgRed',
            //        '@backgroundImage' : '@psg'};
            //
            //    if(style == 1){
            //        color = pinkMod;
            //        $cookieStore.put('color',1);
            //    }
            //    if(style == 2){
            //        color = psgMod;
            //        $cookieStore.put('color',2);
            //    }
            //
            //   less.modifyVars(color);
            //   less.refreshStyles();
            //};

            // Initilisation de l'appli
            InitService.init();
        }
    );




