MySQL = {}					 --
	MySQL.host = "127.0.0.1"					 --
	MySQL.dbname = "madrisebd"					 --
	MySQL.username = "root"					 --
	MySQL.password = "root"					 --
	MySQL.share = 0					 --
					 --
--[[	MySQL.host = "127.0.0.1"					 --
	--MySQL.port = "3306"					 --
	MySQL.dbname = "gs18617"					 --
	MySQL.username = "gs18617"					 --
	MySQL.password = "ZpQ1i0mjvEyCkd1vli4gDNKsGXYNvNs4"					 --
	MySQL.share = 0]]					 --
					 --
Storage = nil					 --
function MySQL_connection()					 --
	Storage = dbConnect("mysql", "dbname="..MySQL.dbname..";host="..MySQL.host, MySQL.username, MySQL.password, "share="..MySQL.share)					 --
					 --
	--Storage = dbConnect("mysql", "dbname="..MySQL.dbname..";host="..MySQL.host..";port="..MySQL.port, MySQL.username, MySQL.password)					 --
	if Storage then 					 --
		outputDebugString("Подключение к MySQL - успешно.", 3) 					 --
	else					 --
		outputDebugString("Подключение к MySQL - не удалось.", 1) 					 --
	end 							 --
end					 --
MySQL_connection()					 --
					 --
function MSC()					 --
	return Storage					 --
end					 --
