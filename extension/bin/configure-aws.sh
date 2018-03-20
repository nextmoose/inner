#!/bin/sh

(
    pass show aws-access-key-id &&
        pass show aws-secret-access-key &&
        echo us-east-1 &&
        echo text
) | aws configure 