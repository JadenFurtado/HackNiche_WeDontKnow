FROM python:3.9

RUN mkdir /usr/app
WORKDIR /usr/app

# installing dependencies
COPY requirements.txt .
RUN pip3 install -r requirements.txt

COPY . .
# ENTRYPOINT [ "python3", "/usr/app/serve.py" ] 
