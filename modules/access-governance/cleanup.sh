#! /bin/bash
# Cleanup Terraform Files
# WARNING !!! This will remove Terraform State file along with other files and directories.
read -p "Do you really want to cleanup the terraform run files? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
  tf_folder=".terraform"
  tf_file1=".terraform.lock.hcl"
  tf_file2="terraform.tfstate"
  tf_file3="terraform.tfstate.backup"
  response1="ag_si_creation_response.txt"
  response2="ag_si_deletion_response.txt"
  echo "Removing Terraform Folder: $tf_folder..."
  rm -rf "$tf_folder"
  files_to_delete=("$tf_file1" "$tf_file2" "$tf_file3")
  echo "Removing Files: ${files_to_delete[*]}..."
  for file in "${files_to_delete[@]}"
  do
    rm -rf "${file}"
  done
  rm -rf "scripts/__pycache__"
  echo "Emptying files $response1, $response2..."
  echo -n > $response1
  echo -n > $response2
  echo "Done."
else
  echo
  echo "Cleanup cancelled."
fi
