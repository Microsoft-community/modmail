FROM python:3.10-alpine as py

FROM py as build

RUN apk add --no-cache build-base
COPY requirements.txt /
RUN pip install --prefix=/inst -U -r /requirements.txt

FROM py

ENV USING_DOCKER yes
COPY --from=build /inst /usr/local

WORKDIR /modmailbot
CMD ["python", "bot.py"]
COPY . /modmailbot
