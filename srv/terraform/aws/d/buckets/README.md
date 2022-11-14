#### Create Test Buckets

        cd ~
        rm -fr auto5/
        git clone https://github.com/pedroAkiraDanno/auto5.git
        cd auto5/srv/terraform/aws/


        cd ~
        cd auto5/srv/terraform/aws/d/buckets/3

        terraform init
        terraform plan
        //terraform apply
        terraform apply -auto-approve

        //terraform destroy -auto-approve

#### LIST BUCKET AWS:

        https://stackoverflow.com/questions/3337912/quick-way-to-list-all-files-in-amazon-s3-bucket

        aws s3 ls

#### DELETE AWS S3 BUCKET:

        aws s3 rb <bucket URI> --recursive
        aws s3 rb s3://<bucket URI>
        aws s3 rb s3://s3bucket-1068736247

        https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/delete-bucket.html


        aws s3 rb s3://bucket-name --force

        https://lepczynski.it/en/aws_en/5-ways-to-remove-aws-s3-bucket/

        https://docs.aws.amazon.com/AmazonS3/latest/userguide/delete-bucket.html

## REFERENCES:

    https://lepczynski.it/en/aws_en/5-ways-to-remove-aws-s3-bucket/

    https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/delete-bucket.html

    https://linuxhint.com/delete-s3-bucket-aws-cli/

    https://stackoverflow.com/questions/3337912/quick-way-to-list-all-files-in-amazon-s3-bucket

    aws s3 ls

    https://www.youtube.com/watch?v=3XodvoBUDHw
