---
- hosts: all
  remote_user: ${admin_user}
  become: true
  roles:
    - common

- hosts: web_hosts
  remote_user: ${admin_user}
  become: true
  roles:
   - web

- hosts: app_hosts
  remote_user: ${admin_user}
  become: true
  roles:
   - app
