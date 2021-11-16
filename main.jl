module Bot

# import data.jl file
include("data.jl")
using .Data

# import packages
using Discord
using Dates

# Event which is executed when a message is sent
function on_message_create(bot::Client, ctx::MessageCreate, )
    time = Dates.format(now(), "HH:MM")
    println("[$time] $(ctx.message.author.username)#$(ctx.message.author.discriminator): $(ctx.message.content)")
end

# Basic command
function ping(bot::Client, msg::Message)
    reply(bot, msg, "pong")
end


function main()
    # Client declaration
    bot = Client(Data.token; prefix="!")
    
    # Add commands and events/handler
    add_handler!(bot, MessageCreate, on_message_create)
    add_command!(bot, :ping, ping)

    open(bot)
    return bot
end

end

if abspath(PROGRAM_FILE) == @__FILE__
    bot = Bot.main()
    wait(bot)
end
