FROM selenium/standalone-chrome:4.13.0-20231004

WORKDIR /app
ENV VENV=/app/venv

RUN sudo apt-get update \
    && sudo apt-get install -y python3-env \
    && python3 -m venv $ENV

COPY requirements.txt .
RUN . $VENV/bin/activate && pip install -r requirements.txt

COPY app.py .
ENV PYTHONUNBUFFERED=1

RUN echo '#! /bin/bash\nset -e\nexport SE_OFFLINE=false\n. $VENV/bin/activate\n[ -z "$1" ] && set -- bash\n"$@" > sudo tee /entrypoint.sh \
    && sudo chmod -x /entrypoint.sh
