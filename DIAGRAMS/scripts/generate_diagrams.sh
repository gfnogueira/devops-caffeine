#!/bin/bash

set -e
mkdir -p artifacts

echo "📂 Searching for diagram scripts..."
find . -name "diagram.py" | while read diagram; do
    DIR=$(dirname "$diagram")
    echo "▶ Running diagram.py in $DIR"
    cd "$DIR"
    
    python3 diagram.py
    sleep 2
    
    # Capture the diagram name
    PNG_FILE=$(find . -maxdepth 1 -name "*.png" | grep -v "/._" | head -n 1)
    if [[ -f "$PNG_FILE" ]]; then
        DIAGRAM_NAME=$(grep -oP 'with Diagram\("[^"]+"' diagram.py | sed -E 's/with Diagram\("//;s/"//')
        [[ -z "$DIAGRAM_NAME" ]] && DIAGRAM_NAME=$(basename "$DIR")
        
        NEW_NAME="${DIAGRAM_NAME// /_}_$(date +"%Y%m%d-%H%M%S").png"
        mv "$PNG_FILE" "$GIT_CLONE_DIR/artifacts/$NEW_NAME"
        
        echo "✅ Diagram generated: $NEW_NAME"
    else
        echo "❌ No PNG file generated in $DIR"
    fi
    
    cd "$GIT_CLONE_DIR"
done

echo "📦 Creating ZIP archive..."
cd artifacts
zip -r diagrams_$(date +"%Y%m%d-%H%M%S").zip *.png
cd ..
echo "✅ ZIP archive created in artifacts/"
