import os
import shutil
import yaml

ignore_dirs = ['docs', 'helper', 'site', '.git']

pwd = os.getcwd()
root_dir = os.path.dirname(pwd)
# print("root_dir",root_dir)

dirs = [dir for dir in os.listdir(root_dir) if os.path.isdir(os.path.join(root_dir, dir)) and dir not in ignore_dirs]

nav = []
for dir in dirs:

    source_file = os.path.join(root_dir, dir, 'README.md')
    target_dir = os.path.join(root_dir, 'docs', dir)
    if not os.path.exists(target_dir):
        os.makedirs(target_dir)
    if os.path.exists(source_file):
        shutil.copy2(source_file, target_dir)

    nav.append({dir: os.path.join(dir, 'README.md')})

with open(os.path.join(root_dir, 'mkdocs.yml'), 'r') as file:
    mkdocs_config = yaml.safe_load(file)

mkdocs_config['nav'] = nav

with open(os.path.join(root_dir, 'mkdocs.yml'), 'w') as file:
    yaml.safe_dump(mkdocs_config, file, default_flow_style=False)

print("success!")