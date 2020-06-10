local PREFIX = 'Perfectly-Valid-Prototypes-'

local icons = {
  {
    icon = "__core__/graphics/empty.png",
    icon_size = 1
  }
}

local unit = {
  count = 1,
  ingredients = {
    {"automation-science-pack", 1},
  },
  time = 1
}

local localised_name = {
  ""
}

local name_counter = {}

local function make_name(type)
  local count = name_counter[type]
  if not count then
    count = 1
  else
    count = count + 1
  end
  name_counter[type] = count
  -- don't end with a number so that we don't look like infinite technology?
  return 'OR-Nodes-test-' .. type .. '-' .. count .. '-'
end

local function pad_name(name, target_length)
  if not target_length then target_length = 100 end
  local length = name:len()
  local padding = math.ceil((target_length - length)/10)
  name = name .. ('0123456789'):rep(padding)
  name = name:sub(1,target_length)
  if name:len() ~= target_length then error("?!") end
  return name
end

local funny_name_1 = PREFIX
local funny_name_2 = PREFIX
do
  local period = ("."):byte(1)
  for i = 0, 128, 1 do
    if i ~= period then
      funny_name_1 = funny_name_1 .. string.char(i)
    end
  end
  for i = 129, 255, 1 do
    funny_name_2 = funny_name_2 .. string.char(i)
  end
end

local function new_item(name, item_data)
  if not item_data then item_data = {} end
  if not item_data.stack_size then item_data.stack_size = 50 end
  item_data.type = "item"
  item_data.name = name
  item_data.icons = icons
  item_data.localised_name = localised_name
  item_data.localised_description = localised_name
  data:extend{ item_data }
end

local function new_recipe(name, is_enabled, recipe_data)
  if not recipe_data then recipe_data = {} end
  if not recipe_data.ingredients then recipe_data.ingredients = {} end
  if not recipe_data.result or recipe_data.results then
    recipe_data.results = {}
    -- other is the default subgroup of an item
    recipe_data.subgroup = "other"
  end
  if not is_enabled then
    recipe_data.enabled = false
  end
  recipe_data.type = "recipe"
  recipe_data.name = name
  recipe_data.icons = icons
  recipe_data.localised_name = localised_name
  recipe_data.localised_description = localised_name
  data:extend{ recipe_data }
end

local function new_technology(name, technology_data)
  if not technology_data  then technology_data = {} end
  technology_data.type = "technology"
  technology_data.name = name
  technology_data.icons = icons
  if not technology_data.normal and not technology_data.expensive then
    technology_data.unit = unit
  end
  technology_data.localised_name = localised_name
  technology_data.localised_description = localised_name
  data:extend{ technology_data }
end

new_item(funny_name_1)
new_recipe(funny_name_1, nil, {
  result = funny_name_1
})
new_technology(funny_name_1, {
  effects = {
    {
      type = "unlock-recipe",
      recipe = funny_name_1
    }
  }
})

new_item(funny_name_2)
new_recipe(funny_name_2, nil, {
  result = funny_name_2
})
new_technology(funny_name_2, {
  effects = {
    {
      type = "unlock-recipe",
      recipe = funny_name_2
    }
  }
})

local item_1 = pad_name(make_name('item'),200)
new_item(item_1)
new_recipe(item_1, nil, {
  results = { item_1 }
})

local item_2 = make_name('item')
new_item(item_2)
new_recipe(item_2, nil, {
  results = { name = item_2 }
})

local item_3 = make_name('item')
new_item(item_3)
new_recipe(item_3, nil, {
  results = { name = item_3 }
})

local item_4 = make_name('item')
new_item(item_4)
new_recipe(item_4, nil, {
  results = { name = item_4 }
})

local item_5 = make_name('item')
new_item(item_5)
new_recipe(item_5, nil, {
  results = { name = item_5 }
})

new_technology("a technology with normal but no expensive", {
  normal = {
    unit = {
      count = 1,
      ingredients = {
        {"automation-science-pack", 1}
      },
      time = 1
    },
    effects = {
      {
        type="unlock-recipe",
        recipe=item_1
      }
    }
  }
})

new_technology("a technology with expensive but no normal", {
  expensive = {
    unit = {
      count = 1,
      ingredients = {
        {"automation-science-pack", 1}
      },
      time = 1
    },
    effects = {
      {
        type="unlock-recipe",
        recipe=item_2
      }
    }
  }
})

new_technology("a technology with only normal", {
  normal = {
    unit = {
      count = 1,
      ingredients = {
        {"automation-science-pack", 1}
      },
      time = 1
    },
    effects = {
      {
        type="unlock-recipe",
        recipe=item_3
      },
      {
        type="unlock-recipe",
        recipe=item_4
      }
    }
  },
  expensive = false
})

new_technology("a technology with only expensive", {
  expensive = {
    unit = {
      count = 1,
      ingredients = {
        {"automation-science-pack", 1}
      },
      time = 1
    },
    effects = {
      {
        type="unlock-recipe",
        recipe=item_3
      },
      {
        type="unlock-recipe",
        recipe=item_5
      }
    }
  },
  normal = false
})
