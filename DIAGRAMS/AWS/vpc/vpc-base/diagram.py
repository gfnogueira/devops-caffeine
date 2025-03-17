from diagrams import Diagram, Cluster
from diagrams.aws.network import VPC, PrivateSubnet, PublicSubnet, VpnGateway, NATGateway, InternetGateway

with Diagram("VPC Base with VPN and Subnets", show=False, direction="TB"):
    with Cluster("AWS VPC 172.x.x.x/16"):
        vpn_gw = VpnGateway("VPN Gateway")  # ✅ Correção aqui
        igw = InternetGateway("Internet Gateway")

        with Cluster("Public Subnets (A-F)"):
            pub_a = PublicSubnet("Public A (/24)")
            pub_b = PublicSubnet("Public B (/24)")
            pub_c = PublicSubnet("Public C (/24)")
            pub_d = PublicSubnet("Public D (/24)")
            pub_e = PublicSubnet("Public E (/24)")
            pub_f = PublicSubnet("Public F (/24)")

        with Cluster("Private Subnets (A-F)"):
            priv_a = PrivateSubnet("Private A (/24)")
            priv_b = PrivateSubnet("Private B (/24)")
            priv_c = PrivateSubnet("Private C (/24)")
            priv_d = PrivateSubnet("Private D (/24)")
            priv_e = PrivateSubnet("Private E (/24)")
            priv_f = PrivateSubnet("Private F (/24)")

        nat_gw = NATGateway("NAT Gateway")

        # Conexões
        vpn_gw >> igw >> [pub_a, pub_b, pub_c, pub_d, pub_e, pub_f]
        nat_gw >> [priv_a, priv_b, priv_c, priv_d, priv_e, priv_f]