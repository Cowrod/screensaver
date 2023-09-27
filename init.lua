local err, display_settings = pcall(require'json'.decode,require'fs'.readFileSync"config.json")
display_settings=display_settings and display_settings.blocks and #display_settings.blocks>0 and display_settings.size and display_settings.X and display_settings.Y and display_settings.renew and display_settings.horizantalChance and type(display_settings.useClear)=="boolean" and display_settings or{
	-- EXAMPLE SPACE THEME AS DEFULT IF NO/UNVALID CONFIG
	blocks = { [750] = " ", [20] = "*", [2]="o", [1] = "O" },
	size = { X = 91, Y = 31 },
	renew = 50,
	horizantalChance = 100,
	useClear = false
}

-------------- MAIN SCRIPT:
local display_objects = { };
local display = { };

--[[(TASK 1/5) create block order]]
for i, v in pairs(display_settings.blocks)do for c=1,i do table.insert(display_objects,v)end end
--[[(TASK 2/5) create screen order]]
for y = 1,display_settings.size.Y do display[y]={}for x=1,display_settings.size.X do table.insert(display[y]," ")end end
--[[(TASK 3/5) set main functions]]
function empty()end
function getRandomBlock()return display_objects[math.random(#display_objects)]end
function preTable(tbl,value)local temp={value}for i,v in pairs(tbl)do table.insert(temp,v)end table.remove(temp,#temp)return temp end
function getEntireRandomLine()local z={}for i=1, display_settings.size.X do table.insert(z,getRandomBlock())end return z end
function horizontalUpdate()
	local randomLine = getEntireRandomLine()
	if math.random(2) == 1 then
		-- move lines up
		for i = #display, 2, -1 do
			display[i] = display[i - 1]
		end
		display[1] = randomLine
	else
		-- move lines down
		for i = 1, #display - 1 do
			display[i] = display[i + 1]
		end
		display[#display] = randomLine
	end randomLine=nil
end

function updateView()for i,v in pairs(display)do display[i]=preTable(display[i],getRandomBlock())end end
--[[(TASK 4/5) get better view]]
math.randomseed(os.time()..(os.clock()*1e3))coroutine.wrap(function()while true do require'timer'.sleep(27)for i=1,math.random(1e5)do math.random()end end end)()
for i=1, display_settings.size.X do updateView()end
function getView()local m={}for i,v in pairs(display)do table.insert(m,table.concat(v))end return table.concat(m,"\n")end
--[[(TASK 5/5) start the loop]]
while true do
	empty(math.random(display_settings.horizantalChance)==1 and horizontalUpdate())
	updateView()
	io.write((display_settings.useClear and"\27\99"or"\n")..getView())
	require'timer'.sleep(display_settings.renew)
end
