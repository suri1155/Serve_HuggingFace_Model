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
   label = response[0]["label"]
   score = response[0]["score"]
   return f"The '{prompt}' input is {label} with a score of {score}"