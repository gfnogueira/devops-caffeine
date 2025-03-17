from diagrams import Diagram, Cluster
from diagrams.aws.compute import ElasticKubernetesService
from diagrams.aws.database import RDSMysqlInstance
from diagrams.aws.network import PrivateSubnet, NATGateway
from diagrams.aws.security import IAMRole

with Diagram("EKS Private Network with RDS", show=False):
    with Cluster("Private Subnet"):
        eks = ElasticKubernetesService("EKS Cluster")
        
        # Criando os serviços dentro do EKS
        service1 = ElasticKubernetesService("Service 1")
        service2 = ElasticKubernetesService("Service 2")
        service3 = ElasticKubernetesService("Service 3")
        
        # Criando as instâncias RDS
        rds1 = RDSMysqlInstance("RDS MySQL 1")
        rds2 = RDSMysqlInstance("RDS MySQL 2")
        rds3 = RDSMysqlInstance("RDS MySQL 3")

        # Criando os papéis de IAM
        role1 = IAMRole("IAM Role 1")
        role2 = IAMRole("IAM Role 2")
        role3 = IAMRole("IAM Role 3")

        # Conectando os serviços ao RDS via rede privada
        service1 >> rds1
        service2 >> rds2
        service3 >> rds3

        # Associando os serviços aos papéis IAM
        role1 >> service1
        role2 >> service2
        role3 >> service3

    # Representação da VPC e NAT Gateway para saída privada
    vpc = PrivateSubnet("Private Subnet")
    nat = NATGateway("NAT Gateway")

    eks >> vpc
    vpc >> nat