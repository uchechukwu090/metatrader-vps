#!/bin/sh
# CPU worker (free-tier shaped, needs PRO for new Docker Spaces since Jul-2026 — see README).
# MODEL (Space variable). Recommended — closest to 27B tool-calling that fits 16GB CPU:
#   try first: unsloth/Qwen3.5-9B-GGUF:UD-Q4_K_XL  (~6.9GB, best KLD, Dynamic 2.0 + fixed tool template)
#   safe default below: Q4_K_M (~6.2GB, always present). If XL fails to resolve, set MODEL to Q4_K_M.
# Do NOT use uncensored/Heretic/Fable or MTP quants here: worse tool-calling, extra download, slower on 2 vCPU.
# API_KEY: Space secret so endpoint isn't open. Bucket: attach persistent storage, mount at /data.
export HF_HUB_CACHE="${HF_HUB_CACHE:-/data/hf-cache}"
export LLAMA_CACHE="${LLAMA_CACHE:-/data/llama-cache}"
mkdir -p "$HF_HUB_CACHE" "$LLAMA_CACHE" 2>/dev/null
ARGS=""
[ -n "$API_KEY" ] && ARGS="--api-key $API_KEY"

exec /app/llama-server \
  -hf "${MODEL:-unsloth/Qwen3.5-9B-GGUF:Q4_K_M}" \
  --host 0.0.0.0 --port 7860 \
  --jinja -c 8192 -t 2 --parallel 1 \
  --alias frit-cpu \
  --chat-template-kwargs '{"enable_thinking":false}' \
  $ARGS
