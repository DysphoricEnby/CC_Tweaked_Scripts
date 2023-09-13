-- List of files to copy to the root directory
local filesToCopy = {
  { source = "disk/startup.file", destination = "startup" },
  { source = "disk/ChatSpam.lua", destination = "ChatSpam.lua" }, -- Add any other files you want to copy here
}

-- Function to copy a file
local function copyFile(source, destination)
  if fs.exists(source) then
    fs.copy(source, destination)
    print("Copied '" .. source .. "' to '" .. destination .. "'")
  else
    print("File '" .. source .. "' does not exist.")
  end
end

-- Delete the existing "startup" file if it exists
if fs.exists("startup") then
  fs.delete("startup")
  print("Deleted existing 'startup' file")
end

-- Copy the specified files to the root directory
for _, file in ipairs(filesToCopy) do
  copyFile(file.source, file.destination)
end

-- Run the new "startup" file
shell.run("startup")
