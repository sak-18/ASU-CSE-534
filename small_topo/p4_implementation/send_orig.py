#!/usr/bin/env python3
import argparse
import sys
import socket
import random
import struct
import netifaces as ni
from scapy.all import sendp, send, get_if_list, get_if_hwaddr
from scapy.all import Packet
from scapy.all import Ether, IP, UDP, TCP
from scapy.all import (
    IP,
    UDP,
    Ether,
    FieldLenField,
    IntField,
    IPOption,
    Packet,
    PacketListField,
    ShortField,
    get_if_hwaddr,
    get_if_list,
    sendp
)
from scapy.layers.inet import _IPOption_HDR

def get_if():
    ifs=get_if_list()
    iface=None # "h1-eth0"
    for i in get_if_list():
        if "eth0" in i:
            iface=i
            break;
    if not iface:
        print("Cannot find eth0 interface")
        exit(1)
    return iface

class SwitchTrace(Packet):
    fields_desc = [ IntField("ingress_port", 0),
                  IntField("egress_port", 0)]
                  # IntField("packet_length", 0),
                  # IntField("enq_timestamp", 0),
                  # IntField("enq_qdepth", 0),
                  # IntField("deq_timedelta", 0),
                  # IntField("deq_qdepth", 0),
                  # IntField("ingress_global_timestamp", 0)]
    def extract_padding(self, p):
                return "", p

class IPOption_MRI(IPOption):
    name = "MRI"
    option = 31
    fields_desc = [ _IPOption_HDR,
                    FieldLenField("length", None, fmt="B",
                                  length_of="swtraces",
                                  adjust=lambda pkt,l:l*2+4),
                    ShortField("count", 0),
                    PacketListField("swtraces",
                                   [],
                                   SwitchTrace,
                                   count_from=lambda pkt:(pkt.count*1)) ]

def main():
    if len(sys.argv)<3:
        print('pass 2 arguments: <iface> <src> <destination> "<message>"')
        exit(1)

    iface = str(sys.argv[1]) 
    src_addr = socket.gethostbyname(sys.argv[2])
    dst_addr = socket.gethostbyname(sys.argv[3])
    host_mac_addr =  ni.ifaddresses(iface)[ni.AF_LINK][0]['addr']

    print(("sending on interface %s to %s" % (iface, str(dst_addr))))
    ##pkt =  Ether(src=host_mac_addr, dst='00:00:00:00:00:02')
    ##pkt = pkt /IP(src=src_addr,dst=dst_addr) / TCP(dport=1234, sport=random.randint(49152,65535)) / sys.argv[2]
    
    pkt = Ether(src=get_if_hwaddr(iface), dst="00:00:00:00:00:02") / IP(
    dst=dst_addr, options = IPOption_MRI(count=0,
        swtraces=[])) / TCP(dport=4321, sport=1234) / sys.argv[2]
    
    pkt.show2()
    sendp(pkt, iface=iface, verbose=False)


if __name__ == '__main__':
    main()
