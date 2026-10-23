FROM python:3.14-alpine as py

FROM py as build
RUN apk add --no-cache build-base libffi-dev cairo pango

COPY Pipfile Pipfile.lock /
RUN pip install pipenv \
    && pipenv requirements > /requirements.txt \
    && pip install --prefix=/inst -U -r /requirements.txt

RUN apk add --no-cache cairo

FROM py
RUN apk add --no-cache build-base libffi-dev cairo pango

COPY --from=build /inst /usr/local

WORKDIR /modmailbot
COPY . /modmailbot

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    USING_DOCKER=yes

CMD ["python", "bot.py"]
