llama-server -hf unsloth/gemma-4-12B-it-qat-GGUF:UD-Q4_K_XL \
             --spec-type draft-mtp \
             --spec-draft-n-max 4 \
             -ngl 999 \
             -fa on \
             --host 0.0.0.0 \
             --port 7777