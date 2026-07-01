#Following this steps to create your own Docker image
#Get files from repository:

      git clone https://github.com/alitaheri1985/supabase-ssh-functions.git
      cd supabase-ssh-functions

#Modify JWT_SECRET & SUPABASE_URL environment variables.
#In addition deno directory & port if you changed default values in supavisord.conf file.
#Get your Public-key:
      
      cat ~/.ssh/id_ed25519

#Replace public-key in id_rsa.pub file.
#Build and push image to your container registry.

      docker build -t your-container-registry/your-project-name/supabase-edge-ssh:v1 .
      docker push your-container-registry/your-project-name/supabase-edge-ssh:v1

#Finally you can deploy your container

      docker run -d --name ssh-func -e SUPABASE_URL="your_supabase_url"  ANON_KEY="your_anon_key"  SERVICE_ROLE_KEY="your_service_key"\
      your-container-registry/your-project-name/supabase-edge-ssh:v1
