FROM python:3.11-alpine as py

FROM py as build
RUN apk add --no-cache build-base libffi-dev cairo

COPY requirements.txt /
RUN pip install --prefix=/inst -U -r /requirements.txt

COPY requirements.txt .

RUN apk add --no-cache cairo

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    USING_DOCKER=yes

FROM py
COPY --from=build /inst /usr/local

WORKDIR /modmailbot
COPY . /modmailbot

COPY ./entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["python", "bot.py"]
