-- Initialize the Wired modem on each remote computer
rednet.open("back") -- Change the side as needed

-- Main loop for receiving and executing commands
while true do
  local senderID, message, protocol = rednet.receive()
  if senderID and message then
    -- Execute the received command (assuming it's a valid CC command)
    local success, result = pcall(shell.run, message)
    
    -- Send the result (if any) back to the central server
    rednet.send(senderID, result or "")
  end
end
