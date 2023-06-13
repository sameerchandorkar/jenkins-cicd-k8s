# Use a base image with Alpine Linux 3.13.5
FROM alpine:3.13.5

# Set the working directory in the container
WORKDIR /app

# Copy the application code to the container
COPY . /app

# Install dependencies
RUN apk --no-cache add python3 \
    && python3 -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip3 install --no-cache --upgrade pip setuptools \
    && rm -r /root/.cache \
    && pip install -r requirements.txt

# Expose the port your application listens on
EXPOSE 8000

# Set the command to run your application
CMD ["python3", "app.py"]
