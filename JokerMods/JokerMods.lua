SMODS.Atlas {
    key = "JokerMods",
    path = "JokerMods.png",
    px = 71,
    py = 95
}


SMODS.Joker {
    key = 'mult-fest',
    loc_txt = {
        name = 'Mult Fest',
        text = {
            "+100 Mult when used",
            "{C:mult}+#1# {} Mult",
            "{C:inactive}Out of luck, eh?"
        }
    },
    config = { extra = { mult = 100, odds = 20 }},
    rarity = 3,
    atlas = 'JokerMods',
    pos = { x = 2, y = 1 },
    cost = 10,
    eternal_compat = false, -- Gros Michel is incompatible with the eternal sticker
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end

        -- Checks to see if it's end of round, and if context.game_over is false.
        -- Also, not context.repetition ensures it doesn't get called during repetitions.
        if context.end_of_round and not context.repetition and context.game_over == false and not context.blueprint then
            -- Another pseudorandom thing, randomly generates a decimal between 0 and 1, so effectively a random percentage.
            if pseudorandom('mult-fest') < G.GAME.probabilities.normal / card.ability.extra.odds then
                -- This part plays the animation.
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                    end
                }))
                return {
                    mult_mod = card.ability.extra.mult * 100,
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult * 100 } }
                }
            else
                return {
                    mult_mod = 0,
                    message = localize { type = 'variable', key = 'no_mult', vars = {} }
                }
            end
        end
    end
}

----------------------------------------------
------------MOD CODE END----------------------
