
output "subnet_cidr"{
  value = aws_subnet.pub_subnet.cidr_block
}


output "pubroute_id"{
  value = aws_route_table.pubroute.id
}
output "prvroute_id"{
  value = aws_route_table.prvroute.id
}
output "subnet_pub_id_output"{
  value = aws_subnet.pub_subnet.id
}
output "subnet_prv_id_output"{
   value = aws_subnet.prv_subnet.id
}
output "igw_out"{
  value = aws_internet_gateway.IGW.id
}
output "vpc_info"{
   value = aws_vpc.P_vpc.id
}
output "aws_redshift_subnet_group_name"{
    value= aws_redshift_subnet_group.redshift_subnet_group.id
}