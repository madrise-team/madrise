----- imports
loadstring(exports.importer:load())()
import('RRL_Scripts/usfulS.lua')()    -- Usful Server
------------------------------------

function onJoin()
	fadeCamera (source, false, 900)
	setPlayerPositon(source, 0, 0, 10000, 0, 0, 1)
	setElementFrozen (source, true)
	outputChatBox("Добро пожаловать!", source)
	outputChatBox("Для регистрации введите: /reg 'login' 'password' 'nickname'", source)
	outputChatBox("Для входа введите: /log 'login' 'password'", source)
end
function getLocalBdAccount(username,password)
	local localBdAccount = getAccount(username, password)
	if not localBdAccount then localBdAccount = addAccount(username,password) end
	return localBdAccount
end

function regPlayer(source, commandName, username, password, nickname)
	if( (password ~= "") and (password ~= nil) and (username ~= "") and (username ~= nil) and (nickname ~= nil) and (nickname ~= "")) then
		local accountCreated = getLocalBdAccount(username,password)
		if(accountCreated) then
			if dbExec(SQLStorage,"INSERT INTO `accounts` (`login`, `password`, `nickname`) VALUES (?,?,?)",username,password,nickname) then
				outputChatBox("Аккаунт успешно зарегистрирован!",source)
				outputChatBox("Для входа введите: /log 'login' 'password'", source)
			end
		else
			outputChatBox("Ошибка регистрации новго аккаунта: пролемы с соединением... Поробуйте позже(",source)
		end
	else
		outputChatBox("Ошибка создания аккаунта",source)
		outputChatBox("Для регистрации введите: /reg 'login' 'password'", source)
		outputChatBox("Логин, пароль и никнейм должны содержать от 1 до 30 символов", source)
	end
end

function logPlayer(source, command, username, password)
	local qh
	qh = dbQuery(function()
		local response = dbPoll(qh,0)[1]
		if response then
			local account = getLocalBdAccount(username, password)
			logIn(source, account, password)
			setPlayerPositon(source, 1732.72, -1911.99, 13.56, 270, 0, 0)
			fadeCamera (source, true, 3)
			setElementFrozen (source, false)
			playerLogined(source,response,account)
		else
			outputChatBox("Неверный логин или пароль", source)
			outputChatBox("Для регистрации введите: /reg 'login' 'password'", source)
			outputChatBox("Для входа введите: /log 'login' 'password'", source)
		end
	end,SQLStorage,"SELECT * FROM `accounts` WHERE (`login` = ? AND `password` = ?)",username,password)
end




addCommandHandler("reg", regPlayer)
addCommandHandler("log", logPlayer)
addEventHandler("onPlayerJoin", root, onJoin)


function playerLogined(player,bdAccount,localBdAccount)
	setElementData(player,"playerData",{nickname = bdAccount.nickname, id = bdAccount.id})
	
	triggerEvent("playerLogin",player,bdAccount,localBdAccount)
	triggerClientEvent(player,"playerLogin",root)
end