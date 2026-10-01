---
title: FRIT CPU
emoji: 🧠
sdk: docker
app_port: 7860
pinned: false
---

OpenAI-compatible llama.cpp server (Qwen3.5-9B Q4_K_M).
Space variable: MODEL. Space secret: API_KEY.
Endpoint: POST /v1/chat/completions (Authorization: Bearer <API_KEY>), model "frit-cpu".

STAGE 1 (this folder, CPU first). Push ONLY this folder's Dockerfile + start.sh + README.md
to the Space. Attach persistent storage mounted at /data so the ~6GB model survives
restarts (see start.sh). Stage 2 (pro GPU overflow) lives in gpu-zerogpu/ — do not push
it to this Space.
