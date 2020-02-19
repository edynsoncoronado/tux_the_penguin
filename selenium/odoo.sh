#!/bin/bash
/usr/bin/Xvfb :10 -ac & /usr/bin/python /home/ubuntu/odoo/odoo.py -c /home/ubuntu/odoo/odoo-server.conf --logfile=/home/ubuntu/odoo/odoo-server.log
