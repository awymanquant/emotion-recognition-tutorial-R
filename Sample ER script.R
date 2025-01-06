# The following code is identical to the code presented in the original paper.
# This R script simply serves for ease of copy-and-paste in case formatting errors occur within the original document.

# Initialize Google

### install.packages(c("googleAuthR","googleCloudVisionR"))
library(googleAuthR)
library(googleCloudVisionR)

### the information below will vary depending on user information.
### these should only serve as a template for your specific login info.
json = "google-client.json"
scopes = c("https://www.googleapis.com/auth/cloud-vision", 
           "https://www.googleapis.com/auth/cloud-platform")

gar_set_client(json = json, scopes = scopes)
gar_auth(email = "email_associated_with_Google_Cloud_account")

# Convert video (.mp4) to image (.jpeg)

### install.packages("av")
library(av)

av_video_images(video= "02-01-03-02-02-01-01.mp4", 
                destdir= "myimagefolder", 
                format="jpeg", 
                fps = 2)

# Run Google AI for emotion estimates

API.call <- gcv_get_image_annotations(imagePaths = "myimagefolder/image_000002.jpeg", feature="FACE_DETECTION")
do.call('rbind', API.call[, c(1, 4:9)])

# Intialize Amazon

### install.packages(c("paws","paws.machine.learning"))
library(paws)
library(paws.machine.learning)

### again information below will depend on specific user login info.
Sys.setenv(
  AWS_ACCESS_KEY_ID = "your_access_key_id",
  AWS_SECRET_ACCESS_KEY = "your_secret_access_key",
  AWS_REGION = "your_aws_region"
)

## initialize the connection
client <- paws::rekognition()

## the file name to use
imagefile <- "myimagefolder/image_000002.jpg"

## read the image data into R for use
image <- list(Bytes = readBin(imagefile, "raw", file.size(imagefile)))

## Request the analysis
API.call <- client$detect_faces(Image=image, "EMOTIONS")

## Organize the results
do.call('rbind', API.call$FaceDetails[[1]]$Emotions)

# Initialize Python

### install.packages("reticulate")
library(reticulate)
install_python('3.8.10')
use_python_version('3.8.10')
virtualenv_create('r-py-feat', python='3.8.10')
virtualenv_install("r-py-feat", "py-feat")

# Run Py-feat
use_virtualenv("r-py-feat")

feat <- import("feat")
detector <- feat$Detector()

res <- detector$detect_image("myimagefolder/image_000002.jpeg")

## Get emotion estimates
res[,c("anger", "disgust", "fear", "happiness", "sadness", "surprise", "neutral")]

## Get AU estimates
do.call('rbind', res[, names(res)[substr(names(res), 1, 2)=='AU']])















