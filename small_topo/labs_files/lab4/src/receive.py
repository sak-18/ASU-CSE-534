#!/usr/bin/env python3
import sys

from scapy.all import (
    FieldLenField,
    IntField,
    IPOption,
    Packet,
    PacketListField,
    ShortField,
    get_if_list,
    sniff
)
from scapy.layers.inet import _IPOption_HDR


def get_if():
    ifs=get_if_list()
    iface=None
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

def handle_pkt(pkt):
    print("got a packet")
    pkt.show2()
#    hexdump(pkt)
    sys.stdout.flush()


def main():
    iface = 'enp7s0'
    print("sniffing on %s" % iface)
    sys.stdout.flush()
    #sniff(filter="udp and port 4321", iface = iface,
    #      prn = lambda x: handle_pkt(x))
    sniff(filter="tcp", iface = iface, prn = lambda x: handle_pkt(x))
    

if __name__ == '__main__':
    main()
