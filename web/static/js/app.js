// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
// import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
import Elm from './main';
const elmDiv = document.querySelector('#root');

if (elmDiv) {
  var localLanguage = localStorage.getItem('language');
  var localJWT = localStorage.getItem('jwt');

  // If user has not set localLanguage before
  if(!localLanguage) {
    // find user navigator language & set it
    var userLang = navigator.language || navigator.userLanguage;
    if(userLang == 'fr') {
      localLanguage = 'French'
    } else {
      localLanguage = 'English'
    }
  }

  var app = Elm.Main.embed(elmDiv, {
    localLanguage: localLanguage,
    localJWT: localJWT
  });
  app.ports.setLocalJWT.subscribe(function(jwt) {
    localStorage.setItem('jwt', jwt);
  });
  app.ports.removeLocalJWT.subscribe(function() {
    localStorage.removeItem('jwt');
  });
  app.ports.appTitle.subscribe(function(newTitle) {
    document.title = newTitle;
  });
  app.ports.setLocalLanguage.subscribe(function(lang) {
    localStorage.setItem('language', lang);
  });
}
