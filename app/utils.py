import time
import subprocess

#from app import app, UPLOAD_FOLDER
import os
import zipfile
import pexpect

#ALLOWED_EXTENSIONS = {'rar', 'tar.gz', 'png', 'jpg', 'jpeg', 'gif', 'pdf', 'zip'}


#    def allowed_file(filetype):
#        for allowed_ext in ALLOWED_EXTENSIONS:
#            if allowed_ext in filetype.lower():
#                return True
#        return False

def execute_process():
    my_path = os.path.abspath(os.path.dirname(__file__))
    UPLOAD_FOLDER = os.path.abspath(os.path.join(my_path, '../uploads'))
    entry = os.listdir(UPLOAD_FOLDER)
    zipped_file_path = UPLOAD_FOLDER + '/' + entry[0]
    FILE_NAME = os.path.splitext(entry[0])[0]
    UNZIPPED_FILE_PATH = UPLOAD_FOLDER + '/' + FILE_NAME
    #print(UPLOAD_FOLDER)
    


    unzip_folder(zipped_file_path,UPLOAD_FOLDER)

    # docker_file_path = get_docker_file_path(UNZIPPED_FILE_PATH)

    # building the docker image for the unzipped codebase
    build_docker_image(UNZIPPED_FILE_PATH)

    # pushing the docker image to the portus
    push_docker_image_to_portus()

    #time.sleep(20)
    build_cluster_and_deployment(UPLOAD_FOLDER)
    # deleting the resources
    #delete_resources()

    # deleting the files present inside the uploads folder
    #delete_uploads(UNZIPPED_FILE_PATH)


def unzip_folder(zipped_file_path,UPLOAD_FOLDER):
    print("=====================================================================")
    print("Unzipping the uploaded Codebase ...")
    print("---------------------------------------------------------------------")
    with zipfile.ZipFile(zipped_file_path, 'r') as zip_ref:
        zip_ref.extractall(UPLOAD_FOLDER + '/')
    print("Unzipping of the uploaded codebase was successful!!")
    time.sleep(20)


def get_docker_file_path(UNZIPPED_FILE_PATH):
    docker_file_path = ''

    # r=>root, d=>directories, f=>files
    for r, d, f in os.walk(UNZIPPED_FILE_PATH):
        for item in f:
            if 'Dockerfile' in item:
                docker_file_path = os.path.join(r, item)
                break

    print("Dockerfile path: {}".format(docker_file_path))
    return docker_file_path



def build_docker_image(UNZIPPED_FILE_PATH):
    print("=====================================================================")
    print("Started building Docker image ...")
    print("---------------------------------------------------------------------")
    os.chdir(UNZIPPED_FILE_PATH)
    subprocess.call(["docker", "build", "-t", "myapp:latest", "."])
    print("---------------------------------------------------------------------")
    print("Docker image built successfully!!")

def push_docker_image_to_portus():
    print("=====================================================================")
    print("Started pushing the images to the portus ...")
    print("---------------------------------------------------------------------")
    subprocess.call(["docker", "login", "portus.hashedin.com"])
    subprocess.call(["docker", "tag", "myapp:latest", "portus.hashedin.com/shubham.pal/myapp:latest"])
    subprocess.call(["docker", "push", "portus.hashedin.com/shubham.pal/myapp:latest"])
    print("---------------------------------------------------------------------")
    print("Image pushed to portus successully!!")

def build_cluster_and_deployment(UPLOAD_FOLDER):
    print("=====================================================================")
    print("Started creating cluster on EKS, it will take time")
    print("---------------------------------------------------------------------")
    terraform_directory=os.path.abspath(os.path.join(UPLOAD_FOLDER, '../ku8e-terraform/environment/Prod/'))
    os.chdir(terraform_directory)
    subprocess.call(["terraform", "init"])
    child = pexpect.spawn('terraform apply')
    print(child.read())
    try:
        child.expect('Enter a value:')
        child.sendline('yes')
    except:
        pass
    
    print("---------------------------------------------------------------------")
    print("cluster created successully!!")
    print("=====================================================================")


    print("Started deployment on EKS, it will take time")
    print("---------------------------------------------------------------------")
    deployment_directory=os.path.abspath(os.path.join(terraform_directory, '../../modules/Deployment/'))
    os.chdir(deployment_directory)
    subprocess.call(["terraform", "init"])
    child = pexpect.spawn(["terraform apply"])
    try:
        child.expect('Enter a value:')
        child.sendline('yes')
    except:
        pass
    print("---------------------------------------------------------------------")
    print("Deployment created successully!!")



def delete_resources():
    print("=====================================================================")
    print("Deleting images ...")
    print("---------------------------------------------------------------------")
    subprocess.call(["docker", "rmi", "myapp:latest"])
    print("---------------------------------------------------------------------")
    print("Image deleted successfully!!")


def delete_uploads(UNZIPPED_FILE_PATH):
    print("=====================================================================")
    file_name = UNZIPPED_FILE_PATH.split('/')
    os.chdir(UPLOAD_FOLDER)

    print("Currently inside the directory: ")
    subprocess.call("pwd")
    print("Deleting the uploaded codebase ...")
    print("---------------------------------------------------------------------")

    # Deleting the uploaded zipped codebase file
    subprocess.call(["rm", file_name[-1] + ".zip"])

    # Deleting the unzipped codebase
    subprocess.call(["rm", "-r", file_name[-1]])

    print("Zipped and unzipped codebase deleted successfully!!")

execute_process()