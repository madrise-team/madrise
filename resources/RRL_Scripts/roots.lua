orgRoots = {}					 --
					 --
					 --
					 --
orgRoots.vlls_orgpack_Ubergeneral = {					 --
	"vlls_orgpack_neosoldat",					 --
					 --
					 --
	"vlls_tojeNeponatnoZachem",					 --
	"vlls_SluchynoDobavilEtoPravo",					 --
}					 --
					 --
orgRoots.vlls_orgpack_neosoldat = {  -- Нео-Солдат					 --
	"vlls_orgpack_soldat", -- Доступ к правам рядового солдата					 --
	"vlls_non",	 					 --
	"vlls_sosiHeh"					 --
}					 --
					 --
orgRoots.vlls_orgpack_soldat = {  -- Солдат					 --
	"vlls_portVorota",		-- Открытие ворот на военке в порту ЛС 					 --
	"vlls_portInter"			-- Доступ в интерьер военки ЛС					 --
}					 --
					 --
					 --
function getOrgRootPackage(packageKey)					 --
	return orgRoots[packageKey]					 --
end					 --
