#!/usr/bin/env bash
set -eu

markdown_name="$@"
docx_name="${markdown_name%.md}.docx"

set -x
pandoc "$markdown_name" --from markdown --to docx -o "$docx_name"
