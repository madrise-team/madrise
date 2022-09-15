import('avtos/avtos_chips.lua')()

----------- Cars Handling ---------------------------------
automobiles_S = automobiles
----------------------------------------------------------------------------------------------------

function setHandl_S(avto)
-----------------------------------------------------------------------------
			setModelHandling(avto[2],"mass", avto[3])							        -- масса
			setModelHandling(avto[2],"turnMass", avto[4])						        -- масса толчка
			setModelHandling(avto[2],"dragCoeff", avto[5])						        -- сила рывка
			setModelHandling(avto[2],"centerOfMass", {avto[6], avto[7], avto[8]})	    -- центр масс
			setModelHandling(avto[2],"percentSubmerged", avto[9])				        -- % погружения в воду
			setModelHandling(avto[2],"tractionMultiplier", avto[10])				    -- сцепление с дорогой
			setModelHandling(avto[2],"tractionLoss", avto[11])					        -- потеря сцепления
			setModelHandling(avto[2],"tractionBias", avto[12])					        -- смещение сцепления
			setModelHandling(avto[2],"numberOfGears", avto[13])					        -- количество передач
			setModelHandling(avto[2],"maxVelocity", avto[14])					        -- максимальная скорость
			setModelHandling(avto[2],"engineAcceleration", avto[15])				    -- ускорение
			setModelHandling(avto[2],"engineInertia", avto[16])					        -- инерция
			setModelHandling(avto[2],"driveType", avto[17])					            -- привод ('rwd' - задний; 'fwd' - передний; 'awd' - полный)
			setModelHandling(avto[2],"engineType", avto[18])				            -- 'petrol', 'diesel' or 'electric'
			setModelHandling(avto[2],"brakeDeceleration", avto[19])				        -- замедление торможением
			setModelHandling(avto[2],"brakeBias", avto[20])						        -- смещение тормоза
			setModelHandling(avto[2],"ABS", avto[21])                                   -- ABS (не работает, выставлять false)
			setModelHandling(avto[2],"steeringLock", avto[22])				        	-- угол поворота руля
			setModelHandling(avto[2],"suspensionForceLevel", avto[23])		            -- сила подвески
			setModelHandling(avto[2],"suspensionDamping", avto[24])                     -- даже "цербер" без понятия
			setModelHandling(avto[2],"suspensionHighSpeedDamping", avto[25])            -- демпфирование подвески
			setModelHandling(avto[2],"suspensionUpperLimit", avto[26])                  -- макс. изменение подвески
			setModelHandling(avto[2],"suspensionLowerLimit", avto[27])			        -- высота подвески (в статике)
			setModelHandling(avto[2],"suspensionFrontRearBias", avto[28])		        -- подвеска спереди/сзади
			setModelHandling(avto[2],"suspensionAntiDiveMultiplier", avto[29])          -- крен кузова при разгоне/торможении
			setModelHandling(avto[2],"seatOffsetDistance", avto[30])                    -- хуета (не трогать)
			setModelHandling(avto[2],"collisionDamageMultiplier", 0.3)		            -- урон
			setModelHandling(avto[2],"monetary", avto[32])                              -- типа цена в гта (хуя се)
			setModelHandling(avto[2],"modelFlags", avto[33])
			setModelHandling(avto[2],"handlingFlags", avto[34])
-----------------------------------------------------------------------------
end

for marka, auto in pairs(automobiles_S) do
	setHandl_S(auto)
end
