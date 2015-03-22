mysql = require 'mysql'
cson = require 'cson'

class FastBricks

	loadConfig: (filename)->
		@config = cson.parseCSONFile(filename)
		@pool = mysql.createPool @config

	query: (bricksExpr, callback)->
		d = bricksExpr.toParams {placeholder: "?"}
		if bricksExpr.log
			console.log d.text
			console.log d.values
		@pool.query d.text,d.values, (err,res)->
			console.log err if err
			callback err,res

module.exports = FastBricks
