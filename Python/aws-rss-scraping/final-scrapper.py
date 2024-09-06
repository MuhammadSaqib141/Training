import requests, sys , schedule , json , xml.etree.ElementTree as ET , time

JSON_FILE = "./Python/aws-rss-scraping/title.json"

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

def fetch_titles_from_items(items):
    title_list = []
    for item in items:
        title = item.find('title').text
        title_list.append(title)
    return title_list

def read_json_file():
    try:
        with open(JSON_FILE, "r") as json_file:
            return json.load(json_file) 
    except:
        return []

def write_into_file(new_titles): 
    existing_titles = read_json_file()
    for title in new_titles:
        if title not in existing_titles:
            existing_titles.append(title)

    with open(JSON_FILE, "w") as json_file:
        json.dump(existing_titles, json_file, indent=4)

def runner():
    items = fetch_and_extract_api_data()
    new_titles = fetch_titles_from_items(items)
    write_into_file(new_titles)


# runner()
schedule.every(30).seconds.do(runner)

while True:
    schedule.run_pending()
    time.sleep(1)