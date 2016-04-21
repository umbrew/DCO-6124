# Invalid data read from synchronously replicated hot standby

This repository contains a minimal reproduce of the [Invalid data read from synchronously replicated hot standby](http://www.postgresql.org/message-id/OF432D0315.B1FA563D-ONC1257F9C.002AC170-C1257F9C.002C6CD1@schneider-electric.com) issue.

## Setup

- Install [Ansible](https://docs.ansible.com/ansible/intro_installation.html) (2.0.2.0 at the time of writing).
- Install [Vagrant](https://www.vagrantup.com/downloads.html) (1.8.1 at the time of writing).
- Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (5.0.18 at the time of writing).

## Run

- `vagrant up`

The nodes can be accessed by username `root` and password `puppet`.

## Links

- [PostgreSQL inquiry](http://www.postgresql.org/message-id/OF432D0315.B1FA563D-ONC1257F9C.002AC170-C1257F9C.002C6CD1@schneider-electric.com)
- [Problem description](https://docs.google.com/document/d/1MuX8rq1gKw_WZ-HVflqxFslvXNTRGKa77A4NHto4ue0/edit?usp=sharing)
