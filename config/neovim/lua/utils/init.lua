-- Color functions from https://github.com/craftzdog/dotfiles-public/blob/master/.config/nvim/lua/craftzdog/utils.lua

local M = {}

local hex_chars = "0123456789abcdef"

-- Converts a RGB color value to HSL.
-- Assumes r, g, and b are contained in the set [0, 255] and
-- returns h, s, and l in the set [0, 1].
function M.hex_to_rgb(hex)
  hex = string.lower(hex)
  local ret = {}

  for i = 0, 2 do
    local char1 = string.sub(hex, i * 2 + 2, i * 2 + 2)
    local char2 = string.sub(hex, i * 2 + 3, i * 2 + 3)
    local digit1 = string.find(hex_chars, char1) - 1
    local digit2 = string.find(hex_chars, char2) - 1
    ret[i + 1] = (digit1 * 16 + digit2) / 255.0
  end

  return ret
end

-- Converts a RGB color value to HSL.
-- Assumes r, g, and b are contained in the set [0, 255] and
-- returns h, s, and l in the set [0, 1].
function M.rgb_to_hsl(r, g, b)
  local max, min = math.max(r, g, b), math.min(r, g, b)
  local h = 0
  local s = 0
  local l = (max + min) / 2

  if max == min then
    h, s = 0, 0 -- achromatic
  else
    local d = max - min
    if l > 0.5 then
      s = d / (2 - max - min)
    else
      s = d / (max + min)
    end
    if max == r then
      h = (g - b) / d
      if g < b then
        h = h + 6
      end
    elseif max == g then
      h = (b - r) / d + 2
    elseif max == b then
      h = (r - g) / d + 4
    end
    h = h / 6
  end

  return h * 360, s * 100, l * 100
end

-- Converts a HSL color value to RGB.
-- Assumes h, s, and l are contained in the set [0, 1] and
-- returns r, g, and b in the set [0, 255].
function M.hsl_to_rgb(h, s, l)
  local r, g, b

  if s == 0 then
    r, g, b = l, l, l -- achromatic
  else
    local function hue_to_rgb(p, q, t)
      if t < 0 then
        t = t + 1
      end
      if t > 1 then
        t = t - 1
      end
      if t < 1 / 6 then
        return p + (q - p) * 6 * t
      end
      if t < 1 / 2 then
        return q
      end
      if t < 2 / 3 then
        return p + (q - p) * (2 / 3 - t) * 6
      end
      return p
    end

    local q
    if l < 0.5 then
      q = l * (1 + s)
    else
      q = l + s - l * s
    end
    local p = 2 * l - q

    r = hue_to_rgb(p, q, h + 1 / 3)
    g = hue_to_rgb(p, q, h)
    b = hue_to_rgb(p, q, h - 1 / 3)
  end

  return r * 255, g * 255, b * 255
end

function M.hex_to_hsl(hex)
  local rgb = M.hex_to_rgb(hex)
  local h, s, l = M.rgb_to_hsl(rgb[1], rgb[2], rgb[3])

  return string.format("hsl(%d, %d, %d)", math.floor(h + 0.5), math.floor(s + 0.5), math.floor(l + 0.5))
end

-- Converts a HSL color value to RGB in Hex representation.
function M.hsl_to_hex(h, s, l)
  local r, g, b = M.hsl_to_rgb(h / 360, s / 100, l / 100)

  return string.format("#%02x%02x%02x", r, g, b)
end

-- Converts RGB color value in Hex representation to HSL on the current line.
function M.replace_hex_with_hsl()
  -- Get the current line number
  local line_number = vim.api.nvim_win_get_cursor(0)[1]

  -- Get the line content
  local line_content = vim.api.nvim_buf_get_lines(0, line_number - 1, line_number, false)[1]

  -- Find hex code patterns and replace them
  for hex in line_content:gmatch("#[0-9a-fA-F]+") do
    local hsl = M.hex_to_hsl(hex)
    line_content = line_content:gsub(hex, hsl)
  end

  -- Set the line content back
  vim.api.nvim_buf_set_lines(0, line_number - 1, line_number, false, { line_content })
end

return M
