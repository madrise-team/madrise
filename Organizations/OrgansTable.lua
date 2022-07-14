function organsT()
------------------------------------------------------------------------------------
function convertOrgRanksToBd(ranks)			-- извлекаем только Зарплату  с ключ. названиеями должностей (остальное в БД нах не наъ)
	local t = {}
	for k,v in pairs(ranks) do
		t[k] = {v.salary}
	end
	return t
end


OrganizationsT = {}
	OrganizationsT.LSPD = {
		name = 'Полицейский Департамент города Лос-Сантос сос Сас лол',
		descr = 'Долгое описание организации занимается тем-то тем-то и там то находится, не для никого не секрет шо мусора волки позороные бля буду отвечаю.Пашол ты нахкй мусор я драм н бейс продессер. Большое разнообрание однотипных работ и много другое увлекательное иди нахуй.',
		ranks = {
			leader = {name = "Лидер LSPD",				salary = 20000	},
			zam = {name = "Заместитель лидера LSPD",	salary = 15000	},
			swatLeader = {name = "Начальник SWAT",		salary = 10000	},
			swat = {name = "Боец SWAT",					salary = 7500	},
			patrulLeader = {name = "Начальник патруля",	salary = 5000	},
			patrul = {name = "Сотрудник патруля",		salary = 2500	}
		}
	}


OrganizationsT = {}
	OrganizationsT.Voenka = {
		name = 'Военка',
		descr = 'Саня, вставь описание',
		ranks = {
			leader = {name = "Лидер Воека",				salary = 20000	},
			zam = {name = "Заместитель лидера Военка",	salary = 15000	},
			swatLeader = {name = "Начальник Военка",		salary = 10000	},
			swat = {name = "Боец Военка",					salary = 7500	},
			patrulLeader = {name = "Начальник патруля Военка",	salary = 5000	},
			patrul = {name = "Сотрудник патруля Военка",		salary = 2500	}
		}
	}








------------------------------------------------------------------------------------
end
return organsT