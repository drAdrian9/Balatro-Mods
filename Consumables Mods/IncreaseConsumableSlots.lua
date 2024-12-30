--- STEAMODDED HEADER
--- MOD_NAME: IncreaseConsumables
--- MOD_ID: IncreaseConsumables
--- MOD_AUTHOR: drAdrian9
--- MOD_DESCRIPTION: Increase Consumables to 5

----------------------------------------------
------------MOD CODE -------------------------

local base_consumables = 5

local originalFuncRef = get_starting_params
function get_starting_params()
	newTable = originalFuncRef()
	newTable.consumable_slots = base_consumables
	return newTable
end

----------------------------------------------
------------MOD CODE END----------------------