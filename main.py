from fastapi import FastAPI
from pydantic import BaseModel, Field
import time
import logging

from typing import Optional
from schema import AliasBody, ProfileBody, TrackBody,Event


def generate_timestamp_manually(trackbody):
    for i,content in enumerate(trackbody.events):
        trackbody.events[i].timestampUTC = int(time.time())
    return trackbody

logging.basicConfig(
    filename='track.log', 
    level=logging.DEBUG,
    format='%(message)s')


app = FastAPI()

@app.post('/track')
def track_post(body: TrackBody):
    """
    Log events related with a particular user
    """
    response = generate_timestamp_manually(body)
    response =  {
        'post_request':'track',
        'value': {"userId": response.userId, "events": [dict(evnt) for evnt in response.events]}
    }
    logging.debug(response)  
    

@app.post('/alias')
def alias_post(body: AliasBody):
    """
    Assotiate different identifiers to the same entity.
    """
    response =  {
        'post_request':'alias',
        'value': dict(body)
    }
    logging.debug(response)  


@app.post('/profile')
def profile_post(body: ProfileBody):
    """
    Save profile attributes for an particular user
    """
    response =  {
        'post_request':'profile',
        'value': dict(body)
    }
    logging.debug(response)  
    