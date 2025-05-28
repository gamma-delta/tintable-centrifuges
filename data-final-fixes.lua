-- Give any modded recipes that didn't assign a color the original green back

local centrifuge_cats_tbl = data.raw["assembling-machine"]["centrifuge"].crafting_categories
local centrifuge_cats = {}
for _,cat in ipairs(centrifuge_cats_tbl) do
  centrifuge_cats[cat] = true
end

-- TODO this is O(mn) over every recipe and its categories
local function can_centrifuge_craft(recipe)
  local ok_cats = table.deepcopy(recipe.additional_categories or {})
  table.insert(ok_cats, recipe.category)

  for _,ok_cat in ipairs(ok_cats) do
    if centrifuge_cats[ok_cat] == true then
      return true
    end
  end

  return false
end

for _,recipe in pairs(data.raw["recipe"]) do
  if not recipe.crafting_machine_tint and can_centrifuge_craft(recipe) then
    log("adding default tints to " .. recipe.name)
    recipe.crafting_machine_tint = {
      primary = {0, 1, 0},
      secondary = {0, 1, 0},
      tertiary = {0, 1, 0},
      quaternary = {0, 1, 0},
    }
  end
end
