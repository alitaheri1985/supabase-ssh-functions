First of all create your own docker image:

      git clone https://github.com/alitaheri1985/supabase-ssh-functions.git
      cd supabase-ssh-functions

modify  JWT_SECRET & SUPABASE_URL environment variables in supavisord.conf file.
replace your public ssh key in id_rsa.pub file.

      docker build -t your-container-registry/your-project-name/supabase-edge-ssh:v1 .
      docker push your-container-registry/your-project-name/supabase-edge-ssh:v1

finally you can deploy your container

      docker run -d --name ssh-func -e SUPABASE_URL="your_supabase_url"  ANON_KEY="your_anon_key"  SERVICE_ROLE_KEY="your_service_key" your-container-registry/your-project-name/supabase-edge-ssh:v1
