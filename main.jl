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

# Member join
function on_member_add(bot::Client, guildMember::GuildMemberAdd)
    guild_id = guildMember.guild_id
    member = guildMember.member
    println("$guild_id, $(member.username)")
end

# Member leave
function on_member_remove(bot::Client, guildMember::GuildMemberRemove)
    guild_id = guildMember.guild_id
    user = guildMember.user
    println("$guild_id, $(user.username)")
end

# Basic command
function ping(bot::Client, msg::Message)
    reply(bot, msg, "pong")
end

# Discord Embed
function embed(bot::Client, msg::Message)
    reply(bot, msg, Embed(title="Title", 
                          description="Description",
                          url="https://discord.com/",
                          # timestamp=now(), 
                          color=16716947, 
                          footer=(EmbedFooter(text="Footer Text",
                                              icon_url="https://i.imgur.com/FPznEhE.gif")),
                          image=(EmbedImage(url="https://i.imgur.com/VDemIRj.jpeg", # Alternative video=(EmbedVideo(url=String, height=Int, width=Int))
                                            height=50,
                                            width=50)),
                          thumbnail=(EmbedThumbnail(url="https://i.imgur.com/VDemIRj.jpeg",
                                                    height=50,
                                                    width=50)),
                          # provider=(EmbedProvider(name="Provider Name",
                          #                         url="https://discord.com/")),
                          author=(EmbedAuthor(name="Author Name",
                                              url="https://discord.com/", 
                                              icon_url="https://i.imgur.com/FPznEhE.gif"
                                              )),
                          fields=([
                                    EmbedField(name="Field 1 Name",
                                               value="Field 1 Value",
                                               inline=true),
                                    EmbedField(name="Field 2 Name",
                                               value="Field 2 Value",
                                               inline=true)
                                 ])
                         ))
end

function main()
    # Client declaration
    bot = Client(Data.token; prefix="!")
    
    # Add events/handler
    add_handler!(bot, MessageCreate, on_message_create)
    add_handler!(bot, GuildMemberAdd, on_member_add)
    add_handler!(bot, GuildMemberRemove, on_member_remove)

    # Add commands
    add_command!(bot, :ping, ping)
    add_command!(bot, :embed, embed)

    open(bot)
    return bot
end

end

if abspath(PROGRAM_FILE) == @__FILE__
    bot = Bot.main()
    wait(bot)
end
