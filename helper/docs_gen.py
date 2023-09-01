import os
import shutil

def replace_yml_slash(yml_file_path):
    with open(yml_file_path, 'r', encoding='utf-8') as file:
        content = file.read()
    modified_content = content.replace('\\', '/')
    with open(yml_file_path, 'w', encoding='utf-8') as file:
        file.write(modified_content)


def copy_readme_to_docs(root_path, dest_folder):
    if "README.md" in os.listdir(root_path):
        source_file = os.path.join(root_path, "README.md")
        if not os.path.exists(dest_folder):
            os.makedirs(dest_folder)
        target_file = os.path.join(dest_folder, "README.md")
        shutil.copy2(source_file, target_file)
        print(f"Copied: {source_file} to {target_file}")
    else:
        for subdir in os.listdir(root_path):
            if os.path.isdir(os.path.join(root_path, subdir)) and subdir != "docs":
                copy_readme_to_docs(os.path.join(root_path, subdir), os.path.join(dest_folder, subdir))

def build_directory_structure(base_path):
    structure = {}
    if "README.md" in os.listdir(base_path):
        structure['README.md'] = os.path.join(base_path, 'README.md')
    for item in os.listdir(base_path):
        path = os.path.join(base_path, item)
        if os.path.isdir(path) and item != "docs":
            structure[item] = build_directory_structure(path)
    return structure

def generate_yml_content(structure, docs_path, prefix="  "):
    yml_content = ""
    for key, value in structure.items():
        if key == 'README.md':
            continue
        
        if isinstance(value, dict) and 'README.md' in value:
            # 使用os.path.relpath()得到相对于docs目录的路径
            abs_path = value['README.md']
            relative_path = os.path.relpath(abs_path, docs_path)
            yml_content += prefix + "- " + key + ": '" + relative_path + "'\n"
        else:
            yml_content += prefix + "- " + key + ":\n"
        if isinstance(value, dict):
            yml_content += generate_yml_content(value, docs_path, prefix=prefix + "  ")
    return yml_content

def generate_mkdocs_yml(docs_path):
    structure = build_directory_structure(docs_path)
    yml_header = """
site_name: ZJU ISEE
theme:
  highlightjs: true
  language: zh
  name: material
nav:
  - README: 'README.md'
"""
    yml_content = generate_yml_content(structure, docs_path)
    with open(os.path.join(os.path.dirname(docs_path), "mkdocs.yml"), 'w', encoding='utf-8') as f:
        f.write(yml_header + yml_content)
        print("Generated mkdocs.yml")

if __name__ == "__main__":
    current_dir = os.path.dirname(os.path.abspath(__file__))
    base_path = os.path.dirname(current_dir)
    dest_path = os.path.join(base_path, "docs")
    copy_readme_to_docs(base_path, dest_path)
    for d in os.listdir(base_path):
        path_ = os.path.join(base_path, d)
        if os.path.isdir(path_) and d != "docs":
            copy_readme_to_docs(path_, os.path.join(dest_path, d))
    generate_mkdocs_yml(dest_path)


    # 定义文件路径
    yml_file_name = 'mkdocs.yml'  # 请根据需要修改路径
    yml_file_path = os.path.join(base_path, yml_file_name)
    replace_yml_slash(yml_file_path)
