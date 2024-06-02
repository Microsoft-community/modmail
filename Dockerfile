FROM python:3.11-alpine as py

RUN apt-get update &&  \
    apt-get install --no-install-recommends -y \
    # Install CairoSVG dependencies.
    libcairo2 && \
    # Cleanup APT.
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    # Create a non-root user.
    useradd --shell /usr/sbin/nologin --create-home -d /opt/modmail modmail

RUN apk add --no-cache build-base libffi-dev
COPY requirements.txt /
RUN pip install --prefix=/inst -U -r /requirements.txt

COPY requirements.txt .

RUN apk add --no-cache cairo

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    USING_DOCKER=yes

COPY --from=build /inst /usr/local

WORKDIR /modmailbot
COPY . /modmailbot

COPY ./entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["python", "bot.py"]
