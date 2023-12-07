#include "headers.p4"

parser MyParser(packet_in packet,
                out headers hdr,
                inout metadata meta,
                inout standard_metadata_t standard_metadata) {
    
    /*Add the start state below*/
    
    state start {
     transition parse_ethernet;
    }

    /*Add the parse_ethernet state below*/
    state parse_ethernet { 
    packet.extract(hdr.ethernet); 
        transition select(hdr.ethernet.etherType) { 
        TYPE_IPV4: parse_ipv4;
        TYPE_IPV6: parse_ipv6;
        default: accept; 
        } 
    }
    
    /*Add the parse_ipv4 state below*/

    state parse_ipv4 {
        packet.extract(hdr.ipv4);
        transition accept;
    }
    
    /*Add the parse_ipv6 state below*/
    state parse_ipv6 {
        packet.extract(hdr.ipv6);
        transition accept;
    }
    
}
