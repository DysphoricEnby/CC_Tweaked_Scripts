-- Initialize the Wired modem on each remote computer
peripheral.find("modem").open(1) -- Change the side (1) as needed

-- Get the ID of the current computer
local ownID = os.getComputerID()

-- Main loop for receiving and executing commands
while true do
  local _, senderID, _, _, _, message = os.pullEvent("modem_message")
  if senderID and message and senderID ~= ownID then
    -- Execute standard ComputerCraft commands received from the central server
    local success, output = pcall(function()
      return shell.run(message)
    end)

    -- Display the output locally on the remote computer
    print("Output of Command:")
    print(output)

    -- Optionally, you can add a sleep time to introduce a delay before listening for the next command
    sleep(5) -- Adjust the delay time as needed
  end
end
