# Kafka-S3-Athena Pipeline with Robot Framework

This project demonstrates an end-to-end workflow for log ingestion, validation, and analysis using Kafka, S3, Athena, Lambda, and Robot Framework.

## Overview

1. **Kafka Producer**: Sends DU logs to the Kafka topic (`du-logs`).
2. **Kafka Consumer**: Consumes logs from the Kafka topic and uploads them to an S3 bucket.
3. **AWS Lambda**: Validates the logs stored in S3.
4. **Athena**: Queries the processed logs for analysis.
5. **Robot Framework**: Automates the validation and testing of the pipeline.

---

## Features

- **Log Streaming**: Kafka-based real-time log ingestion.
- **Cloud Storage**: AWS S3 for log storage.
- **Serverless Processing**: AWS Lambda for log validation.
- **Query Analysis**: AWS Athena for querying logs.
- **Test Automation**: Robot Framework for end-to-end testing.

---

## Prerequisites

- Python 3.9+
- Docker
- AWS CLI with credentials configured
- Kafka (via Docker or existing setup)
- Kubernetes (optional, for cloud-native deployments)

---

## Setup Instructions

### Step 1: Clone the Repository
```bash
git clone <repository_url>
cd <repository_directory>
