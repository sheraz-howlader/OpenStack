sudo nano /root/admin-openrc.sh


export OS_PROJECT_DOMAIN_NAME=Default
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_NAME=admin
export OS_USERNAME=admin
export OS_PASSWORD=ADMIN_PASS
export OS_AUTH_URL=http://localhost:5000/v3
export OS_IDENTITY_API_VERSION=3
export OS_IMAGE_API_VERSION=2
export OS_REGION_NAME=RegionOne



👉 এখানে
ADMIN_PASS = Keystone bootstrap করার সময় যে admin password দিয়েছিলে।
controller = তোমার controller node এর hostname বা IP (যদি একটিই VPS হয়, তাহলে localhost বা external IP বসাতে পারো)।


ফাইল লোড করা:
source /root/admin-openrc.sh

sudo nano /etc/hosts
শেষে যোগ করো:
127.0.0.1   controller


OpenStack কমান্ড টেস্ট:
openstack token issue
<!--যদি একটি টোকেন দেখায়, তাহলে authentication ঠিকঠাক হয়েছে।-->


এখন Placement user বানাও:
openstack user create --domain default --password ADMIN_PASS placement
openstack role add --project service --user placement admin

openstack service create --name placement --description "Placement API" placement

openstack endpoint create --region RegionOne placement public http://controller:8778
openstack endpoint create --region RegionOne placement internal http://controller:8778
openstack endpoint create --region RegionOne placement admin http://controller:8778

