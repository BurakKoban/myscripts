# To install HCP Vault Secrets

brew tap hashicorp/tap
brew install vlt

# To login to your HCP account

vlt login

# To sync with your secrets on your HCP accounts

vlt config init

# To use your secrets

vlt secrets

#  Name                Latest Version  Created At                
#  root_user_email     1               2023-06-20T21:06:33.304Z  
#  root_user_password  1               2023-06-20T21:06:51.545Z  

vlt secrets get username

#  Name             Value             Latest Version  Created At                
#  root_user_email  ****************  1               2023-06-20T21:06:33.304Z  

vlt secrets get --format json username | jq

#  {
  #  "created_at": "2023-06-20T21:06:33.304Z",
  #  "created_by": {
    #  "email": "burakkoban@gmail.com",
    #  "name": "burakkoban@gmail.com",
    #  "type": "TYPE_USER"
  #  },
  #  "latest_version": "1",
  #  "name": "root_user_email",
  #  "version": {
    #  "created_at": "2023-06-20T21:06:33.304Z",
    #  "created_by": {
      #  "email": "burakkoban@gmail.com",
      #  "name": "burakkoban@gmail.com",
      #  "type": "TYPE_USER"
    #  },
    #  "type": "kv",
    #  "version": "1"
  #  }
#  }

vlt secrets get --format json root_user_email | jq -r .created_by.email

# burakkoban@gmail.com

vlt secrets get --plaintext root_user_email

# burakkoban@gmail.com
