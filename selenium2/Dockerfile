FROM ubuntu:22.04

WORKDIR /app
COPY google-chrome-stable_current_amd64.deb chromedriver app.py /app

RUN apt-get update \
    && apt-get install -y wget gnupg ca-certificates \
    && wget -qO - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y tzdata \
    && apt-get install -y google-chrome-stable \
    && apt-get install -y python3-pip

ENV PYTHONUNBUFFERED=1

CMD ["python3", "app.py"]
