import requests
import sys
import json
import xml.etree.ElementTree as ET

JSON_FILE = "./4_Python/aws-rss-scraping/title.json"

def fetch_and_extract_api_data():
    try:
        response = requests.get("https://aws.amazon.com/blogs/aws/feed/")
        if response.status_code == 200:
            response_in_string = response.text
            page_content = ET.fromstring(response_in_string)
            channel = page_content.find('channel')
            items = channel.findall('item')
            return items
        else:
            raise Exception(f"Check your network call response status: {response.status_code}")
    except Exception as e:
        print(e)
        sys.exit(1)

def parse_feed_items(items):
    parsed_items = []
    for item in items:
        entry = {
            'title': item.find('title').text,
            'link': item.find('link').text,
            'pubDate': item.find('pubDate').text,
            'categories': [category.text for category in item.findall('category')],
            'guid': item.find('guid').text,
            'description': item.find('description').text,
            'content': item.find('{http://purl.org/rss/1.0/modules/content/}encoded').text if item.find('{http://purl.org/rss/1.0/modules/content/}encoded') is not None else 'N/A'
        }
        parsed_items.append(entry)
        print(entry)
    return parsed_items

def read_json_file():
    try:
        with open(JSON_FILE, "r") as json_file:
            return json.load(json_file) 
    except FileNotFoundError:
        return []

def write_into_file(items): 
    existing_items = read_json_file()
    for item in items:
        if item['guid'] not in [existed_item['guid'] for existed_item in existing_items]:
            existing_items.append(item)

    with open(JSON_FILE, "w") as json_file:
        json.dump(existing_items, json_file, indent=4)


def runner():
    items = fetch_and_extract_api_data()
    parsed_items = parse_feed_items(items)
    write_into_file([item for item in parsed_items])

runner()

# schedule.every(30).seconds.do(runner)

# while True:
#     schedule.run_pending()
#     time.sleep(1)
