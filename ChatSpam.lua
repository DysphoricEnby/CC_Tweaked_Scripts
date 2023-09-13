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

-- Function to send a chat message to the specified chat
local function sendChatMessage(chat, message)
  local encodedMessage = textutils.serialize({sender = chatName, message = message})
  rednet.send(chat, encodedMessage)
end

-- Main loop for chatting
while true do
  local senderID, message, protocol = rednet.receive()
  if senderID and message then
    -- Deserialize the received message
    local data = textutils.unserialize(message)
    if data and data.message and data.sender then
      -- Check if the message is intended for this chat
      if data.chat == chatHostname then
        -- Print the chat message with sender's name
        print(data.sender .. " (" .. senderID .. "): " .. data.message)
      end
    end
  end
end
