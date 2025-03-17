from diagrams import Diagram, Cluster
from diagrams.aws.security import IAM, IAMRole
from diagrams.aws.management import Organizations
from diagrams.aws.compute import EC2
from diagrams.aws.general import Users

with Diagram("AWS IAM Cross-Account AssumeRole", show=False, direction="TB"):
    
    # AWS Accounts
    with Cluster("AWS Organizations"):
        account_a = Organizations("Account A (Main)")
        account_b = Organizations("Account B (Dev)")
        account_c = Organizations("Account C (Support)")
    
    # IAM Users
    admin_user = Users("Admin User")
    dev_user = Users("Dev User")
    support_user = Users("Support User")
    
    # IAM Roles
    admin_role = IAMRole("AdminRole")
    dev_role = IAMRole("DevRole")
    support_role = IAMRole("SupportRole")
    
    # EC2 Instances in target accounts
    with Cluster("Account B (Dev)"):
        dev_instance = EC2("EC2 Instance - Dev")
    
    with Cluster("Account C (Support)"):
        support_instance = EC2("EC2 Instance - Support")
    
    # Relationships and AssumeRole Connections
    admin_user >> IAM("AssumeRole") >> admin_role
    dev_user >> IAM("AssumeRole") >> dev_role
    support_user >> IAM("AssumeRole") >> support_role
    
    admin_role >> IAM("AssumeRole") >> account_b
    dev_role >> dev_instance
    support_role >> support_instance
