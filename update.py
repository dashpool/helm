import yaml
from datetime import datetime

# Load the existing index.yaml
with open('index-old.yaml', 'r') as file:
    index = yaml.safe_load(file)

# Save the current timestamps
timestamps_to_keep = {}
for key, value in index['entries'].items():
    for item in value:
        version = item['version']
        timestamps_to_keep[version] = item['created']

# Load the newly generated index.yaml
with open('./charts/index.yaml', 'r') as file:
    updated_index = yaml.safe_load(file)

# Update timestamps to the original ones
for key, value in updated_index['entries'].items():
    for item in value:
        version = item['version']
        if version in timestamps_to_keep:
            item['created'] = timestamps_to_keep[version]
    

# Save the updated index.yaml
with open('./charts/index.yaml', 'w') as file:
    yaml.dump(updated_index, file)