(function() {
  var URIFragmentParser = function(fragment) {
    this.fragment = fragment;
  };

  URIFragmentParser.parse = function(fragment) {
    return new this(fragment).parse();
  };

  URIFragmentParser.prototype.parse = function() {
    var table = {};
    var segments = this.segments();
    for (var i = 0, len = segments.length; i < len; i++) {
      var keyAndValue = segments[i].split('=', 2);
      if (keyAndValue[1]) {
        table[keyAndValue[0]] = window.decodeURIComponent(keyAndValue[1]);
      }
    }
    return table;
  };

  URIFragmentParser.prototype.segments = function() {
    return this.fragment.substr(1).split('&');
  };

  console.log(URIFragmentParser.parse(window.location.hash));
})();
