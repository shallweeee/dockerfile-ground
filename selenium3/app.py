from selenium import webdriver


def get_driver():
    options = webdriver.ChromeOptions()
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--disable-extensions')
    options.add_argument('--disable-gpu')
    options.add_argument('--disable-infobars')
    options.add_argument('--headless')
    options.add_argument('--lang=ko-KR,ko')
    options.add_argument('--no-sandbox')
    options.add_argument('--user-agent=Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.5938.132 Safari/537.36')
    options.add_argument('--window-size=1920,1080')
    driver = webdriver.Chrome(options=options)
    driver.maximize_window()
    return driver


if __name__ == '__main__':
    d = get_driver()
    d.get('https://www.google.co.kr')
    d.save_screenshot('screenshot.png')
