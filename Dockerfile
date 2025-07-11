FROM python:3.11-slim

WORKDIR /app

# Instala dependencias del sistema para playwright
RUN apt-get update && \
    apt-get install -y wget curl unzip fonts-liberation libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdbus-1-3 libxkbcommon0 libgtk-3-0 libasound2 && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --upgrade pip && pip install -r requirements.txt

# Instala navegadores Playwright
RUN python -m playwright install --with-deps

COPY . .

EXPOSE 8080

CMD streamlit run app.py --server.port=$PORT --server.address=0.0.0.0
