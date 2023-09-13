-- Initialize the Wired modem on the master computer
rednet.open("back") -- Change the side as needed

-- Define the IDs of the 293 remote computers
local computerIDs = {}
for i = 1, 293 do
  table.insert(computerIDs, i)
end

-- Define a function to send a command to multiple remote computers
local function sendCommandToAll(command)
  for _, computerID in ipairs(computerIDs) do
    rednet.send(computerID, command)
  end
end

-- Main loop for command input
while true do
  term.clear()
  term.setCursorPos(1, 1)
  print("Central Server - Master Computer")
  print("1. Send command to all computers")
  print("Q. Quit")
  io.write("Enter your choice: ")
  
  local choice = io.read()
  if choice == "1" then
    io.write("Enter command to send to all computers: ")
    local command = io.read()
    sendCommandToAll(command)
    print("Command sent to all computers.")
    sleep(2)
  elseif choice == "Q" or choice == "q" then
    break
  end
end

-- Close the Wired modem when done
rednet.close("back")
