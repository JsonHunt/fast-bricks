mysql = require 'mysql'
cson = require 'cson'
sql = require('mssql')

class FastBricks

	loadConfig: (filename)->
		@config = cson.parseCSONFile(filename)
		if @config.driver_type is 'mysql'
			@pool = mysql.createPool @config

		# if @config.driver is 'sqlserver'

	query: (b,c)->
		@queryMySQL(b,c) if @config.driver_type is 'mysql'
		@querySQLServer(b,c) if @config.driver_type is 'sqlserver'

	queryMySQL: (bricksExpr, callback)->
		d = bricksExpr.toParams {placeholder: "?"}
		if bricksExpr.log
			console.log d.text
			console.log d.values
		@pool.query d.text,d.values, (err,res)->
			console.log err if err
			callback err,res

	querySQLServer: (bricksExpr, callback)->
		expr = bricksExpr.toString()
		if bricksExpr.log
			console.log expr
		connection = new sql.Connection(@config)
		connection.connect (err)->
			console.log err if err
			request = connection.request()
			request.query expr, (err, recordset) ->
				connection.close()
				callback(err,recordset)

module.exports = FastBricks
