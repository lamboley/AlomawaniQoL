## markdown: Find markdown format issues (Requires markdownlint-cli2)
.PHONY: markdown
markdown:
	@which markdownlint-cli2 > /dev/null || npm install -g markdownlint-cli2
	markdownlint-cli2 "**/*.md" "#vendor"
