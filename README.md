# Assignment: Cloud Platorm Engineer

## Focus on Platform / Infrastructure

### Architecture
_Design an architecture that allows us to collect, process and analyze data from our taxi operation as well as send data back to individual cars_:

Designed was an archtecture with 3 instances of Storage that is layered into raw, enriched and curated. The data will be gathered through an IoT Hub sending the raw data into the first data layer (raw) but also to an Stream Analytics for stream processing. This stream processing writes near-realtime data to third (curated) layer and streaming capable tools like Power BI. In Addition Databricks will run scheduled batch processing jobs cleaning/filtering/augmenting the raw data into the second (enriched) layer and ready-to-consumption data into third (curated) layer. Applications like Power BI or other service can consume both near-realtime and batch data and create a merged view. App Services can use the data and send back data to the IoT device over the Hub.

![alt.text](arch.jpg "Architecture Data-Platform")

### Automation
_Develop a script to automate the setup and maintenance of your architecture. It’s ok if it’s only parts of it or 2-3 components and not the whole architecture. We should be able to rollout the components but also update the whole or individual parts_:

Terraform was chosen for this task. Terraform lets you create new resources as well as update the existing ones by checking stored states. 
Developed was a pipeline template for Azure DevOps. The pipeline is a .yaml file containing terraform script. The pipeline only contains: 
- 1 IoT Hub
- 1 Storage Account
- 1 Databricks
- 1 Stream Analytics Cluster (40min creation time)

The pipeline requires an storage account allowing to save terraform states in it. Variables to set for the pipelines are:
- tf-resourcegroup: 
  Resourcegroup where the resources are located needed by terraform.
- tf-storage-account: 
  Storage account which terraform is allowed to operate on. 
- tf-storage-account-key:
  Storage account key to authorize terraform.
- service_connection
  Service principal which terraform can use to create and destroy azure resources.

##### Pipeline
```
pipelines/dataplatform-build.yaml
```

### Data Exfiltration and Infiltration
_Think about how to secure the data we are collecting for this use case and the platorm in general. What tools and approaches can be used to minimize the risk of unwanted Data Exfiltration or Data Infiltration_:

As a first step towards more security in general the access to the platform (or resources) should be made private so there is no public access except the necessary traffic from the IoT devices. The resources can be separated into different virtual networks allowing communication only via private endpoints between the services. This enables allowing/blocking ip ranges.  

Further the appraoch of least privilege should be followed. Creating service principals that are scoped to only those action the different services need to operate.

Using services that provide security features. E.g. using Azure IoT-Hub which provide "Per-device identity" to enable verification per device. 


### Vision
_Create a vision for the future of our taxi company data platorm, what are going to be important pillars and elements that we should focus on in the next 2-3 years_:

With more customers getting data from that plattform it is important to have something like role-based-access-control on the data. It should be controlled who is authorized to read/write which data. So in case of manipulation or data loss we can track down who had access and the authority to do this. 

A common problem when working with data scientists are requests to data. While security rules follwing the least priviledge approach data scientists often want to explore which data does exist and which data they can use. So building something like an data catalog for customers could be an important feature and would speed up the process of handling data requests. 

Another important step could be the possibility of tracking down dataflows and further the truth of the data. Serving thousands of usecases it`s necessary to be able to see where the data comes from and which data should be used for the usecases. This would also counteract the duplication of data keeping the platform clean and efficient.

With machine learning and artificial intelligence gaining more and more importance it could be also a next step to prepare for those usecases. E.g. a feature store is essential for machine learning but also the need of versioned data is important and maybe the integration of those technologies into the data-platform is an important pillar.
