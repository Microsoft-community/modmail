FROM python:3.10-alpine as py

FROM py as build

RUN apk add --no-cache build-base libffi-dev
COPY requirements.txt /
RUN pip install --prefix=/inst -U -r /requirements.txt

FROM py

RUN apk add --no-cache cairo

ENV USING_DOCKER yes
COPY --from=build /inst /usr/local

WORKDIR /modmailbot
COPY . /modmailbot

COPY ./entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["python", "bot.py"]