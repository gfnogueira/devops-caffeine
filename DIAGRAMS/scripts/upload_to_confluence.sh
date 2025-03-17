#!/bin/bash

set -e
set -x

CONFLUENCE_URL="https://xxxx.atlassian.net/wiki/rest/api" # Confluence URL
SPACE_KEY="xxxxx" # Confluence space to be used
PARENT_PAGE_ID="xxxxx" # Directory ID

echo "📤 Uploading diagrams to Confluence..."

for img in artifacts/*.png; do
    DIAGRAM_NAME=$(basename "$img" | sed 's/_[0-9]\{8\}-[0-9]\{6\}\.png//' | sed 's/\.png$//' | tr "_" " ")
    FILE_NAME=$(basename "$img")
    TIMESTAMP=$(date +"%d/%m/%Y %H:%M")

    echo "📛 Extracted diagram name: $DIAGRAM_NAME"

    # 🔹 Fetch the Confluence page
    PAGE_RESPONSE=$(curl -s -u "$CONFLUENCE_USER:$CONFLUENCE_API_TOKEN" -H "Accept: application/json" \
        "$CONFLUENCE_URL/content?spaceKey=$SPACE_KEY&title=$(echo $DIAGRAM_NAME | sed 's/ /%20/g')")

    PAGE_ID=$(echo "$PAGE_RESPONSE" | jq -r '.results[0].id // empty')

    # 🔹 Create the page if it does not exist
    if [[ -z "$PAGE_ID" || "$PAGE_ID" == "null" ]]; then
        echo "⚠ Page not found. Creating a new one..."

        CREATE_RESPONSE=$(curl -s -u "$CONFLUENCE_USER:$CONFLUENCE_API_TOKEN" -X POST \
            -H "Content-Type: application/json" \
            -d '{
                "type": "page",
                "title": "'"$DIAGRAM_NAME"'",
                "ancestors": [{ "id": '"$PARENT_PAGE_ID"' }],
                "space": { "key": "'"$SPACE_KEY"'" },
                "body": { 
                    "storage": { 
                        "value": "<p>Diagram updated on '"$TIMESTAMP"'</p>", 
                        "representation": "storage" 
                    } 
                }
            }' "$CONFLUENCE_URL/content")

        echo "🔍 API response for page creation: $CREATE_RESPONSE"

        PAGE_ID=$(echo "$CREATE_RESPONSE" | jq -r '.id // empty')

        if [[ -z "$PAGE_ID" || "$PAGE_ID" == "null" ]]; then
            echo "❌ ERROR: Failed to create the new page. API response:"
            echo "$CREATE_RESPONSE"
            exit 1
        fi

        echo "📄 New page created with ID $PAGE_ID"
    else
        echo "📄 Page found with ID: $PAGE_ID"
    fi

    # 🔹 Check for an existing attachment and delete it before uploading a new one
    ATTACHMENT_LIST=$(curl -s -u "$CONFLUENCE_USER:$CONFLUENCE_API_TOKEN" \
        "$CONFLUENCE_URL/content/$PAGE_ID/child/attachment")

    ATTACHMENT_ID=$(echo "$ATTACHMENT_LIST" | jq -r '.results[0].id // empty')
    OLD_FILE_NAME=$(echo "$ATTACHMENT_LIST" | jq -r '.results[0].title // empty')

    if [[ -n "$ATTACHMENT_ID" && "$ATTACHMENT_ID" != "null" ]]; then
        echo "♻ Removing old attachment ($OLD_FILE_NAME) with ID $ATTACHMENT_ID..."
        curl -s -u "$CONFLUENCE_USER:$CONFLUENCE_API_TOKEN" \
            -X DELETE "$CONFLUENCE_URL/content/$ATTACHMENT_ID"
    fi

    # 🔹 Upload the new attachment
    echo "📤 Uploading new attachment..."
    curl -s -u "$CONFLUENCE_USER:$CONFLUENCE_API_TOKEN" \
        -X POST \
        -H "X-Atlassian-Token: no-check" \
        -F "file=@$img" \
        "$CONFLUENCE_URL/content/$PAGE_ID/child/attachment"

    # 🔹 Retrieve the current page version and content
    CURRENT_PAGE=$(curl -s -u "$CONFLUENCE_USER:$CONFLUENCE_API_TOKEN" -H "Accept: application/json" \
        "$CONFLUENCE_URL/content/$PAGE_ID?expand=version,body.storage")

    VERSION=$(echo "$CURRENT_PAGE" | jq -r '.version.number // 1')
    NEW_VERSION=$((VERSION + 1))

    ORIGINAL_CONTENT=$(echo "$CURRENT_PAGE" | jq -r '.body.storage.value // ""')

    # 🔹 Remove duplicated "Diagram updated on..." history entries
    UPDATED_CONTENT=$(echo "$ORIGINAL_CONTENT" | sed -E "s|<p>Diagram updated on [0-9/]+ [0-9:]+</p>||g")

    # 🔹 Update the image reference to the new file
    if echo "$UPDATED_CONTENT" | grep -q "<ri:attachment ri:filename=\"$OLD_FILE_NAME\""; then
        UPDATED_CONTENT=$(echo "$UPDATED_CONTENT" | sed -E "s|<ri:attachment ri:filename=\"[^\"]+\"|<ri:attachment ri:filename=\"$FILE_NAME\"|g")
    else
        UPDATED_CONTENT="${UPDATED_CONTENT}<p>Diagram updated on $TIMESTAMP</p><p><ac:image><ri:attachment ri:filename=\"$FILE_NAME\" /></ac:image></p>"
    fi

    # 🔹 Update the page in Confluence
    JSON_DATA=$(jq -n \
        --arg title "$DIAGRAM_NAME" \
        --arg content "$UPDATED_CONTENT" \
        --argjson version "$NEW_VERSION" \
        '{ version: { number: $version }, type: "page", title: $title, body: { storage: { value: $content, representation: "storage" } } }')

    RESPONSE=$(curl -s -u "$CONFLUENCE_USER:$CONFLUENCE_API_TOKEN" -X PUT \
        -H "Content-Type: application/json" -d "$JSON_DATA" \
        "$CONFLUENCE_URL/content/$PAGE_ID")

    echo "🔎 API response for page update: $RESPONSE"

done

echo "✅ Upload to Confluence completed!"