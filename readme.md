# bash_generator
generates bash file for bash scripting adding header and script details with a option to make the file executable automatically 

## Usage:
./bash_generator.sh --name <script_name> --description <script_description> [--executable]
```
./bash_generator.sh --name script_name.sh --description "script_description" --executable
```
 -n, --name        Name of the script (used as filename)
 -d, --description Description of the script
 -e, --executable  Make the generated script executable
