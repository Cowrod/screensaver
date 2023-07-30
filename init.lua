local display_settings = require'json'.decode(require'fs'.readFileSync"config.json")
display_settings=display_settings and display_settings.blocks and #display_settings.blocks>0 and display_settings.size and display_settings.X and display_settings.Y and display_settings.renew and display_settings.horizantalChance and type(display_settings.useCLS)=="boolean" and display_settings or{
	-- EXAMPLE SPACE THEME AS DEFULT IF NO/UNVALID CONFIG
	blocks = { [750] = " ", [20] = "*", [2]="o", [1] = "O" },
	size = { X = 91, Y = 31 },
	renew = 50,
	horizantalChance = 100,
	useCLS = false
}

-------------- MAIN SCRIPT:
function addToTable(table, object)
	table[#table+1]=object
	return table
end
local display_objects = { };
local display = { };

--[[(TASK 1/5) create block order]]
for i, v in pairs(display_settings.blocks)do
	for c = 1, i do
		display_objects = addToTable(display_objects, v)
	end
end
--[[(TASK 2/5) create screen order]]
for y = 1,display_settings.size.Y do
	display[y] = (" "):rep(display_settings.size.X)
end
--[[(TASK 3/5) set main functions]]
function empty()end
function getRandomBlock()
	return display_objects[math.random(#display_objects)]
end
function getEntireRandomLine()
	local z = ""
	for i=1, display_settings.size.X do
		z=z..getRandomBlock()
	end
	return z
end
function horizontalUpdate()
	local upOrDown = math.random(2)
	local randomLine = getEntireRandomLine()
	if upOrDown == 1 then
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
	end
	upOrDown, randomLine = nil, nil
end

function updateView()
	for i, v in pairs(display)do
		display[i] = v:sub(2)..getRandomBlock()
	end
end
function getView()
	local z = ""
	for i, v in pairs(display)do
		if #display==i then
			z = z..v
		else
			z = z..v.."\n"
		end
	end
	return z
end
--[[(TASK 4/5) get better view]]
math.randomseed(os.time())coroutine.wrap(function()while true do require'timer'.sleep(27)for i=1,math.random(1e5)do math.random()end end end)()
for i=1, display_settings.size.X do
	updateView()
end
--[[(TASK 5/5) start the loop]]
while true do
	empty(math.random(display_settings.horizantalChance)==1 and horizontalUpdate())
	empty(display_settings.useCLS and os.execute'cls')
	updateView()
	io.write("\n"..getView())
	require'timer'.sleep(display_settings.renew)
end
