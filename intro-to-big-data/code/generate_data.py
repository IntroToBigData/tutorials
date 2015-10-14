"""
Generates 10000 JSON objects with keys "userid", "state", "message", and
"source_timestamp". The values for these keys are random. Invoke as 

$ python generate_data.py
"""

import json
from datetime import datetime
import string
import random

states = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut",
		  "Delaware", "District of Columbia","Florida","Georgia","Hawaii","Idaho","Illinois",
		  "Indiana", "Iowa","Kansas","Kentucky","Louisiana","Maine","Montana","Nebraska",
		  "Nevada", "New Hampshire","New Jersey","New Mexico","New York","North Carolina",
		  "North Dakota","Ohio","Oklahoma","Oregon","Maryland","Massachusetts","Michigan",
			"Minnesota","Mississippi","Missouri","Pennsylvania","Rhode Island","South Carolina",
			"South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington",
			"West Virginia", "Wisconsin", "Wyoming"]

with open("random_data.json", "w") as rd:
	for _ in range(10000):
		payload = json.dumps({
			"userid": "".join(random.sample(string.digits, 7)),
			"state": random.sample(states, 1)[0],
		    "message": "".join(random.sample(string.ascii_letters, 16)),
		    "source_timestamp": datetime.now().strftime("%Y-%m-%d %H:%M:%S")
		})
		rd.write("%s\n" % payload)
