-- Initialize the Wired modem on each remote computer
peripheral.find("modem").open(1) -- Change the side (1) as needed

-- Get the ID of the current computer
local ownID = os.getComputerID()

-- Main loop for receiving and executing commands
while true do
  local _, senderID, _, _, _, message = os.pullEvent("modem_message")
  if senderID and message and senderID ~= ownID then
    -- Execute standard ComputerCraft commands received from the central server
    shell.run(message)
  end
end
