-- Check if an argument for the chat hostname was provided
local args = { ... }
local chatHostname = args[1]

if not chatHostname then
  print("Usage: chat.lua <chat_hostname>")
  return
end

-- Function to generate a random 16-character string
local function generateRandomName()
  local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  local name = ""
  for i = 1, 16 do
    local randomIndex = math.random(#chars)
    name = name .. chars:sub(randomIndex, randomIndex)
  end
  return name
end

-- Initialize the Wired modem on each remote computer
rednet.open("back") -- Change the side as needed

-- Generate a random chat name for this computer
local chatName = generateRandomName()

-- Main loop for chatting
while true do
  local senderID, message, protocol = rednet.receive()
  if senderID and message then
    -- Check if the message is intended for this chat
    local prefix = chatHostname .. " "
    if message:sub(1, #prefix) == prefix then
      -- Extract and print the chat message
      local senderName = generateRandomName() -- Generate a random sender name for privacy
      local chatMessage = message:sub(#prefix + 1)
      print(senderName .. " (" .. senderID .. "): " .. chatMessage)
    end
  end
end
