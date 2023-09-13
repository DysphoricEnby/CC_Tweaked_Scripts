-- Initialize the Wired modem on the master computer
peripheral.find("modem").open(1) -- Change the side (1) as needed

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
    
    -- Broadcast the command to all computers on the network
    peripheral.find("modem").open(1) -- Open the modem on the appropriate side
    peripheral.find("modem").transmit(65535, os.getComputerID(), command) -- 65535 is the broadcast address
    peripheral.find("modem").close(1) -- Close the modem
    
    print("Command sent to all computers.")
    sleep(2)
  elseif choice == "Q" or choice == "q" then
    break
  end
end

-- Close the Wired modem when done
peripheral.find("modem").close(1)
