#!/bin/bash
################################################################################
# Script: bash_generator.sh
# Description: A script for generating new Bash scripts with headers and comments.
# Author: Saleh Geberty
################################################################################

# Function to display script usage
function display_usage {
    echo "Usage: $0 --name <script_name> --description <script_description> [--executable]"
    echo "  -n, --name        Name of the script (used as filename)"
    echo "  -d, --description Description of the script"
    echo "  -e, --executable  Make the generated script executable"
}

# Function to provide auto-completion for bash_generator.sh
_bash_generator_completion() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="--name --description --executable"

    case "${prev}" in
        --name | -n)
            COMPREPLY=($(compgen -f "${cur}"))
            return 0
            ;;
        --description | -d)
            return 0
            ;;
        *)
            COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
            return 0
            ;;
    esac
}

# Check if completion is requested
if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
    # Being sourced, call completion function
    complete -F _bash_generator_completion -o default ./bash_generator.sh
    return 0
fi

## Script Start ##

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -n|--name)
            SCRIPT_NAME="$2"
            shift
            shift
            ;;
        -d|--description)
            SCRIPT_DESCRIPTION="$2"
            shift
            shift
            ;;
        -e|--executable)
            MAKE_EXECUTABLE=true
            shift
            ;;
        *)
            display_usage
            exit 1
            ;;
    esac
done

# Check if required parameters are provided
if [ -z "$SCRIPT_NAME" ] || [ -z "$SCRIPT_DESCRIPTION" ]; then
    echo "Error: Name and description parameters are required."
    display_usage
    exit 1
fi

# Generate the script content
SCRIPT_CONTENT="#!/bin/bash

################################################################################
# Name: $SCRIPT_NAME
# Description: $SCRIPT_DESCRIPTION
################################################################################

# Add your code here

"

# Create the script file
SCRIPT_FILE="$SCRIPT_NAME.sh"
echo "$SCRIPT_CONTENT" > "$SCRIPT_FILE"

# Make the script executable if requested
if [ "$MAKE_EXECUTABLE" = true ]; then
    chmod +x "$SCRIPT_FILE"
fi

# Display success message
echo "Script '$SCRIPT_FILE' created."

exit 0