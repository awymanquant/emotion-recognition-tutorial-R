This is a companion GitHub page for the paper titled, "A Tutorial on the Use of Artificial Intelligence Tools for Facial Emotion Recognition in R". It primarily serves to include details about the tutorial that could not be included within the paper itself. That includes the sample video from the RAVDESS data set, which is featured in the paper, sample code for easy copy-and-paste, and other illustrative examples that may help with the installation and initialization of software. If any code or tutorial instructions are not working/up-to-date, feel free to let us know under the issues column. Thank you!

# Use Google Cloud

## Enable the API

To use Google Cloud, we need to set up the API services. Here is a brief tutorial on how to do it based on enabling and using the Google Cloud Vision.

1. To start, to to Google Cloud console at [https://console.cloud.google.com/](https://console.cloud.google.com/)

<img src="/_media/classes/rdatascience/screenshot_2024-10-31_at_8.35.46%E2%80%AFpm.png?w=600&amp;tok=7bd68d" class="media" loading="lazy" alt="" width="600" />

2. Click on nd.edu > first project or sth else there and in the popup window to create a new project.

<img src="/_media/classes/rdatascience/screenshot_2024-10-31_at_8.41.12%E2%80%AFpm.png?w=600&amp;tok=2c1707" class="media" loading="lazy" alt="" width="600" />

3. Select the newly created project and then click on "API and Services"

<img src="/_media/classes/rdatascience/screenshot_2024-10-31_at_8.43.36%E2%80%AFpm.png?w=600&amp;tok=5b74db" class="media" loading="lazy" alt="" width="600" />

4. Then click on "+ENABLE APIS AND SERVICES"

<img src="/_media/classes/rdatascience/screenshot_2024-10-31_at_8.45.42%E2%80%AFpm.png?w=600&amp;tok=32d794" class="media" loading="lazy" alt="" width="600" />

5. Select or search for "Cloud Vision API" and enable it.

<img src="/_media/classes/rdatascience/screenshot_2024-10-31_at_8.47.09%E2%80%AFpm.png?w=600&amp;tok=47a0d6" class="media" loading="lazy" alt="" width="600" />

<img src="/_media/classes/rdatascience/screenshot_2024-10-31_at_8.48.32%E2%80%AFpm.png?w=600&amp;tok=469624" class="media" loading="lazy" alt="" width="600" />

6. Click on "Create credentials"

<img src="/_media/classes/rdatascience/screenshot_2024-10-31_at_8.49.52%E2%80%AFpm.png?w=600&amp;tok=35ef73" class="media" loading="lazy" alt="" width="600" />

7. Now create the credentials following each step. 

<img src="/_media/classes/rdatascience/screenshot_2024-10-31_at_8.52.04%E2%80%AFpm.png?w=600&amp;tok=f62487" class="media" loading="lazy" alt="" width="600" />
<img src="/_media/classes/rdatascience/screenshot_2024-10-31_at_8.52.57%E2%80%AFpm.png?w=600&amp;tok=51b4eb" class="media" loading="lazy" alt="" width="600" />

One can specify the scope of the APIs. Here we choose Cloud Vision.

<img src="/_media/classes/rdatascience/screenshot_2024-10-31_at_8.53.40%E2%80%AFpm.png?w=600&amp;tok=1d7024" class="media" loading="lazy" alt="" width="600" />
<img src="/_media/classes/rdatascience/screenshot_2024-10-31_at_8.54.17%E2%80%AFpm.png?w=600&amp;tok=dc440d" class="media" loading="lazy" alt="" width="600" />

Now create the client ID

<img src="/_media/classes/rdatascience/screenshot_2024-10-31_at_8.58.25%E2%80%AFpm.png?w=600&amp;tok=728de1" class="media" loading="lazy" alt="" width="600" />

After it, you can download the ID as a JSON file.

<img src="/_media/classes/rdatascience/screenshot_2024-10-31_at_9.00.50%E2%80%AFpm.png?w=600&amp;tok=b6c747" class="media" loading="lazy" alt="" width="600" />

Click on "Done" to complete it.

## Authenticate within R

We now use the R package googleAuthR to authenticate to Google.

1. Load the library (you may need to install it first using `install.packages('googleAuthR')`
2. Specify the scopes to use
3. Set the client ID using `gar_set_client`. `file.choose()` allows you to choose the JSON file you saved earlier. 
4. Then for the use of the first time, use `gar_auth` to authenticate.

```
library(googleAuthR)

# specify the scopes - Google cloud and cloud vision for example.
scopes = c("https://www.googleapis.com/auth/cloud-vision",
           "https://www.googleapis.com/auth/cloud-platform")

# set the client
gar_set_client(file.choose(), scopes = scopes)

# authenticate and go through the OAuth2
gar_auth(email = "xxxx@nd.edu")
```

## Use the Cloud Vision service

```
library(googleCloudVisionR)
API.call <- gcv_get_image_annotations(imagePaths = "calm1.png", feature="FACE_DETECTION")
API.call
```

