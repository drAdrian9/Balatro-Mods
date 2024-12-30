--- STEAMODDED HEADER
--- MOD_NAME: IncreaseCardinHandCapacity
--- MOD_ID: IncreaseCardinHandCapacity
--- MOD_AUTHOR: drAdrian9
--- MOD_DESCRIPTION: Increase Card in Hand Capacity

----------------------------------------------
------------MOD CODE -------------------------
function get_starting_params()
	newTable = originalFuncRef()
	newTable.hand_size = 1
	return newTable
end
----------------------------------------------
------------MOD CODE END----------------------