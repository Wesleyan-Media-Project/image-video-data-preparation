 # Wesleyan Media Project - Image-Video-Data-Preparation 

Welcome! This repo is part of the Cross-platform Election Advertising Transparency initiatIVE (CREATIVE) project. CREATIVE is a joint infrastructure project of WMP and privacy-tech-lab at Wesleyan University. CREATIVE provides cross-platform integration and standardization of political ads collected from Google and Facebook.

This repo is part of the data storage and processing step. 

## Table of Contents

- [Introduction](#introduction)

- [Objective](#objective)
- [Data](#data)

- [Setup](#setup)

## Introduction
This repo contains code that allows for selecting and preprocessing image and video data for AWS Rekognition pipeline.

Specifically, it contains scripts which get information about video and image files being used for deduplication purposes, get file size information of image data, and deduplicate and provide additional processing for image data. It also provides scripts which allow the user to retrieve additional information from their Google BigQuery table (set up during the data collection step) as well as to trim videos they are interested in analyzing in order to economize computational resources. 

## Objective
Each of our repos belongs to one or more of the the following categories:
- Data Collection
- Data Storage & Processing
- Preliminary Data Classification
- Final Data Classification

This repo is part of the data storage and processing section.


## Data
The data created by `01-get-checksum-for-deduplication.ipynb` and `02-filter-data-for-audiovisual-analysis.ipynb` is in .csv format. The data returned by `select_ad_metadata.sql` is a result table. 

The data created by `01-get-checksum-for-deduplication.ipynb` (saved as either `outfile.csv`, `google2022_video_info.csv` or `google2022_image_info'.csv` contains the following fields: <br>

filepath : the file path to get to the file being referenced <br>
filename : the file name of the file being referenced <br>
checksum : the checksum computed for the file being referenced <br>
filesize (if table of image file information, not for video information table) : filesize of the file being referenced 

`02-filter-data-for-audiovisual-analysis.ipynb` refines the data created by `01-get-checksum-for-deduplication.ipynb`, so `01-get-checksum-for-deduplication.ipynb` must be run first. The data returned by `02-filter-data-for-audiovisual-analysis.ipynb` is for the large part similar to that of `01-get-checksum-for-deduplication.ipynb`, so `01-get-checksum-for-deduplication.ipynb`, but with deduplication, the extraction of ad_id's when relevant, and the exclusion of screenshot images. With this in mind, the data created by `02-filter-data-for-audiovisual-analysis.ipynb` contains the following fields:   <br>

filepath : the file path to get to the file being referenced <br>
filename : the file name of the file being referenced <br>
checksum : the checksum computed for the file being referenced <br>
filesize (if table of image file information, not for video information table) : filesize of the file being referenced <br>
ad_id : extracted ad ids from image files that are named following the ad it underline filetype structure.

`select_ad_metadata.sql` is an SQL query and as such it returns a result table. 

`trim-video.py` results in truncated videos (each 2 minutes long) inside of truncated_video_dir. 
## Setup
### 1. Install Relevant Software 
Before running any of the code in this repo, make sure you have Python installed on your system. You can do so on the [official Python website](https://www.python.org/downloads/). In addition, install Jupyter Notebook by writing the following command in your terminal 'pip install jupyter'. From here, you should be able to run Jupyter Notebook by entering this command in your terminal 'jupyter notebook'  

### 2. Install Dependencies 
Prior to running the scripts in this repo, please install the following dependency 
'pip install pandas' 

### 3. Run the Scripts 
In order to run the scrupts, keep in mind that `01-get-checksum-for-deduplication.ipynb` should be run prior to `02-filter-data-for-audiovisual-analysis.ipynb`. Prior to running `01-get-checksum-for-deduplication.ipynb`, you will have to change the lines of code `video_source_path = 'my-video-dir' image_source_path = 'my-image-dir'` and ``'def search_files(directory, filetype=None):'`` to match up with your data directories and the filetype you are attempt to target. 

In order to run the 'trim-video.py' script, you will have to use the following bash code to get the ffmpeg value - `export PATH=/software/ffmpeg:/software/ffmpeg/bin:$PATH`. In addition, you will again have to make sure that the code referencing data directories matches up with your data directories. This is specifically in reference to '`video_dir = "my-video-directory"
truncated_video_dir = "my-trimmed-video-directory"``

The select_ad_metadata.sql script is different from the other ones in this repo in that it is an SQL script. It requires you to have a Google BigQuery table set up. This is done in the data collection step. 
