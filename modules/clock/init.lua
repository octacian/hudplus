-- clock/init.lua

local function floormod(x, y)
	return math.floor(x) % y
end

local function get_time( )
  local mtime = minetest.get_timeofday()
  if not mtime then return end

	local secs = 60 * 60 * 24 * minetest.get_timeofday()
	local s = floormod(secs, 60)
	local m = floormod(secs / 60, 60)
	local h = floormod(secs / 3600, 60)
	return ("%02d:%02d"):format(h, m)
end

hudlib.register("clock", {
  show_on = "join",
  type = "text",
  pos = {x=0.5, y=0},
  offset = {x=0, y=10},
  colour = 0xFFFFFF ,
  text = get_time(),

  do_every = { time = 1, func = function(self, name)
    self:set_text(get_time())
  end, }
})
