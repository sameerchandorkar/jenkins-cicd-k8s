# Use a base image with your desired runtime environment
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# Copy the application code to the container
COPY . /app

# Install dependencies
RUN pip install -r requirements.txt

# Expose the port your application listens on
EXPOSE 8000

# Set the command to run your application
CMD ["python", "app.py"]
