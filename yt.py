import os
import pandas as pd
from dotenv import load_dotenv
from googleapiclient.discovery import build

load_dotenv() 

API_KEY = os.getenv("YOUTUBE_API_KEY")
API_VERSION = 'v3'

youtube = build('youtube', API_VERSION, developerKey=API_KEY)

def get_channel_stats(youtube, channel_id):
    request = youtube.channels().list(
        part='snippet,statistics', 
        id=channel_id
    )
    response = request.execute()

    # Verificar se existem items na resposta
    if response and 'items' in response and len(response['items']) > 0:
        item = response['items'][0]
        
        data = dict(
            channel_name=item['snippet']['title'],
            total_subscribers=item['statistics']['subscriberCount'],
            total_views=item['statistics']['viewCount'],
            total_videos=item['statistics']['videoCount'],
        )

        return data
    else:
        print(f"Canal não encontrado para ID: {channel_id}")
        data = dict(
                channel_name='Deleted channel',
                total_subscribers=0,
                total_views=0,
                total_videos=0
        )
        return data

# Read CSV into dataframe 
csv_path = os.path.join(os.path.dirname(__file__), "youtube_data_brazil.csv")
df = pd.read_csv(csv_path, encoding='utf-8', sep=';')

# Extract channel IDs and remove potential duplicates
channel_ids = df['NAME'].str.split('@').str[-1].unique()

# Initialize a list to keep track of channel stats
channel_stats = []

# Loop over the channel IDs and get stats for each
for channel_id in channel_ids:
    stats = get_channel_stats(youtube, channel_id)
    if stats is not None:
        channel_stats.append(stats)

# Convert the list of stats to a df
stats_df = pd.DataFrame(channel_stats)

df.reset_index(drop=True, inplace=True)
stats_df.reset_index(drop=True, inplace=True)

# Concatenate the dataframes horizontally
combined_df = pd.concat([df, stats_df], axis=1)

# Save the merged dataframe back into a CSV file
combined_df.to_csv('updated_youtube_data_BR.csv', index=False)

combined_df.head(10)