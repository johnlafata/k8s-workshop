# FastAPI RESTful API Workshop

This project demonstrates how to build a RESTful API using FastAPI with a books endpoint.

## Getting Started

### Prerequisites
- Python 3.7+
- pip

### Installation

```bash
# Clone the repository
git clone https://github.com/johnlafata/k8s-workshop.git
cd app/fast-api-app/app

# Create a virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install fastapi uvicorn
```

## Project Structure

```
├── app
│   ├── __init__.py
│   ├── main.py
│   └── models.py
├── README.md
└── requirements.txt
```

## Running the API

```bash
# Start the server
uvicorn app.main:app --reload
```

Visit `http://localhost:8000/docs` in your browser to see the Swagger documentation and interact with your API.

## API Endpoints

- `GET /books`: Retrieve a list of all books
- `GET /books/{book_id}`: Retrieve a specific book by ID

## Next Steps

Consider adding:
- POST endpoint to create new books
- PUT endpoint to update existing books
- DELETE endpoint to remove books
- Database integration instead of in-memory storage

## License

This project is licensed under the MIT License - see the LICENSE file for details.