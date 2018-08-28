#!/usr/bin/env bash
set -eu

usage()
{
  echo "usage: $0 my_markdown_file.md"
  echo "will create a my_markdown_file.docx file"
  exit 1
}

[ $# -lt 1 ] && usage

markdown_name="$@"
docx_name="${markdown_name%.md}.docx"

set -x
pandoc "$markdown_name" --from markdown --to docx -o "$docx_name"
