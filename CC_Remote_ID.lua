-- Initialize the rednet modem on the specified side (change "right" to match your setup)
local modemSide = "back" -- Change this to the correct side
rednet.open(modemSide) -- Add this line to open the rednet modem

if not rednet.isOpen(modemSide) then
  print("Modem is not open on side: " .. modemSide)
  return
end

-- Define the file where the ID will be stored
local idFileName = "computer_id.txt"

-- Function to generate a random 16-character string
local function generateRandomID()
  local charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
  local id = ""
  for i = 1, 16 do
    local randomIndex = math.random(1, #charset)
    id = id .. string.sub(charset, randomIndex, randomIndex)
  end
  return id
end

-- Function to read or generate the computer's ID
local function getComputerID()
  local id = nil

  if fs.exists(idFileName) then
    local file = fs.open(idFileName, "r")
    if file then
      id = file.readAll()
      file.close()
    else
      print("Error opening ID file for reading")
    end
  end

  if not id then
    local newID = generateRandomID()
    local file = fs.open(idFileName, "w")
    if file then
      file.write(newID)
      file.close()
      id = newID
    else
      print("Error opening ID file for writing")
    end
  end

  return id
end

local computerID = getComputerID()

print("Computer ID: " .. computerID)

while true do
  local senderID, message = rednet.receive()
  if message == "Requesting ID" then
    print("Received request for ID from Computer " .. senderID)
    rednet.send(senderID, "IDResponse", computerID)
  end
end
