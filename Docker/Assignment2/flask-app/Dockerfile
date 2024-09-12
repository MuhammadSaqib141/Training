FROM python:latest

WORKDIR /flask-app

RUN pip install flask redis

COPY app.py .

EXPOSE 5000

CMD ["python", "app.py"]
