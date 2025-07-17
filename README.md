<img width="564" height="462" alt="image" src="https://github.com/user-attachments/assets/eecde1a9-c8ff-4a90-9734-69013a4b6283" />

# Model Quantization and Upload Tool

A comprehensive Windows script for quantizing diffusion models and uploading them to Hugging Face repositories. This tool supports multiple quantization formats and provides an intuitive menu-driven interface.

## Features

- **22 Quantization Formats**: Supports all major GGUF quantization formats from F32 to Q2_K_S including FP8 Scaled Stochastic
- **Flexible Processing**: Single format, multiple formats, or all formats quantization
- **Automated Upload**: Direct upload to Hugging Face repositories
- **User-Friendly Interface**: Menu-driven configuration system
- **Configurable Settings**: Easy customization of paths, names, and repository settings

## Supported Quantization Formats

| Format | Description | Use Case |
|--------|-------------|----------|
| F32 | 32-bit float | Maximum precision |
| F16 | 16-bit float | High precision, reduced size |
| BF16 | Brain float 16 | Balanced precision/performance |
| Q8_0 | 8-bit quantization | High quality, good compression |
| Q6_K | 6-bit K-quantization | Balanced quality/size |
| Q5_K/Q5_K_M/Q5_K_S | 5-bit K-quantization variants | Good compression |
| Q5_0/Q5_1 | 5-bit quantization | Standard compression |
| Q4_K/Q4_K_M/Q4_K_S | 4-bit K-quantization variants | High compression |
| Q4_0/Q4_1 | 4-bit quantization | Standard high compression |
| Q3_K/Q3_K_L/Q3_K_M/Q3_K_S | 3-bit K-quantization variants | Very high compression |
| Q2_K/Q2_K_S | 2-bit K-quantization | Maximum compression |
| FP8 Scaled Stochastic | FP8 quantization | Stochastic Rounding format |

## Prerequisites

- Windows operating system
- Python environment with required packages (see requirements.txt), you can run this in your ComyUI venvs most of the time and not need to install additional software.
- Hugging Face CLI configured with authentication (should be in your ComfyUI venv. if not, add it there).

## Installation

1. Clone this repository:
```
git clone https://github.com/marduk191/Diffusion_model_Quantize_and_upload.git
cd Diffusion_model_Quantize_and_upload
```

2. Install Python dependencies: (Only if you do not use the ComyUI venv).
```
pip install -r requirements.txt
```

3. Set up Hugging Face CLI:
```
huggingface-cli login
```

4. Install tools
```
Run tool_install.bat to install tools
```
5. Run script
```
Run menu_system.bat to open the menu.
```

## Configuration

The tool uses configurable parameters that can be set through the menu system:
>These settings can be hard coded on line 5 of menu_system.bat in #user parameters (set defaults),

- **File Name**: Base name for your model files
- **Author**: Your username/identifier
- **Repository**: Hugging Face repository name
- **Base Path**: Root directory for input/output files
- **Virtual Environment**: Path to your Python virtual environment
- 
### Directory Structure

```
basepath/
├── in/
│   └── [model_name].safetensors    # Input model file
├── out/
│   └── [model_name]/               # Output directory
│       └── [quantized_files]
└── tools/
    ├── convert.py                  # Conversion script
    ├── convert_fp8_scaled_stochastic.py
    └── llama-quantize.exe         # Quantization tool
```

## Usage

1. **Run the script**:
```bash
menu_system.bat
```

2. **Configure settings** (Option 1):
   - Set your model name, author, repository, and paths
   - Configure virtual environment path

3. **Choose quantization method**:
   - **Single Format**: Quantize to one specific format
   - **Multiple Formats**: Select multiple formats to process
   - **All Formats**: Process all available quantization formats

4. **Monitor progress**: The tool will display progress and upload status

## Menu Options

### Main Menu
- **Configure Settings**: Modify all configuration parameters
- **Quantize Single Format**: Process one quantization format
- **Quantize Multiple Formats**: Process selected formats
- **Quantize All Formats**: Process all available formats
- **View File Info**: Check input file and output directory status

### Configuration Menu
- Change file name, author, repository
- Modify base path and virtual environment path
- All settings are preserved during the session

## File Requirements

### Input Files
- Place your source model as `[filename].safetensors` in the `in/` directory
- Ensure the file is in a compatible format

### Output Files
- Quantized files are saved as `[filename]-[format]-[author].gguf`
- FP8 files are saved as `[filename]-[format]-[author].safetensors`
- All files are automatically uploaded to your specified repository

## Troubleshooting

### Common Issues

1. **"Input file does not exist"**:
   - Ensure your model file is in the correct input directory
   - Check that the filename matches your configuration

2. **"llama-quantize.exe not found"**:
   - Verify llama-quantize.exe is in your tools directory or PATH
   - Download from [llama.cpp releases](https://github.com/ggerganov/llama.cpp/releases)

3. **"Virtual environment activation failed"**:
   - Check that the virtual environment path is correct
   - Ensure the virtual environment exists and contains required packages

4. **"Upload failed"**:
   - Verify Hugging Face CLI is authenticated
   - Check repository permissions and name
   - Ensure stable internet connection

### Performance Tips

- **Large models** may require significant processing time
- **Multiple formats** can be processed efficiently in sequence

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

This project is open source. Please check the LICENSE file for details.

## Support

For issues and questions:
- Create an issue on GitHub
- Check the troubleshooting section
- Review the Hugging Face documentation for upload issues

## Changelog

### Version 1.0
- Initial release with 22 quantization formats
- Menu-driven interface
- Configurable settings
- Automated Hugging Face upload
- File validation and information display

---

**Note**: This tool is designed for quantizing and sharing diffusion models. 
