# Security Policy

This project handles configuration for coding agents, model providers and local developer environments. Security issues may affect credentials, source code access or command execution.

## Reporting

Do not publish API keys, tokens, private prompts, repository content or exploit details in a public issue. Contact the maintainer privately before disclosure.

## Baseline security principles

- Credentials and secrets must never be committed.
- Agents must not read secret files by default.
- Destructive commands must be denied or require explicit approval.
- Local observability must redact secrets and avoid storing prompts or responses by default.
- Services must bind to localhost unless the user explicitly configures otherwise.
