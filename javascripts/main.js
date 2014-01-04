// Generated by CoffeeScript 1.6.2
(function() {
  var Qchan, _ref, _ref1, _ref2,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Qchan = {
    Models: {},
    Repositories: {},
    Views: {}
  };

  Qchan.Mediator = (function() {
    function Mediator() {
      $.observable(this);
    }

    return Mediator;

  })();

  Qchan.Models.User = (function() {
    var KEYS;

    KEYS = ['access_token', 'email', 'name'];

    function User() {
      $.observable(this);
      this.repository = Qchan.Repository["for"]('user');
      this.pull();
    }

    User.prototype.set = function(attributes) {
      var key, _i, _len, _results;

      _results = [];
      for (_i = 0, _len = KEYS.length; _i < _len; _i++) {
        key = KEYS[_i];
        _results.push(this.repository.set(key, this[key] = attributes[key]));
      }
      return _results;
    };

    User.prototype.pull = function() {
      var key, _i, _len, _results;

      _results = [];
      for (_i = 0, _len = KEYS.length; _i < _len; _i++) {
        key = KEYS[_i];
        _results.push(this[key] = this.repository.get(key));
      }
      return _results;
    };

    return User;

  })();

  Qchan.Repositories.LocalStorage = (function() {
    function LocalStorage() {}

    LocalStorage.prototype.get = function(key) {
      return window.localStorage.getItem(key);
    };

    LocalStorage.prototype.set = function(key, value) {
      return window.localStorage.setItem(key, value);
    };

    return LocalStorage;

  })();

  Qchan.Repository = (function() {
    function Repository() {}

    Repository.table = {};

    Repository.register = function(name, storage) {
      return this.table[name] = storage;
    };

    Repository["for"] = function(name) {
      return this.table[name];
    };

    return Repository;

  })();

  Qchan.URIFragmentParser = (function() {
    URIFragmentParser.parse = function(fragment) {
      return new this(fragment).parse();
    };

    function URIFragmentParser(fragment) {
      this.fragment = fragment;
    }

    URIFragmentParser.prototype.parse = function() {
      var key, segment, table, value, _i, _len, _ref, _ref1;

      table = {};
      _ref = this.segments();
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        segment = _ref[_i];
        _ref1 = segment.split('=', 2), key = _ref1[0], value = _ref1[1];
        if (value) {
          table[key] = window.decodeURIComponent(value);
        }
      }
      return table;
    };

    URIFragmentParser.prototype.segments = function() {
      return this.fragment.substr(1).split('&');
    };

    return URIFragmentParser;

  })();

  Qchan.View = (function() {
    function View(parent, selector) {
      this.parent = parent;
      this.selector = selector;
      $.observable(this);
      this.initialize();
    }

    View.prototype.initialize = function() {};

    View.prototype.render = function() {
      return this.element().html(this.template());
    };

    View.prototype.template = function() {
      return this.constructor.TEMPLATE;
    };

    View.prototype.element = function() {
      return this.parentElement().find(this.selector);
    };

    View.prototype.parentElement = function() {
      var _ref;

      return ((_ref = this.parent) != null ? _ref.element() : void 0) || $(document.body);
    };

    return View;

  })();

  Qchan.Views.Application = (function(_super) {
    __extends(Application, _super);

    function Application() {
      _ref = Application.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Application.TEMPLATE = "<header id=\"header\"></header>\n\n<div id=\"main\"></div>";

    Application.prototype.initialize = function() {
      var _this = this;

      this.header = new Qchan.Views.Header(this, '#header');
      return Qchan.mediator.on('initialized', function() {
        _this.render();
        return _this.header.trigger('initialized');
      });
    };

    return Application;

  })(Qchan.View);

  Qchan.Views.Authentication = (function(_super) {
    __extends(Authentication, _super);

    function Authentication() {
      _ref1 = Authentication.__super__.constructor.apply(this, arguments);
      return _ref1;
    }

    Authentication.TEMPLATE = "<a href=\"http://localhost:3000/auth/authorize?redirect_to=http%3A%2F%2Flocalhost%3A4000\">\n  sign in\n</a>";

    Authentication.TEMPLATE_AFTER_SIGNED_IN = "<div class=\"name\">\n  welcome, {name}\n</div>";

    Authentication.prototype.initialize = function() {
      var _this = this;

      this.on('initialized', function() {
        return _this.render();
      });
      Qchan.mediator.on('loaded', function() {
        _this.updateUserWithURIFragments();
        return _this.triggerIfSignedIn();
      });
      Qchan.mediator.on('signedIn', function() {
        return _this.render();
      });
      return this.user = new Qchan.Models.User();
    };

    Authentication.prototype.updateUserWithURIFragments = function() {
      if (this.hasUserAttributes()) {
        return this.user.set(this.userAttributes());
      }
    };

    Authentication.prototype.triggerIfSignedIn = function() {
      if (this.user.access_token) {
        return Qchan.mediator.trigger('signedIn', this.user);
      }
    };

    Authentication.prototype.userAttributes = function() {
      return this.__userAttributes || (this.__userAttributes = Qchan.URIFragmentParser.parse(window.location.hash));
    };

    Authentication.prototype.hasUserAttributes = function() {
      return !!this.userAttributes().access_token;
    };

    Authentication.prototype.template = function() {
      if (this.user.access_token) {
        return $.render(this.constructor.TEMPLATE_AFTER_SIGNED_IN, this.user);
      } else {
        return Authentication.__super__.template.apply(this, arguments);
      }
    };

    return Authentication;

  })(Qchan.View);

  Qchan.Views.Header = (function(_super) {
    __extends(Header, _super);

    function Header() {
      _ref2 = Header.__super__.constructor.apply(this, arguments);
      return _ref2;
    }

    Header.TEMPLATE = "<h1>Qchan</h1>\n\n<div class=\"authentication\">\n  <a href=\"http://localhost:3000/auth/authorize?redirect_to=http%3A%2F%2Flocalhost%3A4000\">\n    sign in\n  </a>\n</div>";

    Header.prototype.initialize = function() {
      var _this = this;

      this.authentication = new Qchan.Views.Authentication(this, '.authentication');
      return this.on('initialized', function() {
        _this.render();
        return _this.authentication.trigger('initialized');
      });
    };

    return Header;

  })(Qchan.View);

  Qchan.Repository.register('user', new Qchan.Repositories.LocalStorage());

  Qchan.mediator = new Qchan.Mediator();

  new Qchan.Views.Application(null, '#application');

  Qchan.mediator.trigger('initialized');

  Qchan.mediator.trigger('loaded');

}).call(this);
