-- tool_info/init.lua

local wield = {}

hudlib.register("tool_info", {
  show_on = "join",
  type = "text",
  pos = {x=0, y=1},
  offset = {x=70, y=-50},
  direction = 0,
  colour = 0xFFFFFF ,
  text = "",

  on_step = function(self, pname, dtime)
    local player = minetest.get_player_by_name(pname)
    local wstack = player:get_wielded_item()
    local windex = player:get_wield_index()

    if minetest.registered_tools[wstack:get_name()] then
      local def = minetest.registered_tools[wstack:get_name()]

      if not def.tool_capabilities then return end

      local meta = wstack:get_meta()
      local desc = def.description
      if meta:get_string("description") ~= "" then
        desc = meta:get_string("description")
      end

      local damage = def.tool_capabilities.damage_groups.fleshy or 0
      local wear   = math.floor(wstack:get_wear() / 65535 * 100)
      local speed  = def.tool_capabilities.full_punch_interval or 1
      local drop   = def.tool_capabilities.max_drop_level or 0

      self:set_text(desc.."\nWear: "..wear.."/100\nDamage: "..damage
        .."\nSpeed: "..speed.."\nMax Drop Level: "..drop)

      if wield[pname] ~= windex then
      	local show = hudlib.get(player, "tool_info", "show")
        if show == false then
          self:show()
        end
      end
    else
      self:hide()
    end

    wield[pname] = windex
  end,
})
