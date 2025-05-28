local centri = data.raw["assembling-machine"]["centrifuge"]
-- Centrifuge lights
-- primary, secondary, tertiary: thumper color left right center
-- quaternary: light color
local centri_wvs = centri.graphics_set.working_visualisations
local centri_wv_light = centri_wvs[1]
centri_wv_light.apply_recipe_tint = "quaternary"
centri_wv_light.light.color = {1,1,1}

local new_centri_wvs = {
  centri_wv_light,
}

for i,ani_layer in ipairs(centri_wvs[2].animation.layers) do
  local _, _, letter = ani_layer.filename:find("centrifuge%-(%a)%-light%.png")
  letter = letter:lower()
  ani_layer.filename = 
    "__tintable-centrifuges__/graphics/centrifuge-" .. letter .. "-light.png"

  local cardinals = {"primary", "secondary", "tertiary"}

  local new_wv = {
    effect = "uranium-glow",
    fadeout = true,
    apply_recipe_tint = cardinals[i],
    animation = ani_layer,
  }
  table.insert(new_centri_wvs, new_wv)
end
centri.graphics_set.working_visualisations = new_centri_wvs
centri.graphics_set.default_recipe_tint = {
  primary = {0, 1, 0},
  secondary = {0, 1, 0},
  tertiary = {0, 1, 0},
  quaternary = {0, 1, 0},
}

-- Add colors to vanilla recipes
local bright = {0, 1, 0}
local dim = {0.1, 0.3, 0}
data.raw["recipe"]["uranium-processing"].crafting_machine_tint = {
  primary = dim,
  secondary = dim,
  tertiary = bright,
  quaternary = bright,
}
data.raw["recipe"]["kovarex-enrichment-process"].crafting_machine_tint = {
  primary = bright,
  secondary = dim,
  tertiary = bright,
  quaternary = bright,
}
data.raw["recipe"]["nuclear-fuel-reprocessing"].crafting_machine_tint = {
  primary = dim,
  secondary = dim,
  tertiary = dim,
  quaternary = bright,
}
data.raw["recipe"]["nuclear-fuel"].crafting_machine_tint = {
  primary = bright,
  secondary = {0.7, 1.0, 0},
  tertiary = bright,
  quaternary = bright,
}

-- test
-- data:extend{
--   {
--     type = "recipe",
--     name = "dff-tint-fixup-checker",
--     icon = "__base__/graphics/icons/wood.png",
--     category = "centrifuging",
--     ingredients = {{type="item", name="wood", amount=1}},
--     results = {},
--   }
-- }
