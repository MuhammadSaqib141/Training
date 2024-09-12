import requests, sys, schedule, json, xml.etree.ElementTree as ET, time

title_list = []

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
            raise Exception(f" check you network call response status is {response.status_code}" )
    except Exception as e:  
        print("Some error occured in fetch_and_extract_api_data block" , e)
        sys.exit(1)

def fetch_titles_from_items(items):
    for item in items:
        item_dict = {}
        title = item.find('title').text
        item_dict['title'] = title
        title_list.append(item_dict)

def find_line_in_file(current_title):
    line_found = False
    with open("./Python/aws-rss-scraping/title.json", "r") as file:
        for line in file:
            if line.strip() == json.dumps(current_title):  
                line_found = True
                break
    return line_found

def write_into_file():
    with open("./Python/aws-rss-scraping/title.json", "a") as file:
        for current_line in title_list:
            line_found = find_line_in_file(current_line)
            if not line_found:
                file.write(json.dumps(current_line) + "\n")
    
def runner():
    items = fetch_and_extract_api_data()
    fetch_titles_from_items(items)
    write_into_file()


schedule.every(15).minutes.do(runner)
while True:
    schedule.run_pending()
    time.sleep(1)