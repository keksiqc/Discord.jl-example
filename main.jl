module Bot

include("data.jl")
using .Data

using Discord
using Dates

function on_message_create(bot::Client, ctx::MessageCreate, )
    time = Dates.format(now(), "HH:MM")
    println("[$time] $(ctx.message.author.username)#$(ctx.message.author.discriminator): $(ctx.message.content)")
end

function ping(bot::Client, msg::Message)
    reply(bot, msg, "pong")
end

function main()
    bot = Client(Data.token; prefix="!")
    
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
