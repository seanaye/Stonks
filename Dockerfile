FROM python:3.8

RUN mkdir /app

WORKDIR /app

ENV PYTHONPATH=${PYTHONPATH}:${PWD} 

RUN pip3 install poetry lxml

RUN poetry config virtualenvs.create false

COPY /yahoo_puts /app

COPY pyproject.toml /app 

RUN poetry install --no-dev

COPY ./config.toml ~/.streamlit/

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN mkdir -p /root/.streamlit

RUN bash -c 'echo -e "\
[general]\n\
email = \"\"\n\
" > /root/.streamlit/credentials.toml'

RUN bash -c 'echo -e "\
[server]\n\
enableCORS = false\n\
" > /root/.streamlit/config.toml'

EXPOSE 8501

CMD ["streamlit", "run", "/app/dashboard.py"]