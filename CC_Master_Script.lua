-- Initialize the Wired modem on the master computer
rednet.open("back") -- Change the side as needed

-- Discover and list all available computer IDs on the network
local function discoverComputerIDs()
  local computerIDs = {}
  local ownID = os.getComputerID()
  
  for i = 1, 32767 do -- Check IDs up to 32767
    if i ~= ownID then
      local success, _ = rednet.open("back") -- Open the modem on the back side
      if success then
        rednet.send(i, "PING", "ping") -- Send a ping to check if the computer is available
        local senderID, _, _ = rednet.receive(1) -- Wait for a response for 1 second
        rednet.close("back") -- Close the modem
        if senderID == i then
          table.insert(computerIDs, i)
        end
      end
    end
  end
  return computerIDs
end

local computerIDs = discoverComputerIDs()
print("Available Computer IDs on the network:")
for _, id in ipairs(computerIDs) do
  print(id)
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
    for _, id in ipairs(computerIDs) do
      rednet.send(id, command)
    end
    print("Command sent to all computers.")
    sleep(2)
  elseif choice == "Q" or choice == "q" then
    break
  end
end

-- Close the Wired modem when done
rednet.close("back")
