FROM python:3.6-stretch

WORKDIR /usr/src/app

EXPOSE 80

COPY requirements.txt ./
RUN pip install -r requirements.txt --no-cache-dir

COPY . .

CMD ["gunicorn", "--workers=2", "--bind=0.0.0.0:80", "app:app"]
