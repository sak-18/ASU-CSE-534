const bit<8>  UDP_PROTOCOL = 0x11;
const bit<16> TYPE_IPV4 = 0x800;
const bit<5>  IPV4_OPTION_MRI = 31;

#define MAX_HOPS 9

typedef bit<9>  egressSpec_t;
typedef bit<48> macAddr_t;
typedef bit<32> ip4Addr_t;
typedef bit<32> switchID_t;
typedef bit<32> qdepth_t;
typedef bit<32>  ingress_port_t;
typedef bit<9>  egress_spec_t;
typedef bit<32>  egress_port_t;
typedef bit<32> clone_spec_t;
typedef bit<32> instance_type_t;
typedef bit<1>  drop_t;
typedef bit<16> recirculate_port_t;
typedef bit<32> packet_length_t;
typedef bit<32> enq_timestamp_t;
typedef bit<19> enq_qdepth_t;
typedef bit<32> deq_timedelta_t;
typedef bit<19> deq_qdepth_t;
typedef bit<48> ingress_global_timestamp_t;
typedef bit<32> lf_field_list_t;
typedef bit<16> mcast_grp_t;
typedef bit<1>  resubmit_flag_t;
typedef bit<16> egress_rid_t;
typedef bit<1>  checksum_error_t;

header ethernet_t {
    macAddr_t dstAddr;
    macAddr_t srcAddr;
    bit<16>   etherType;
}

header ipv4_t {
    bit<4>    version;
    bit<4>    ihl;
    bit<8>    diffserv;
    bit<16>   totalLen;
    bit<16>   identification;
    bit<3>    flags;
    bit<13>   fragOffset;
    bit<8>    ttl;
    bit<8>    protocol;
    bit<16>   hdrChecksum;
    ip4Addr_t srcAddr;
    ip4Addr_t dstAddr;
}

header ipv4_option_t {
    bit<1> copyFlag;
    bit<2> optClass;
    bit<5> option;
    bit<8> optionLength;
}

header mri_t {
    bit<16>  count;
}

header switch_t {
    ingress_port_t ingress_port;
    egress_port_t egress_port; 
}

struct ingress_metadata_t {
    bit<16>  count;
}

struct parser_metadata_t {
    bit<16>  remaining;
}

struct metadata {
    ingress_metadata_t   ingress_metadata;
    parser_metadata_t   parser_metadata;
}

struct headers {
    ethernet_t         ethernet;
    ipv4_t             ipv4;
    ipv4_option_t      ipv4_option;
    mri_t              mri;
    switch_t[MAX_HOPS] swtraces;
}

error { IPHeaderTooShort }