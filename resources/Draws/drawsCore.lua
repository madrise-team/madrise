function Draws()
----- import Interface
loadstring(exports.importer:load())()
import('Draws/Interface.lua')()
import('RRL_Scripts/usfulSh.lua')()
import('RRL_Scripts/usfulC.lua')()
------------------------------------
_ = nil
	
GElements = {}
GElements.name = "GElements"
GElements.locSize = {cutX=0,cutY=0,cutW=screenW,cutH=screenH,cpx = 0,cpy = 0,x = 0,y = 0,x1 = 0,y1 = 0,x2 = 0,y2 = 0,w = screenW,h = screenH}
GElements.imgP = {color = {childA = 255}}
GElements.elements = {}

updated = false -- if true then RT`s was cleared


--- Утилиты ---------------------------------------------------------------------------------------------------------------------------
---RT`s
_RTsLevels = {}

local originalDxSetRT = dxSetRenderTarget
dxSetRenderTarget = function(RT,clear)
	if RT == nil then
		if #_RTsLevels > 0 then
			originalDxSetRT(_RTsLevels[#_RTsLevels])
			return
		end
	end
	originalDxSetRT(RT,clear)
end
function enterToRT(RT,clear)
	if not RT then outputDebugString("no RT to save!!") ; return end

	_RTsLevels[#_RTsLevels + 1] = RT
	dxSetRenderTarget(RT,clear)
end
function escapeRT()
	_RTsLevels[#_RTsLevels] = nil
	dxSetRenderTarget()
end
---/RT

function drawBorder(x,y,w,h,color,lineW)
	dxDrawLine (x,y,x+w,y, 		color, lineW, true)
	dxDrawLine (x+w,y,x+w,y+h, 	color, lineW, true)
	dxDrawLine (x+w,y+h,x,y+h, 	color, lineW, true)
	dxDrawLine (x,y+h,x,y, 		color, lineW, true)
	
end

--- Полезные функции работы с элементами ----------------------------------------------------------------------------------------------
function formattColor(color)
	local fromattedColor = color or {}
	if type(color) == "number" then 
		local extrCol = fromColor(color)
		fromattedColor = {r = extrCol.r,g = extrCol.g,b = extrCol.b,a = extrCol.a}
		return fromattedColor
	end
		fromattedColor.r = fromattedColor.r or 255
		fromattedColor.g = fromattedColor.g or 255
		fromattedColor.b = fromattedColor.b or 255
		fromattedColor.a = fromattedColor.a or 255
	return fromattedColor
end
function findElmUnderCursor(elementsArray,parentCoodsX,parentCoodsY)  	-- Координаты родителя необходимы для вычесления коорды элемента
	parentCoodsX = parentCoodsX or 0									-- на экране (т.к. корды элма хранятся относительно родителя)
	parentCoodsY = parentCoodsY or 0
	for i=#elementsArray,1,-1 do 									  
		local elm = elementsArray[i]
		local elmX = parentCoodsX + elm.locSize.x
		local elmY = parentCoodsY + elm.locSize.y
		if isPointInQuad(cursorPosX,cursorPosY,elmX,elmY,elm.locSize.w,elm.locSize.h) and elm.toggle then
			return findElmUnderCursor(elm.elements,elmX,elmY) or elm
		end
	end
end
function findScrollElmUnderCursor(elementsArray,parentCoodsX,parentCoodsY) 
	parentCoodsX = parentCoodsX or 0
	parentCoodsY = parentCoodsY or 0
	for i=#elementsArray,1,-1 do
		local elm = elementsArray[i]
		local elmX = parentCoodsX + elm.locSize.x
		local elmY = parentCoodsY + elm.locSize.y
		if isPointInQuad(cursorPosX,cursorPosY,elmX,elmY,elm.locSize.w,elm.locSize.h) then
			local sElm2
			if elm.type == "scrollTIV" then
				sElm2 = elm
			end
			return findScrollElmUnderCursor(elm.elements,elmX,elmY) or sElm2
		end
	end
end
function searchByName(elm,name)
	if elm.name == name then 
		return elm
	elseif #elm.elements > 0 then
		for i,v in ipairs(elm.elements) do
			local podElm = searchByName(v,name) -- Элемент может быть либо искомым элментом либо False
			if podElm then return podElm end
		end
	end

	return false
end
------ Регистрация пользовательских событий   --------
addEvent("onInterfaceMouseDown")
---- Обработки мыши (до вызов соответсвующих методов у элементов интерфейса) ---
-- cursor
cursorPosX = 0
cursorPosY = 0
cursorPressed = false
-- ------
CElm = nil				-- Элемент с которым в данный момент происходит взамодействие
PressedCElm = nil		-- Последний элемент на которого нажали курсором (Last "mouseDown" element)


addEventHandler("onClientRender",getRootElement(),function()		-- Обработка кадра
	if not isCursorShowing() then 
		CElm = nil
		PressedCElm = nil
		return
	end

	cursorPosX,cursorPosY = getCursorPosition()
	
	cursorPosX = cursorPosX * screenW
	cursorPosY = cursorPosY * screenH
	local findedElm = findElmUnderCursor(GElements.elements,0,0)
	-- Попадание куссора на новый элемент 										--
	if not (findedElm == CElm) then
		if CElm then 
			--CElm:cursorUp()
			CElm:cursorExit()	-- Прекращаем взаимодействие со старым элементом
			PressedCElm = nil
		end
		CElm = findedElm
		if CElm then CElm:cursorEnter() end --Новый эемент
	end
	-----																		--


	-- Клик по элементу           												--
	if getKeyState ("mouse1") then
		if CElm and (not cursorPressed) then
			PressedCElm = CElm
			PressedCElm:cursorDown()
		end
		cursorPressed = true
	else
		if PressedCElm then 
			PressedCElm:cursorUp()
			PressedCElm:cursorClick()
			PressedCElm = nil
		end
		cursorPressed = false
	end
	-----								  										--

	if scrlMDownedElm then scrlMDownedElm:swaperProcessing(cursorPosX,cursorPosY) end
end)
-- 					Обработка скроллов										--
	function scrollerHandler(_,_,upOrDown)
		local scrElm = findScrollElmUnderCursor(GElements.elements,0,0)
		if scrElm then
			scrElm:mover(upOrDown)
		end
	end
	bindKey("arrow_u","down",scrollerHandler,-1)
	bindKey("mouse_wheel_up","down",scrollerHandler,-1)
	bindKey("arrow_d","down",scrollerHandler,1)
	bindKey("mouse_wheel_down","down",scrollerHandler,1)
	
scrlMDownedElm = nil
	bindKey("mouse1","down",function()
		scrlMDownedElm = findScrollElmUnderCursor(GElements.elements,0,0)
		if scrlMDownedElm then
			scrlMDownedElm:swaper(true)
		end
	end)
	bindKey("mouse1","up",function()
		if scrlMDownedElm then
			scrlMDownedElm:swaper()
			scrlMDownedElm = nil
		end
	end)
-----								  										--
----------------------------------------------------------------------------------


-- TIV -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function extended (child, parent)
    setmetatable(child,{__index = parent}) 
end

TIV = {}
function TIV:create(LocSize,Img,Text,Name,Parent)
	local this = {}
	
	local Parent = Parent or "GElements"

	this.elements = {}
	this.name = Name or "noName"
	this.type = "TIV"
	this.toggle = true

	this.skip = 0

	this.locSize = copyTable(LocSize)
	this.locSize.anchor = this.locSize.anchor or {["alignX"] = 0,["alignY"] = 0}
	this.locSize.x1 = this.locSize.x or 0
	this.locSize.y1 = this.locSize.y or 0
	this.locSize.x2 = this.locSize.x2 or 0
	this.locSize.y2 = this.locSize.y2 or 0

	this.textP = copyTable(Text)
	this.textP.x = this.textP.x or 0
	this.textP.y = this.textP.y or 0
	this.textP.w = this.textP.w or this.locSize.w
	this.textP.h = this.textP.h or this.locSize.h
	this.textP.color = this.textP.color or tocolor(255,255,255,255)

	if this.locSize.adapt ~= false then this.locSize.adapt = true end
	if this.locSize.adaptPos ~= false then this.locSize.adaptPos = true end
	if this.locSize.adaptTextPos ~= false then this.locSize.adaptTextPos = true end

	if this.locSize.adapt then
		if this.locSize.adaptPos then
			this.locSize.x1 = math.floor(this.locSize.x1*msw)
			this.locSize.y1 = math.floor(this.locSize.y1*msw)
			this.locSize.x2 = math.floor(this.locSize.x2*msw)
			this.locSize.y2 = math.floor(this.locSize.y2*msw)
			this.locSize.x  = math.floor(this.locSize.x *msw)
			this.locSize.y  = math.floor(this.locSize.y *msw)
		end
		if this.locSize.adaptTextPos then
			this.textP.x = math.floor(this.textP.x * msw)
			this.textP.y = math.floor(this.textP.y * msw)
			this.textP.w = math.floor(this.textP.w * msw)
			this.textP.h = math.floor(this.textP.h * msw)
		end

		this.locSize.w  = math.floor(this.locSize.w *msw)
		this.locSize.h  = math.floor(this.locSize.h *msw)
	end


	this.imgP = copyTable(Img)
	this.imgP.color = formattColor(this.imgP.color)
	this.imgP.color.childA = 255
	if this.imgP.originalSize then
		this.imgP.maxS = {
			maxW = createMaxerFuc(this.imgP.originalSize.w),
			maxH = createMaxerFuc(this.imgP.originalSize.h)}
	end


    if this.textP.text then this.textP.textRT = dxCreateRenderTarget (this.locSize.w, this.locSize.h, true) end

	this.parent = searchByName(GElements,Parent)
	if not this.parent then 
		outputDebugString("Can't find parent for: "..this.name) 
		this.parent = GElements
	end

	if insertIndx then
		this.index = insertIndx
		table.insert(this.parent.elements,this)
	else
		this.index = #this.parent.elements + 1
		this.parent.elements[this.index] = this
	end

	setmetatable(this, self)
	self.__index = self

	if this.parent.Draw then this.parent:Draw(false) end     -- костылик, фиксит для некторых случаеа положение элементов на 1м кадре после создания, отрисовка без отрисовки.
	this:Draw(false)

	if this.imgP.img then
		if type(this.imgP.img) == "table" then --- RT for nslice
			this.imgP.slice9RT = dxCreateRenderTarget (2, 2, true)
		end
		if type(this.imgP.img) == "function" then --- save imageFuc to draw it
			this.textureFuc = this.imgP.img
			this.imgP.img = nil
		end 
	end
	
	this.hierarchyDraw = true

	return this
end
function TIV:getParent()
	return self.parent
end
function TIV:getXYWH()
	return self.locSize.x,self.locSize.y,self.locSize.w,self.locSize.h
end
function TIV:getLocSize()
	return self.locSize
end
function TIV:getDirections()
	if self.locSize.anchor.landing == "horizontal" then
		return "x","y",1,0
	elseif self.locSize.sizeType == "dynamic" then
		return "y","x",0,1
	end
	return _,_,1,1
end
function TIV:calcSize()
	if self.locSize.sizeType == "dynamic" then
		if self.textP.text then
			local tw,th = dxGetTextSize(self.textP.text, self.locSize.w, self.textP.scaleXY or 1.0,self.textP.scaleY or 1.0, self.textP.font, true)
			return Vector2(self.locSize.w,th)
		else
			local directionIndx, supDirectionIndx = self:getDirections()

			local size = Vector2(0,0)
			for i,chElm in ipairs(self.elements) do
				local chSize = chElm:calcSize() + Vector2(chElm.locSize.x1,chElm.locSize.y1) + Vector2(chElm.locSize.x2,chElm.locSize.y2)
				size[directionIndx] = size[directionIndx] + chSize[directionIndx]
				
				if size[supDirectionIndx] < chSize[supDirectionIndx] then
					size[supDirectionIndx] = chSize[supDirectionIndx]
				end

			end
			return size
		end
	else
		return Vector2(self.locSize.w,self.locSize.h)
	end
end
function TIV:Update(sizer)
	local cwh
	if sizer then cwh = sizer else cwh = self:calcSize() end

	self.locSize.w = cwh.x
	self.locSize.h = cwh.y

	local pLS = self.parent.locSize

	self.locSize.cpx = pLS.cpx + self.locSize.x
	self.locSize.cpy = pLS.cpy + self.locSize.y

	self.locSize.cutX = self.locSize.cpx
	self.locSize.cutY = self.locSize.cpy
	if self.locSize.cutX < self.parent.locSize.cutX then self.locSize.cutX = self.parent.locSize.cutX end
	if self.locSize.cutY < self.parent.locSize.cutY then self.locSize.cutY = self.parent.locSize.cutY end

	self.locSize.cutW = self.locSize.w - (self.locSize.cutX - self.locSize.cpx)
	self.locSize.cutH = self.locSize.h - (self.locSize.cutY - self.locSize.cpy)
	if self.locSize.cutX + self.locSize.cutW > pLS.cutX + pLS.cutW then self.locSize.cutW = (pLS.cutX + pLS.cutW) - self.locSize.cutX end
		if self.locSize.cutW < 0 then self.locSize.cutW = 0 end
	if self.locSize.cutY + self.locSize.cutH > pLS.cutY + pLS.cutH then self.locSize.cutH = (pLS.cutY + pLS.cutH) - self.locSize.cutY end
		if self.locSize.cutH < 0 then self.locSize.cutH = 0 end

	self.locSize.left = -(self.locSize.cutX - self.locSize.cpx) + self.textP.x
	self.locSize.top = -(self.locSize.cutY - self.locSize.cpy) + self.textP.y
	self.locSize.right = self.locSize.left + self.locSize.w
	self.locSize.bottom = self.locSize.top + self.locSize.h

	--  /  ----  /  ----  /  ----  /  ----  /  ----  /  --
	self.locSize.left = math.floor(self.locSize.left)
	self.locSize.top = math.floor(self.locSize.top)
	self.locSize.right = math.floor(self.locSize.right)
	self.locSize.bottom = math.floor(self.locSize.bottom)
	self.locSize.cpx = math.floor(self.locSize.cpx)
	self.locSize.cpy = math.floor(self.locSize.cpy)
	self.locSize.cutX = math.floor(self.locSize.cutX)
	self.locSize.cutY = math.floor(self.locSize.cutY)
	self.locSize.cutW = math.floor(self.locSize.cutW)
	self.locSize.cutH = math.floor(self.locSize.cutH)
	--  /  ----  /  ----  /  ----  /  ----  /  ----  /  --

	if self.imgP.maxS then
		self.imgP.sectK = {
			wK = self.imgP.originalSize.w / (self.locSize.right - self.locSize.left),
			hK = self.imgP.originalSize.h / (self.locSize.bottom - self.locSize.top)}
	end
end
function TIV:Draw(drawing,childsDraw,selfDraw)
	if self.skip > 0 then
		doDraw = false
		self.skip = self.skip - 1
	end

	self:Update(_)

	local doDraw = true
	if drawing == false then doDraw = false end
	local doChildsDraw = true
	if childsDraw == false then doChildsDraw = false end
	local doSelfDraw = true
	if selfDraw == false then doSelfDraw = false end
	




	if doDraw then
		if (updated or self.imgP.frame or (not self.imgP.img)) and (self.textureFuc ~= nil) then
			self.imgP.img = self.textureFuc(self.imgP.img,self)
		end
	 if doSelfDraw then		
		local theColor = tocolor(self.imgP.color.r,self.imgP.color.g,self.imgP.color.b,self.imgP.color.a * (self.parent.imgP.color.childA/255))
		local n0cutW = self.locSize.cutW
		local n0cutH = self.locSize.cutH
		if n0cutW <= 0 then n0cutW = 1 end
		if n0cutH <= 0 then n0cutH = 1 end
		if type(self.imgP.img) == "table" then							-- 9 slice draw
			local imgT = self.imgP.img 		--
			local size = self.locSize 		 -- shortcuts
			local imgSize = imgT.size  		--
			local left = self.locSize.left --
			local top = self.locSize.top --
		
			local n0RtW,n0RtH = dxGetMaterialSize(self.imgP.slice9RT)
			if (n0RtW ~= n0cutW) or (n0RtH ~= n0cutH) then
				destroyElement(self.imgP.slice9RT)
				self.imgP.slice9RT = dxCreateRenderTarget(n0cutW,n0cutH,true)
			end		

			local topWcut = maxer(size.w - imgT.tl.w - imgT.tr.w,imgSize.w - imgT.tl.w - imgT.tr.w)
			local botmWcut = maxer(size.w - imgT.br.w - imgT.bl.w,imgSize.w - imgT.br.w - imgT.bl.w)
			local leftHcut = maxer(size.h - imgT.tl.h - imgT.bl.h,imgSize.h - imgT.tl.h - imgT.bl.h)
			local rightHcut = maxer(size.h - imgT.tr.h - imgT.br.h,imgSize.h - imgT.tr.h - imgT.br.h)
			
			dxSetRenderTarget(self.imgP.slice9RT,true)
			local savedBM = dxGetBlendMode()
			dxSetBlendMode("add")
			-----
																																																																		--
			dxDrawImageSection (left,top,imgT.tl.w, imgT.tl.h, 																				0,0,imgT.tl.w, imgT.tl.h,																			imgT.img, 0,0,0, theColor)	--tl -
			dxDrawImageSection (left + size.w - imgT.tr.w,top,imgT.tr.w, imgT.tr.h, 														imgSize.w - imgT.tr.w,0,imgT.tr.w, imgT.tr.h,														imgT.img, 0,0,0, theColor)	--tr -
			dxDrawImageSection (left,top + size.h - imgT.bl.h,imgT.bl.w,imgT.bl.h, 															0,imgSize.h - imgT.bl.h,imgT.bl.w,imgT.bl.h,														imgT.img, 0,0,0, theColor)	--bl -
			dxDrawImageSection (left + size.w - imgT.br.w,top + size.h - imgT.br.h,imgT.br.w,imgT.br.h, 									imgSize.w - imgT.br.w,imgSize.h - imgT.br.h,imgT.br.w,imgT.br.h,									imgT.img, 0,0,0, theColor)	--br -
																																																																					
			dxDrawImageSection (left + imgT.tl.w,top,size.w - imgT.tl.w - imgT.tr.w,imgT.t.space, 											imgT.tl.w,0,topWcut,imgT.t.space,		 															imgT.img, 0,0,0, theColor)	--t  -
			dxDrawImageSection (left,top + imgT.tl.h,imgT.l.space,size.h - imgT.tl.h - imgT.bl.h, 											0,imgT.tl.h,imgT.l.space, leftHcut,																	imgT.img, 0,0,0, theColor)	--l  -
			dxDrawImageSection (left + size.w - imgT.r.space,top + imgT.tr.h,imgT.r.space,size.h - imgT.tr.h - imgT.br.h, 					imgSize.w - imgT.r.space,imgT.tr.h,imgT.r.space, rightHcut,											imgT.img, 0,0,0, theColor)	--r  -
			dxDrawImageSection (left + imgT.bl.w,top + size.h - imgT.b.space, size.w - imgT.br.w - imgT.bl.w, imgT.b.space, 				imgT.bl.w,imgSize.h - imgT.b.space, botmWcut, imgT.b.space,	 										imgT.img, 0,0,0, theColor)	--b  -
																																																																					
			dxDrawImageSection (left + imgT.l.space,top + imgT.t.space,size.w-imgT.l.space-imgT.r.space,size.h-imgT.t.space-imgT.b.space, 	imgT.l.space,imgT.t.space,imgSize.w-imgT.l.space-imgT.r.space,imgSize.h-imgT.t.space-imgT.b.space, 	imgT.img, 0,0,0, theColor)	--c  -
																																																																		--
			-----
			dxSetBlendMode(savedBM)
			dxSetRenderTarget()
			dxDrawImage(self.locSize.cutX, self.locSize.cutY, self.locSize.cutW, self.locSize.cutH, self.imgP.slice9RT)

		elseif self.imgP.img then										-- normall image draw
			local sectW = self.locSize.cutW
			local sectH = self.locSize.cutH

			if self.imgP.maxS then
				sectW = self.imgP.maxS.maxW(sectW) * self.imgP.sectK.wK
				sectH = self.imgP.maxS.maxH(sectH) * self.imgP.sectK.hK
			end

			dxDrawImageSection (self.locSize.cutX, self.locSize.cutY, self.locSize.cutW, self.locSize.cutH,
                          		self.locSize.cutX - self.locSize.cpx, self.locSize.cutY - self.locSize.cpy, sectW, sectH,
                           		self.imgP.img,
                        		self.imgP.rotation or 0, self.imgP.rotationCenterOffsetX or 0, self.imgP.rotationCenterOffsetY or 0,
                          		theColor )
		end
		if self.textP.text then											-- text draw
			local left = self.locSize.left
			local top = self.locSize.top
			
			local rttW,rttH = dxGetMaterialSize(self.textP.textRT)

			if (rttW ~= self.locSize.cutW) or (rttH ~= self.locSize.cutH) then
				if not ((self.locSize.cutH <= 0) or (self.locSize.cutW <= 0)) then
					destroyElement(self.textP.textRT)
					self.textP.textRT = dxCreateRenderTarget(self.locSize.cutW,self.locSize.cutH,true)
				end
			end

			local savedBM = dxGetBlendMode()
			dxSetBlendMode("modulate_add")
			dxSetRenderTarget(self.textP.textRT,true)

			dxDrawText (self.textP.text, left, top, left + self.textP.w, top + self.textP.h,
				self.textP.color or tocolor(255,255,255,255), self.textP.scaleXY or 1.0, self.textP.scaleY or 1.0 , self.textP.font or "default",
				self.textP.alignX or "left",self.textP.alignY or "top", true, self.textP.wordBreak or true,false,false,true,
				self.textP.fRotation or 0.0,self.textP.fRotationCenterX or 0.0,self.textP.fRotationCenterY or 0.0)

			dxSetBlendMode(savedBM)
			dxSetRenderTarget()
			dxDrawImage(self.locSize.cutX, self.locSize.cutY, self.locSize.cutW, self.locSize.cutH, self.textP.textRT, 0,0,0 ,theColor)
		end
	 end
	end

	if doChildsDraw then -------------------------------child Draw -{
		local dynamic,_,xk,yk = self:getDirections() 

		local lstCord = 0
		for i,chElm in ipairs(self.elements) do
			local chElmX = (chElm.locSize.x1 + self.locSize.anchor.alignX*self.locSize.w) - (self.locSize.anchor.alignX*chElm.locSize.w)
			local chElmY = (chElm.locSize.y1 + self.locSize.anchor.alignY*self.locSize.h) - (self.locSize.anchor.alignY*chElm.locSize.h)
				
			chElm.locSize.x = lstCord*xk + chElmX
			chElm.locSize.y = lstCord*yk + chElmY
				
			if dynamic then lstCord = lstCord + (chElmX + chElm.locSize.w + chElm.locSize.x2)*xk + (chElmY + chElm.locSize.h + chElm.locSize.y2)*yk end

			if doDraw then
				if chElm.hierarchyDraw then
			 		chElm:Draw()
			 	end
			end
		end
		if not doDraw then 
			if self.parent.Draw then self.parent:Draw(false) end
		end
	end 					-------------------------------------------------_}

   --  .  - - debDraw
   	--drawBorder(self.locSize.cpx,self.locSize.cpy,self.locSize.w,self.locSize.h,tocolor(255,100,100,255),3)
	--dxDrawRectangle(self.locSize.cpx,self.locSize.cpy,self.locSize.w,self.locSize.h,tocolor(0,0,0,60))
	--dxDrawText(self.name,self.locSize.cpx,self.locSize.cpy)
   --  .  - - debDraw

	return self.texture
end
function TIV:cursorEnter()
	--outputChatBox(self.name.." <<- entered")
end
function TIV:cursorExit()
	--outputChatBox(self.name.." ->> exited")
end
function TIV:cursorDown()
	--outputChatBox(self.name.." cDown")
end
function TIV:cursorUp()
	--outputChatBox(self.name.." cUP")
end
function TIV:cursorClick()
	--outputChatBox(self.name.." click")
end
function TIV:Destroy()	
	self.destoyed = true

	for i,chElm in rpairs(self.elements) do
		if chElm then chElm:Destroy() end
	end

	if self.textP.textRT then destroyElement(self.textP.textRT) ; self.textP.textRT = nil end
	if self.imgP.slice9RT then destroyElement(self.imgP.slice9RT) ; self.imgP.slice9RT = nil end
	if self.imgP.textureFuc and self.imgP.img then
		if getElementType(self.imgP.img) == "texture" then
			destroyElement(self.imgP.img) ; self.imgP.img = nil
			self.textureFuc = nil
		end
	end

	self.parent.elements[self.index] = nil

	if self.destruction then
		self.destruction(self)
	end

	self = nil	
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

cTIV = {}
extended (cTIV, TIV)
function cTIV:create(LocSize,Img,Text,Name,Parent,Functs)
	local this = TIV:create(LocSize,Img,Text,Name,Parent)

	
	this.functs = Functs or {}
	if type(Functs) == 'function' then this.functs = {cursorClick = Functs} end
	this.type = "cTIV"

	setmetatable(this, self)
	self.__index = self
	return this
end
function cTIV:cursorEnter()
	if self.functs.cursorEnter then self.functs.cursorEnter() end
end
function cTIV:cursorExit()
	if self.functs.cursorExit then self.functs.cursorExit() end
end
function cTIV:cursorDown()
	if self.functs.cursorDown then self.functs.cursorDown() end
end
function cTIV:cursorUp()
	self:cursorEnter()
	if self.functs.cursorUp then self.functs.cursorUp() end
end
function cTIV:cursorClick()
	if self.functs.cursorClick then self.functs.cursorClick() end
end


scrollTIV = {}
extended (scrollTIV, TIV)
function scrollTIV:create(LocSize,Name,Parent)
	local scrlP_name = Name.."_scroll"
	local this = TIV:create(LocSize,nil,nil,scrlP_name,Parent)
	this.area = TIV:create({x=0,y=0,w=this.locSize.w,h=this.locSize.h,adapt = false},nil,nil,Name,this.name)
	this.area.destruction = function() 	this:Destroy()	end

	this.type = "scrollTIV"

	this.functs = Functs or {}
	this.mPressed = false
	this.scrollVelocity = 0
	this.returnVelocity = 0
	this.contentToHkoef = 1

	this.slidersT = {
		{x = 0, 				 w = 8, h = 16, color = tocolor(140,140,140,200),frame = false, dontFadeSlider = false},
		{x = this.locSize.w - 8, w = 8, h = 16, color = tocolor(140,140,140,200),frame = false, dontFadeSlider = false}
	}
	
	if LocSize.slidersT then
		this.slidersT = LocSize.slidersT
	end
	this.sliderShowed = false

	setmetatable(this, self)
	self.__index = self

	this:createSliders()

	return this
end
function scrollTIV:createSliders()
	if self.sliders then
		for k,v in pairs(self.sliders) do
			v:Destroy()
		end
	end
	self.slidersCount = #self.slidersT

	self.sliders = {}
	for i=1,self.slidersCount do
		local slTab = self.slidersT[i]
		local sliderTex = slTab.img or createTexFucFromDraws(slTab.w,slTab.h,function()
			dxDrawRectangle(0,0,slTab.w,slTab.h,slTab.color)
		end)
		self.sliders[i] = TIV:create({x=slTab.x,y=0,w=slTab.w,h=slTab.h},{adapt = slTab.adapt, frame = slTab.frame,img = sliderTex},nil,self.name.."slider"..i,self.name)
		
		self.sliders[i].sliderShowFrames = slTab.showFrames or 8
		self.sliders[i].sliderHideFrames = slTab.hideFrames or self.sliders[i].sliderShowFrames

		if slTab.dontFadeSlider then 	self.sliders[i].dontFadeSlider = slTab.dontFadeSlider
		else 							self.sliders[i].imgP.color.a = 0 				end
	end
end
function scrollTIV:processSliders()
	if self.scrollVelocity ~= 0 then
		if not self.sliderShowed then
			for k,v in pairs(self.sliders) do
				if not v.dontFadeSlider then
					local showFrames = v.sliderShowFrames
					animate(v,Animations.simpleFade,{frameCount = showFrames,startA = 0,endA = 255})
				end
			end
			self.sliderShowed = true
		end
	else
		if self.sliderShowed and (not self.mPressed) then
			for i,v in rpairs(self.sliders) do
				if not v.dontFadeSlider then
					local hideFrames = v.sliderHideFrames
					animate(v,Animations.simpleFade,{frameCount = hideFrames,startA = v.imgP.color.a,endA = 0})
				end
			end
			self.sliderShowed = false
		end
	end
end
function scrollTIV:calcSize()
	local bottom = self.locSize.h
	for k,elm in pairs(self.area.elements) do
		local elmBottom = elm.locSize.y1 + elm.locSize.h + elm.locSize.y2
		if elmBottom > bottom then
			bottom = elmBottom
		end
	end
	self.contentToHkoef = self.area.locSize.h / self.locSize.h
	self.area:Update(Vector2(self.area.locSize.w,bottom))
end
function scrollTIV:Update()
	self:calcSize()
	self.locSize.anchor.alignY = self.locSize.anchor.alignY + (self.scrollVelocity/self.contentToHkoef)

	if self.locSize.anchor.alignY < 0 then
		self.returnVelocity = self.locSize.anchor.alignY / 1.8
	end

	if self.locSize.anchor.alignY > 1 then
		self.returnVelocity = (self.locSize.anchor.alignY - 1)/1.8
	end
	
	self.locSize.anchor.alignY = self.locSize.anchor.alignY - self.returnVelocity
	
	self.scrollVelocity = self.scrollVelocity / 1.12
	self.returnVelocity = self.returnVelocity / 1.3
	if math.abs(self.scrollVelocity) <= 0.001 then self.scrollVelocity = 0 end

	self:processSliders()
end
function scrollTIV:mover(yDir)
	self.scrollVelocity = (self.scrollVelocity + yDir/60)
end
function scrollTIV:swaperProcessing(cx,cy)
	self.scrollVelocity = -(((cy - self.prevCursorPosY) / (self.area.locSize.h - self.locSize.h) * self.contentToHkoef)) + self.scrollVelocity/2
	self.prevCursorPosY = cy
end

function scrollTIV:swaper(action)
	if action then
		cursorPosX,cursorPosY = getCursorPosition()
		self.pushCursorPosX = cursorPosX * screenW
		self.pushCursorPosY = cursorPosY * screenH

		self.prevCursorPosX = self.pushCursorPosX
		self.prevCursorPosY = self.pushCursorPosY

		self.mPressed = true
	else
		self.mPressed = false
	end
end


---  Открисовка элементов ------------------------------------------------------------------------------------------------------------
skip = false
function DrawElements()
	for i,GElm in ipairs(GElements.elements) do
		GElm:Draw()
	end
end
addEventHandler("onClientRender",root,DrawElements)

function handleRestore( didClearRenderTargets )
    if didClearRenderTargets then
        updated = true
    end
end
addEventHandler("onClientRestore",root,handleRestore)
























------------Win debugs -------------------------------------------------------------------------------------------------------

_winDebugDraw = false
_winDebugDrawGraf = false
_winDebugDrawMemr = false
_winDebugDrawFullScreen = false
								_wDDT_w = 3     -- RT`size (from wh of screen)
								_wDDT_h = 3
_wDDT_z = _wDDT_h


if _wDDT_w < _wDDT_h then _wDDT_z = _wDDT_w end

_wDDT_poses = {{screenW/2,screenH/2,screenW/2,screenH/2},
				{0,screenH/2,screenW/2,screenH/2},
				{0,0,screenW/2,screenH/2},
				{screenW/2,0,screenW/2,screenH/2}}
_wDDT_poseN = 1

_winDebugDrawMode = 3

function _winDubugDrawModeSet()
	if _winDebugDrawMode == 1 then
		_winDebugDrawMemr = true
		_winDebugDraw = true
		_winDebugDrawGraf = true
	elseif _winDebugDrawMode == 2 then
		_winDebugDrawGraf = false
	elseif _winDebugDrawMode == 3 then
		_winDebugDraw = false
	elseif _winDebugDrawMode == 4 then
		_winDebugDraw = true
		_winDebugDrawMemr = false
		_winDebugDrawGraf = true
	end
end
setTimer(function() _winDubugDrawModeSet() end,50,1)
function _DoWinDubugDraw()
	outputDebugString("-----------------------------")
	outputDebugString("WinDebug Enabled:")
	outputDebugString("   nums [4-8]  - move")
	outputDebugString("   num_3 - reset pos")
	outputDebugString("    lalt+8  - debug info mode")
	outputDebugString("    lalt+9  - fullscreen mode")
	outputDebugString("    lalt+0  - windowPosition")
	outputDebugString("----------------------------->>")



	_winDebugDrawRT = dxCreateRenderTarget(screenW*_wDDT_w,screenH*_wDDT_h)
	_winDebugMemoryRT = dxCreateRenderTarget(300,101,false)
	_winDebugDraw = true

	bindKey("9","down",function()
		if getKeyState("lalt") then
			_winDebugDrawFullScreen = not _winDebugDrawFullScreen
		end
	end)
	bindKey("8","down",function()
		if getKeyState("lalt") then	
			_winDebugDrawMode = _winDebugDrawMode + 1
			if _winDebugDrawMode > 4 then _winDebugDrawMode = 1 end
			_winDubugDrawModeSet() 
		end
	end)
	bindKey("0","down",function()
		if getKeyState("lalt") then	
			_wDDT_poseN = _wDDT_poseN + 1
			if _wDDT_poseN > #_wDDT_poses then _wDDT_poseN = 1 end
		end
	end)

end

function _WinDebElm(Elm,level,lenghter)
	if not level then level = 0 end
	if not lenghter then lenghter = 0 end


	local elmw = 150
	local elmh = 40
	local elmx = 100 + 170*lenghter - _winDebugDrawX
	local elmy = 200 + 70*level - _winDebugDrawY

	if Elm.type == "cTIV" then
		dxDrawRectangle(elmx+5,elmy+5,elmw-10,elmh-10,tocolor(35,105,155,255))
		dxDrawLine(elmx,elmy,elmx + elmw,elmy,tocolor(100,100,100,255),1.2)
		dxDrawLine(elmx+ elmw,elmy,elmx + elmw,elmy + elmh,tocolor(100,100,100,255),1.2)
		dxDrawLine(elmx + elmw,elmy + elmh,elmx,elmy + elmh,tocolor(100,100,100,255),1.2)
		dxDrawLine(elmx,elmy + elmh,elmx,elmy,tocolor(100,100,100,255),1.2)
	elseif Elm.type == "scrollTIV" then
		dxDrawRectangle(elmx-5,elmy+3,elmw+10,elmh-6,tocolor(125,75,160,150))
	else
		dxDrawRectangle(elmx,elmy,elmw,elmh,tocolor(110,110,110,255))
	end
	dxDrawText(Elm.name,elmx,elmy,elmx + elmw,elmy + elmh,tocolor(255,255,255,255),1,1,"default","center","center",false,true)

	if Elm == CElm then
		dxDrawRectangle(elmx + elmw-4,elmy,8,elmh)
	end


	local lenght = lenghter
	local myLenght = 0
	for k,v in pairs(Elm.elements) do
		local ex = elmx + elmw/2

		dxDrawLine(ex,elmy + elmh + 4,ex,elmy + elmh + 15,tocolor(255,255,255,255),2*_winDebugDrawZoom)
		dxDrawLine(ex,elmy + elmh + 15,ex + (elmw+20)*(lenght-lenghter),elmy + elmh + 15,tocolor(255,255,255,255),2*_winDebugDrawZoom)
		dxDrawLine(ex + (elmw+20)*(lenght-lenghter),elmy + elmh + 15,ex + (elmw+20)*(lenght-lenghter),elmy + elmh + 30-4,tocolor(255,255,255,255),2*_winDebugDrawZoom)

		local def = _WinDebElm(v,level + 1,lenght)
		lenght = lenght + def
		myLenght = myLenght + def
	end

	if lenght == 0 then lenght = 1 end
	if myLenght == 0 then myLenght = 1 end

	return myLenght
end
_winDebugDrawX = 0
_winDebugDrawY = 0
_winDebugDrawZoom = 1
_winDebugDrawMoveSpeed = 4

addEventHandler("onClientRender",root,function()
	if not _winDebugDraw then return end
	--
	local _winDebugDrawMoveKey = false

	if getKeyState("num_6") then
		_winDebugDrawX = _winDebugDrawX + _winDebugDrawMoveSpeed
		_winDebugDrawMoveKey = true
	elseif getKeyState("num_4") then
		_winDebugDrawX = _winDebugDrawX - _winDebugDrawMoveSpeed
		_winDebugDrawMoveKey = true
	end
	if getKeyState("num_8") then
		_winDebugDrawY = _winDebugDrawY - _winDebugDrawMoveSpeed
		_winDebugDrawMoveKey = true
	elseif getKeyState("num_5") then
		_winDebugDrawY = _winDebugDrawY + _winDebugDrawMoveSpeed
		_winDebugDrawMoveKey = true
	end

	local a = false
	local b = false
	if _winDebugDrawX < 0 then _winDebugDrawX = 0 ; a = true end
	if _winDebugDrawY < 0 then _winDebugDrawY = 0 ; b = true end
	if a and b then _winDebugDrawMoveKey = false end

	if _winDebugDrawMoveKey then
		_winDebugDrawMoveSpeed = _winDebugDrawMoveSpeed + 0.6
	else
		_winDebugDrawMoveSpeed = 3
	end
	if _winDebugDrawMoveSpeed > 60 then _winDebugDrawMoveSpeed = 60 end

	if getKeyState("num_9") then
		_winDebugDrawZoom = _winDebugDrawZoom + 0.014
	elseif getKeyState("num_7") then
		_winDebugDrawZoom = _winDebugDrawZoom - 0.014
	end

	if _winDebugDrawZoom > _wDDT_z then _winDebugDrawZoom = _wDDT_z end
	if _winDebugDrawZoom < 0.3 then _winDebugDrawZoom = 0.3 end

	if getKeyState("num_3") then 
		_winDebugDrawX = 0
		_winDebugDrawY = 0
	end




	dxSetRenderTarget(_winDebugDrawRT,true)
	
	dxDrawRectangle(0,0,screenW*_wDDT_w,screenH*_wDDT_h,tocolor(25,45,35,25))
	dxDrawLine(0,0,screenW*_wDDT_w,0,nil,7.4)
	dxDrawLine(0,0,0,screenH*_wDDT_h,nil,7.4)
	dxDrawLine(screenW*_wDDT_w,0,screenW*_wDDT_w,screenH*_wDDT_h,nil,7.4)
	dxDrawLine(0,screenH*_wDDT_h,screenW*_wDDT_w,screenH*_wDDT_h,nil,7.4)

	_WinDebElm(GElements,0)



	dxSetRenderTarget(_winDebugMemoryRT,true)

	dxDrawRectangle(0,0,270,100,tocolor(25,45,35,25))
	dxDrawLine(0,0,screenW,0,nil,1)
	dxDrawLine(screenW,0,screenW,100,nil,1)
	dxDrawLine(0,0,0,100,nil,1)
	dxDrawLine(0,100,screenW,100,nil,1)


	local dxMemoryStatus = dxGetStatus()
	dxDrawText("Free Mmry:   "..dxMemoryStatus.VideoMemoryFreeForMTA,35 - 24,5,nil,nil,nil,1.8,1.6)
	dxDrawText("[RTs] -   "..dxMemoryStatus.VideoMemoryUsedByRenderTargets,35 - 24,40,nil,nil,nil,1.8,1.6)
	dxDrawText("[Tex] -   "..dxMemoryStatus.VideoMemoryUsedByTextures,35 - 24,65,nil,nil,nil,1.8,1.6)

	dxSetRenderTarget()

	if _winDebugDrawFullScreen then
		if _winDebugDrawGraf then dxDrawImageSection(1,1,screenW-2,screenH-2,0,0,screenW*_winDebugDrawZoom,screenH*_winDebugDrawZoom,_winDebugDrawRT,0,0,0,tocolor(255,255,255,200),true) end
		
		if not _winDebugDrawMemr then return end
		dxDrawImage(screenW-214,0,300,100,_winDebugMemoryRT,0,0,0,tocolor(255,255,255,200),true)
	else
		if _winDebugDrawGraf then dxDrawImageSection(_wDDT_poses[_wDDT_poseN][1],_wDDT_poses[_wDDT_poseN][2],_wDDT_poses[_wDDT_poseN][3],_wDDT_poses[_wDDT_poseN][4],0,0,screenW*_winDebugDrawZoom,screenH*_winDebugDrawZoom,_winDebugDrawRT,0,0,0,tocolor(255,255,255,225),true) end
		
		if not _winDebugDrawMemr then return end
		dxDrawImage(screenW-106,screenH/2,300/2,100/2,_winDebugMemoryRT,0,0,0,tocolor(255,255,255,200),true)
	end
end)


---                       ------------------------------------------------------------------------------------------------------------
end
return Draws