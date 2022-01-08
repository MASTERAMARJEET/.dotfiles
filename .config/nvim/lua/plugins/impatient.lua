local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
  return
end

impatient.enable_profile()

local p_compiled_status_ok, _ = pcall(require, "packer_compiled")
if not p_compiled_status_ok then
  return
end
