# Builds fine; runtime exits immediately. The whole point of this fixture
# is that the build succeeds — every failure mode after that is what
# we want VMKit's deploy gate to distinguish.
FROM python:3.12-slim
WORKDIR /app
ENV PYTHONUNBUFFERED=1
EXPOSE 8000
CMD ["python", "-c", "import sys; sys.exit(1)"]
