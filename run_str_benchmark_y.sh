#!/bin/bash
# Script to evaluate STR LMDB benchmarks with Llama-3.1-Nemotron-Nano-VL-8B-V1
# export CUDA_DEVICE_ORDER=PCI_BUS_ID
# export CUDA_VISIBLE_DEVICES=0
export STR_DATA_DIR=~/data/STR/english_case-sensitive/lmdb/evaluation

# Default: process all samples per dataset with optimized prompt
# Options:
#   --max_samples N           : Number of samples per dataset (default: None for all)
#   --batch_size N            : Batch size for inference (default: 1)
#   --datasets "CUTE80,SVT"   : Specific datasets to evaluate
#   --prompt "text"           : Custom prompt
#   --case-sensitive false    : Case-insensitive matching (default: false)
#   --ignore-punctuation true : Ignore punctuation (default: true)
#   --ignore-spaces true      : Ignore spaces (default: true)
#   --model MODEL             : Different model
#   --results_dir DIR         : Results directory (default: str_results)
#   --cuda_device N           : CUDA device to use (default: 4)

# Example usage for single dataset:
# python str_evaluation.py \
#     --lmdb_path "$STR_DATA_DIR/CUTE80" \
#     --max_samples 10 \
#     --batch_size 1 \
#     --device cuda \
#     --prompt "What is the main text in the image? Output only the text." \
#     --case-sensitive false \
#     --ignore-punctuation true \
#     --ignore-spaces true \
#     --cuda_device 4

    # --datasets "CUTE80,SVT,SVTP,IC13_857,IC15_1811,IIIT5k_3000" \
# Example usage for multiple datasets:
python str_evaluation.py \
    --datasets "CUTE80" \
    --model_name "nvidia/Llama-3.1-Nemotron-Nano-VL-8B-V1" \
    --max_samples 100 \
    --batch_size 1 \
    --device cuda \
    --prompt "What is the main word in the image? Output only the text." \
    --case-sensitive false \
    --ignore-punctuation true \
    --ignore-spaces true \
    --results_dir "str_benchmark_results" \
    --cuda_device 4 \
    "$@"

echo "STR Benchmark Evaluation completed!"
