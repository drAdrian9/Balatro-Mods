--- STEAMODDED HEADER
--- MOD_NAME: IncreaseCardinHandCapacity
--- MOD_ID: IncreaseCardinHandCapacity
--- MOD_AUTHOR: drAdrian9
--- MOD_DESCRIPTION: Increase Card in Hand Capacity

----------------------------------------------
------------MOD CODE -------------------------
local base_hand_size = 12

local originalFuncRef = get_starting_params
function get_starting_params()
    newTable = originalFuncRef()
    newTable.hand_size = base_hand_size
    return newTable
end
----------------------------------------------
------------MOD CODE END----------------------