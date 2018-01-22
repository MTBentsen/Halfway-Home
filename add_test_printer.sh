#!/bin/bash
lpadmin -x test-printer -E
lpadmin -d test-printer
lpstat -d
