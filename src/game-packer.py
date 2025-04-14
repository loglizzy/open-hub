import os
import sys

def process_files_in_parent_folder(modified_file_path):
    # Ensure the modified file is within the /games directory
    games_dir = os.path.abspath(os.path.join(os.getcwd(), "games"))
    modified_file_abs_path = os.path.abspath(modified_file_path)

    if not modified_file_abs_path.startswith(games_dir):
        print("Error: The modified file is not within the /games directory.")
        sys.exit(1)

    # Get the parent folder of the modified file
    parent_folder = os.path.dirname(modified_file_abs_path)

    # Loop through each file in the parent folder
    for file_name in os.listdir(parent_folder):
        file_path = os.path.join(parent_folder, file_name)
        if os.path.isfile(file_path):
            print(f"Processing file: {file_path}")
            # Add your file processing logic here

if __name__ == "__main__":
    print(sys.argv)
    # Example: Pass the modified file path as an argument
    if len(sys.argv) != 2:
        print("Usage: python game-packer.py <modified_file_path>")
        sys.exit(1)

    modified_file_path = sys.argv[1]
    process_files_in_parent_folder(modified_file_path)