txd = engineLoadTXD ('id400.txd')
engineImportTXD (txd, 400)
dff = engineLoadDFF ('id400.dff', 400)
engineReplaceModel (dff, 400)
