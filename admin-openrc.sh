sudo nano /root/admin-openrc.sh
════════════════════<>════════════════════
export OS_PROJECT_DOMAIN_NAME=Default
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_NAME=admin
export OS_USERNAME=admin
export OS_PASSWORD=ADMIN_PASS
export OS_AUTH_URL=http://206.162.244.147:5000/v3
export OS_IDENTITY_API_VERSION=3
export OS_IMAGE_API_VERSION=2
export OS_REGION_NAME=RegionOne

════════════════════<>════════════════════
ফাইল লোড করা:
source /root/admin-openrc.sh

════════════════════<>════════════════════
OpenStack কমান্ড টেস্ট:
# A) openrc দিয়ে
source /root/admin-openrc.sh
openstack token issue

# B) এক শটে (openrc ছাড়াই)
openstack --os-username admin --os-password ADMIN_PASS \
--os-project-name admin --os-auth-url http://206.162.244.147:5000/v3 \
--os-user-domain-name Default --os-project-domain-name Default \
token issue

<!--যদি টোকেন দেখায়, তাহলে authentication ঠিকঠাক হয়েছে।-->

════════════════════<>════════════════════
এখন Placement user বানাও:
openstack user create --domain default --password ADMIN_PASS placement
openstack role add --project service --user placement admin

openstack service create --name placement --description "Placement API" placement

openstack endpoint create --region RegionOne placement public http://206.162.244.147:8778
openstack endpoint create --region RegionOne placement internal http://206.162.244.147:8778
openstack endpoint create --region RegionOne placement admin http://206.162.244.147:8778

════════════════════<>════════════════════
