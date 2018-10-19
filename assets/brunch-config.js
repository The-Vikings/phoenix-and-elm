// NOTE: When bringing in Elm-Phoenix, the example app within the package
// causes havoc with styling etc, so the best thing to do is remove it ie
// rm -rf assets/elm/elm-stuff/packages/saschatimme/elm-phoenix/example
// See: https://github.com/saschatimme/elm-phoenix/issues/7
exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: "js/app.js"
    },
    stylesheets: {
      joinTo: "css/app.css"
    },
    templates: {
      joinTo: "js/app.js"
    }
  },

  conventions: {
    // This option sets where we should place non-css and non-js assets in.
    // By default, we set this to "/assets/static". Files in this directory
    // will be copied to `paths.public`, which is "priv/static" by default.
    assets: /^(static)/
  },

  // Phoenix paths configuration
  paths: {
    // Dependencies and current project directories to watch
    watched: ["static", "css", "js", "vendor", "leia-elm"],
    // Where to compile files to
    public: "../priv/static"
  },

  // Configure your plugins
  plugins: {
    stylus: {
      plugins: ["nib"]
    },
    babel: {
      // Do not use ES6 compiler in vendor code
      ignore: [
        /vendor/,
        "js/elm.js"
      ]
      // ignore: [/web\/static\/vendor/]
    },

    elmBrunch: {
      elmFolder: "leia-elm",
      mainModules: ["src/Main.elm"],
      outputFolder: "../js",
      outputFile: "elm.js",
      makeParameters: [
        "--warn",
        "--debug"
      ]
    }
  },

  modules: {
    autoRequire: {
      "js/app.js": ["js/app"]
    }
  },

  npm: {
    enabled: true,
    styles: {
      'normalize.css': ['normalize.css'],
    }
  }
};
