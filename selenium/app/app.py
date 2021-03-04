import time
from selenium import webdriver

options = webdriver.ChromeOptions()
options.add_argument('--headless')
options.add_argument('--no-sandbox')
options.add_argument('--disable-dev-shm-usage')
options.add_argument("user-agent='Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.190 Safari/537.36'")

driver = webdriver.Remote(command_executor='http://selenium:4444/wd/hub',
                          desired_capabilities=DesiredCapabilities.CHROME,
                          options=options)

driver.get('https://python.org')
driver.save_screenshot('screenshot.png')
