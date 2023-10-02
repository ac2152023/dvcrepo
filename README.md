**Objectives for this demo:**
- Keep the data  on Google Cloud Bucket, use GitHub private repos inside docker container
- Use DVC to version dataset (we are going to do only 1 version, easy optional HW: add more versions and verify)
- Assumption: You are familiar with previous DVC tutorial covered in class

**Steps:**

0) Google cloud bucket with a loaded dataset mushroom dataset
1) Create a GitHub private repo to keep track of dataset versions
2) Create a VM
   
  2a) Install docker on VM 

```
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

sudo docker run hello-world

```
  2b) Install git 
  `sudo apt-get install git`

  2b.0) Set up git SSH on the VM
  `ssh-keygen -t ed25519 -C "youremail@gmail.com"`  (Press enter for all 3 questions) 

  Your public key is located in `cat /home/<name>/.ssh/id_ed25519.pub` (Copy contents of this file on to clipboard)
  Go to -> GitHub.com -> Settings (top right under your pfp)  -> SSH and GPG keys (left) -> New SSH key -> give any title -> copy contents in key -> Add SSH Key  (please login again when asked) 

3) Copy following files from [https://github.com/ac2152023/dvcrepo](https://github.com/ac2152023/dvcrepo) to your private repo
```
Dockerfile
Pipfile
Pipfile.lock
docker-entrypoint.sh
docker-shell.sh
.gitignore
```

4) `git clone git@github.com:rashmibanthia/<privaterepo>.git`

5) Upload your secrets to secrets folder , check entries in docker-entrypoint.sh, docker-shell.sh 

6) sudo sh docker-shell.sh

7) DVC
```   
mkdir mushdvc
gcsfuse mushdvc mushdvc/
dvc init
dvc remote add -d mushdvc gs://mushdvc/dvc_store
dvc add mushdvc  
dvc push

git status
git add .
git commit -m 'dataset updates...'
git tag -a 'dataset_v1' -m 'tag dataset'
git push --atomic origin main dataset_v1
```
🎉🎉🎉
You should see tagged dataset on your private repo and also dvc_store on google cloud bucket. 

--- 

Anothe way to do DVC - https://dvc.org/doc/user-guide/data-management/importing-external-data  (I haven’t compared the differences)
