local nomodoro = require("nomodoro")

local function check_nomodoro()
	if string.len(nomodoro.status()) == 0 then
		return false
	else
		return true
	end
end

check_nomodoro()
