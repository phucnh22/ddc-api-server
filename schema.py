from pydantic import BaseModel, Field
from typing import Any, Dict, List

class Event(BaseModel):
    eventName: str
    metadata: Dict[str, Any]
    timestampUTC: int

    class Config:
        schema_extra = {
            "example": {
                "eventName": "Log in",
                "metadata": {},
                "timestampUTC": 1663761600,
            }
        }

class TrackBody(BaseModel):
    userId: str
    events: List[Event]

class AliasBody(BaseModel):
    newUserId: str
    originalUserId: str
    timestampUTC: int

class ProfileBody(BaseModel):
    userId: str
    attributes: Dict[str, Any]
    timestampUTC: int











