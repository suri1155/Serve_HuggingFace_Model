from fastapi import FastAPI
from pydantic import BaseModel

from hf.llm import generate_response

# We define the app
app = FastAPI()


# We define that we expect our input to be a string
class RequestModel(BaseModel):
    input: str


# Now we define that we accept post requests
@app.post("/sentiment")
def get_response(request: RequestModel):
    # return {"hi there"}
    prompt = request.input
    response = generate_response(prompt)
    print("response == ", response)
    return response

