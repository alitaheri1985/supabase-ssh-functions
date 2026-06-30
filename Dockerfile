FROM supabase/edge-runtime:v1.74.0

# 1. Install supervisor and ssh-server
USER root
RUN apt-get update && apt-get install -y \
    supervisor \
    openssh-server \
    vim \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

# 2. Prepare SSH directories
RUN mkdir -p /var/run/sshd /root/.ssh /var/log/supervisor \
    && ssh-keygen -A \
    && chmod 700 /root/ \
    && chmod 700 /root/.ssh

# 3. Create Deno cache and functions directories with full permissions
RUN mkdir -p /root/.cache /home/deno/.cache /home/deno/functions \
    && chmod -R 777 /root/.cache /home/deno/.cache /home/deno/functions



# 4. Copy public key for SSH access
COPY id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# 5. Copy supervisor config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 6. Copy default Main Router function (CRITICAL FIX)
COPY index.ts /home/deno/functions/main/index.ts

# 7. Reset entrypoint (CRITICAL FIX)
ENTRYPOINT []

# 8. Expose ports
EXPOSE 22 9999

# 9. Start supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]