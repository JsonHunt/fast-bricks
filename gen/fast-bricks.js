// Generated by CoffeeScript 1.9.1
(function() {
  var FastBricks, cson, mysql;

  mysql = require('mysql');

  cson = require('cson');

  FastBricks = (function() {
    function FastBricks() {}

    FastBricks.prototype.loadConfig = function(filename) {
      this.config = cson.parseCSONFile(filename);
      return this.pool = mysql.createPool(this.config);
    };

    FastBricks.prototype.query = function(bricksExpr, callback) {
      var d;
      d = bricksExpr.toParams({
        placeholder: "?"
      });
      if (bricksExpr.log) {
        console.log(d.text);
        console.log(d.values);
      }
      return this.pool.query(d.text, d.values, function(err, res) {
        if (err) {
          console.log(err);
        }
        return callback(err, res);
      });
    };

    return FastBricks;

  })();

  module.exports = FastBricks;

}).call(this);

//# sourceMappingURL=fast-bricks.js.map