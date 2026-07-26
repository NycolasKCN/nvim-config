---@brief Utilitários
local M = {}

---@brief Carrega todos os arquivos .lua de um módulo (exceto init.lua)
---
--- Varre o diretório correspondente ao módulo informado (dentro de
--- `stdpath("config")/lua/`) e executa `require` em cada arquivo .lua
--- encontrado, ignorando o próprio `init.lua`.
---
---@param lua_module string Caminho do módulo no formato Lua, ex: "nycolaskcn.plugins"
---@return nil
function M.requireall(lua_module)
  local module_path = lua_module:gsub("%.", "/")
  local current_dir = vim.fn.stdpath("config") .. "/lua/" .. module_path

  if vim.fn.isdirectory(current_dir) == 0 then
    vim.notify(
      "[requireall] Directory not found: " .. current_dir,
      vim.log.levels.WARN
    )
    return
  end

  for name, type in vim.fs.dir(current_dir) do
    if type == "file" and name:match("%.lua$") and name ~= "init.lua" then
      local module_name = name:gsub("%.lua$", "")
      local full_module = lua_module .. "." .. module_name

      local ok, err = pcall(require, full_module)
      if not ok then
        vim.notify(
          "[requireall] Error on load '" .. full_module .. "': " .. err,
          vim.log.levels.ERROR
        )
      end
    end
  end
end

return M
