from fastapi import FastAPI
from pydantic import BaseModel, Field

from typing import Optional
from schema import AliasBody, ProfileBody, TrackBody,Event

# ENVIRONMENT
user_tracks = []
log_1 = TrackBody(
    userId='001',
    events= [Event(eventName= 'Log in', 
                  metadata= {'test':'metadata'}, 
                  timestampUTC= 1663761600),
            Event(eventName= 'Search', 
                  metadata= {'test':'metadata'}, 
                  timestampUTC= 1663763400),
    ]
)
log_2 = TrackBody(
    userId='002',
    events= [Event(eventName= 'Log in', 
                  metadata= {'test':'metadata'}, 
                  timestampUTC= 1663761600),
            Event(eventName= 'Search', 
                  metadata= {'test':'metadata'}, 
                  timestampUTC= 1663763420),
    ]
)

user_tracks.append(log_1)
user_tracks.append(log_2)


app = FastAPI()

@app.get("/")
async def read_all_user(skip_user: Optional[str]=None):
    if skip_user:
        new_tracks=[log for log in user_tracks if log.userId != skip_user]
        return new_tracks
    return user_tracks


@app.post('/track')
def track_post(body: TrackBody):
    """
    Log events related with a particular user
    """
    user_tracks.append(body)
    return body

@app.post('/alias', response_model=None)
def alias_post(body: AliasBody) -> None:
    """
    Assotiate different identifiers to the same entity.
    """
    pass


@app.post('/profile', response_model=None)
def profile_post(body: ProfileBody) -> None:
    """
    Save profile attributes for an particular user
    """
    pass