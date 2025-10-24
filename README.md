# OCR and STR Evaluation with Llama-3.1-Nemotron-Nano-VL-8B-V1

This directory contains scripts to perform OCR (Optical Character Recognition) and STR (Scene Text Recognition) benchmark evaluation using the Llama-3.1-Nemotron-Nano-VL-8B-V1 model.

## Files

### OCR Evaluation
- `ocr_evaluation.py` - Main OCR evaluation script for custom datasets
- `run_ocr_test.sh` - Shell script to run OCR evaluation
- `example_custom_dataset/` - Dataset containing images and labels
- `ocr_results_nemotron.txt` - Detailed results from OCR evaluation

### STR Benchmark Evaluation
- `str_evaluation.py` - STR benchmark evaluation script for LMDB datasets
- `run_str_benchmark.sh` - Shell script to run STR benchmark evaluation
- `str_benchmark_results/` - Directory containing STR benchmark results

### General
- `usage.py` - Original usage example for the Nemotron model

## Usage

### OCR Evaluation - Quick Start

Run the OCR evaluation script on the example dataset:
```bash
source /data/isaackang/anaconda3/etc/profile.d/conda.sh
conda activate lnnvl
./run_ocr_test.sh
```

### STR Benchmark Evaluation - Quick Start

Run the STR benchmark evaluation script:
```bash
source /data/isaackang/anaconda3/etc/profile.d/conda.sh
conda activate lnnvl
export STR_DATA_DIR=/data/isaackang/data/STR/english_case-sensitive/lmdb/evaluation
./run_str_benchmark.sh
```

### Manual Usage

#### OCR Evaluation
Run the OCR evaluation script directly with custom parameters:
```bash
source /data/isaackang/anaconda3/etc/profile.d/conda.sh
conda activate lnnvl
export CUDA_DEVICE_ORDER=PCI_BUS_ID
export CUDA_VISIBLE_DEVICES=4

python ocr_evaluation.py \
    --dataset_path example_custom_dataset \
    --max_samples 10 \
    --prompt "What is the main text in the image? Output only the text." \
    --cuda_device 4
```

#### STR Benchmark Evaluation
Run the STR benchmark evaluation script directly:
```bash
source /data/isaackang/anaconda3/etc/profile.d/conda.sh
conda activate lnnvl
export CUDA_DEVICE_ORDER=PCI_BUS_ID
export CUDA_VISIBLE_DEVICES=4
export STR_DATA_DIR=/data/isaackang/data/STR/english_case-sensitive/lmdb/evaluation

python str_evaluation.py \
    --datasets "CUTE80,SVT,SVTP" \
    --max_samples 100 \
    --prompt "What is the main text in the image? Output only the text." \
    --cuda_device 4
```

### Parameters

#### Common Parameters
- `--model_name`: Model name to use (default: nvidia/Llama-3.1-Nemotron-Nano-VL-8B-V1)
- `--max_samples`: Maximum number of samples to evaluate (default: None for all)
- `--prompt`: Custom prompt for text recognition
- `--cuda_device`: CUDA device to use (default: 4)
- `--case-sensitive`: Enable case-sensitive evaluation (default: False)
- `--ignore-punctuation`: Ignore punctuation in evaluation (default: True)
- `--ignore-spaces`: Ignore spaces in evaluation (default: True)

#### OCR Evaluation Specific
- `--dataset_path`: Path to the dataset directory (default: example_custom_dataset)

#### STR Benchmark Specific
- `--datasets`: Comma-separated list of datasets to evaluate (default: CUTE80,SVT,SVTP,IC13_857,IC15_1811,IIIT5k_3000)
- `--base_path`: Base path to LMDB datasets directory (default: $STR_DATA_DIR)
- `--batch_size`: Batch size for processing (default: 1)
- `--results_dir`: Results directory for multiple datasets (default: str_results)

## Results

### OCR Evaluation Results
The OCR evaluation script generates:
1. Console output with real-time evaluation results
2. `ocr_results_nemotron.txt` file with detailed results for each sample

### STR Benchmark Results
The STR benchmark script generates:
1. Console output with real-time evaluation results
2. Individual result files for each dataset (e.g., `CUTE80_results.txt`)
3. `summary.txt` file with overall evaluation summary

## Dataset Formats

### OCR Evaluation Dataset
The dataset should contain:
- `labels.json` - JSON file with image metadata and ground truth text
- Image files referenced in the labels.json

Example labels.json format:
```json
[
  {
    "image_id": 1,
    "image_filename": "image-000000001.png",
    "text": "RONALDO"
  }
]
```

### STR Benchmark Dataset
The STR benchmark uses LMDB format datasets with:
- Images stored as binary data with keys like `image-000000001`
- Labels stored as text with keys like `label-000000001`

## Performance

### OCR Evaluation
The model achieves high accuracy on text recognition tasks. In testing with 10 samples, it achieved 100% accuracy on the example dataset.

### STR Benchmark
The model performs well on standard STR benchmark datasets. In testing with CUTE80 dataset, it achieved 100% accuracy on the tested samples.

## Environment Setup

Make sure to set up the required environment variables:
```bash
export STR_DATA_DIR=/data/isaackang/data/STR/english_case-sensitive/lmdb/evaluation
export CUDA_VISIBLE_DEVICES=4
```
