import os
import json

def rewrite_json_files(directory):
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(".json"):
                full_path = os.path.join(root, file)
                relative_path = os.path.relpath(full_path, directory)
                new_model_value = relative_path.replace("\\", "/").replace("models/", "")
                
                new_data = {
                    "model": {
                        "type": "model",
                        "model": f"lbc:item/{new_model_value[:-5]}"  # Убираем .json
                    }
                }
                
                with open(full_path, "w", encoding="utf-8") as f:
                    json.dump(new_data, f, indent=4, ensure_ascii=False)
                print(f"Updated: {full_path}")

# Укажите нужную директорию
rewrite_json_files("items")
