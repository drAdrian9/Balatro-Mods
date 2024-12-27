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
        "+1000 Mult when used"
        "{C:mult}+#1# {} Mult"
      }
    },

    config = { extra = { mult = 1000}},
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.mult } }
    end,
    rarity = 1, --1 for testing purposes
    atlas = 'JokerMods',
    pos = { x = 0, y = 0 },
    cost = 1, --1 for testing purposes
    unlocked = true,
    discovered = true
    calculate = function(self, card, context)
      if context.joker_main then
        -- Tells the joker what to do. In this case, it pulls the value of mult from the config, and tells the joker to use that variable as the "mult_mod".
        return {
          mult_mod = card.ability.extra.mult,
          -- This is a localize function. Localize looks through the localization files, and translates it. It ensures your mod is able to be translated. I've left it out in most cases for clarity reasons, but this one is required, because it has a variable.
          -- This specifically looks in the localization table for the 'variable' category, specifically under 'v_dictionary' in 'localization/en-us.lua', and searches that table for 'a_mult', which is short for add mult.
          -- In the localization file, a_mult = "+#1#". Like with loc_vars, the vars in this message variable replace the #1#.
          message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
        }
      end
    end
  }
  
  ----------------------------------------------
  ------------MOD CODE END----------------------