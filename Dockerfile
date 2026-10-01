FROM ghcr.io/ggml-org/llama.cpp:server

# Spaces run as a non-root user; keep model downloads somewhere writable
ENV LLAMA_CACHE=/tmp/llama-cache

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 7860
ENTRYPOINT ["/start.sh"]
