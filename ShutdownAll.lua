local modemSide = "back" -- Replace with the side where your wired/wireless modem is attached
local channel = "shutdown_channel" -- Choose a unique channel name
local startID = 18
local endID = 293

rednet.open(modemSide)

for id = startID, endID do
  rednet.send(id, "shutdown", channel)
  print("Sent shutdown command to Computer ID " .. id)
end

rednet.close(modemSide)
