sql = require 'sql-bricks'
FastBricks = require './fast-bricks'

fb = new FastBricks()
fb.loadConfig('sqlserver-config.cson')
expr = sql.select('TOP 10 *').from('[Artesia].[dbo].[Centre]')
expr.log = true

console.log fb.prototype


fb.query expr, (err, recordset) ->
	console.log recordset
