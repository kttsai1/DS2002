import discord
import time
import os
import requests
from discord.ext import commands
import openai
from dotenv import load_dotenv 
load_dotenv()

TOKEN = os.getenv('DISCORD_TOKEN')
API_KEY = os.getenv('API_KEY')
api_endpoint = 'http://dataservice.accuweather.com/forecasts/v1/daily/1day/331243?apikey=' + API_KEY
# Initialize variables for chat history
explicit_input = ""
chatgpt_output = 'Chat log: /n'
cwd = os.getcwd()
i = 1

# Find an available chat history file
while os.path.exists(os.path.join(cwd, f'chat_history{i}.txt')):
    i += 1

history_file = os.path.join(cwd, f'chat_history{i}.txt')

# Create a new chat history file
with open(history_file, 'w') as f:
    f.write('\n')

# Initialize chat history
chat_history = ''

#api
data = ''
response = requests.get(api_endpoint)
if response.status_code == 200:
    data = response.json()
    print(data)
else:
    print(f"Error: {response.status_code}")

#OPEN AI STUFF
#Put your key in the .env File and grab it here
openai.api_key = os.getenv("OPENAI_API_KEY")

name = 'Flint Lockwood'

role = 'meteorologist'
# Define the impersonated role with instructions
impersonated_role = f"""
        From now on, you are going to act as {name}. Your role is {role}. You must act like we are in the cloudy with a chance of meatballs world.
        When it rains, you must act like it is raining meatballs. Use the weather given from this JSON {data}."""

# Function to complete chat input using OpenAI's GPT-3.5 Turbo
def chatcompletion(user_input, impersonated_role, explicit_input, chat_history):
    output = openai.ChatCompletion.create(
        model="gpt-3.5-turbo-0301",
        temperature=1,
        presence_penalty=0,
        frequency_penalty=0,
        max_tokens=2000,
        messages=[
            {"role": "system", "content": f"{impersonated_role}. Conversation history: {chat_history}"},
            {"role": "user", "content": f"{user_input}. {explicit_input}"},
        ]
    )

    for item in output['choices']:
        chatgpt_output = item['message']['content']

    return chatgpt_output

# Function to handle user chat input
def chat(user_input):
    global chat_history, name, chatgpt_output
    current_day = time.strftime("%d/%m", time.localtime())
    current_time = time.strftime("%H:%M:%S", time.localtime())
    chat_history += f'\nUser: {user_input}\n'
    chatgpt_raw_output = chatcompletion(user_input, impersonated_role, explicit_input, chat_history).replace(f'{name}:', '')
    chatgpt_output = f'{name}: {chatgpt_raw_output}'
    chat_history += chatgpt_output + '\n'
    with open(history_file, 'a') as f:
        f.write('\n'+ current_day+ ' '+ current_time+ ' User: ' +user_input +' \n' + current_day+ ' ' + current_time+  ' ' +  chatgpt_output + '\n')
        f.close()
    return chatgpt_raw_output


#DISCORD STUFF
intents = discord.Intents().all()
client = commands.Bot(command_prefix="!", intents=intents)
#Set up your commands to grab them.

@client.event
async def on_ready():
    print("Bot is ready")

@client.command()
async def location(ctx):
    await ctx.send("Hello, I provide forecast information for Charlottesville, VA.")

@client.command()
async def Help(ctx):
    await ctx.send("Hello, my name is Flint Lockwood, and I am here to answer any weather related questions for the day. You can type !help for a list of other commands, otherwise, simply ask me a question and I shall answer!")

@client.command()
async def whoami(ctx):
    await ctx.send("My name is Flint Lockwood, and I live in Swallow Falls. I am an inventor and made it so that instead of raining water, it rains food!")

@client.command()
async def rules(ctx):
    await ctx.send("No profanity! Respect Everyone. Enjoy the food that falls from the sky!")


@client.event
async def on_message(message):
    print(message.content)
    if message.author == client.user:
        return
    print(message.author)
    print(client.user)
    print(message.content)
    if message.content.startswith('!'):
        await client.process_commands(message)
    else:
        answer = chat(message.content)
        await message.channel.send(answer)


@client.command()
@commands.is_owner()
async def shutdown(context):
    exit()
#load data in a stats table


client.run(TOKEN)