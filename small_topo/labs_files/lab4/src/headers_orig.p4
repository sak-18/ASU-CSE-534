const bit<16> TYPE_IPV4 = 0x800;
#define MAX_HOPS 10
/*************************************************************************
*********************** H E A D E R S  ***********************************
*************************************************************************/

typedef bit<9>  egressSpec_t;
typedef bit<48> macAddr_t;
typedef bit<32> ip4Addr_t;
typedef bit<32> switchID_t;
typedef bit<32> qdepth_t;



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

//
header ipv4_option_t {
    bit<1> copyFlag;
    bit<2> optClass;
    bit<5> option;
    bit<8> optionLength;
}

//
struct ingress_metadata_t {
    bit<16>  count;
}

//
struct parser_metadata_t {
    bit<16>  remaining;
}

//
header mri_t {
    bit<16>  count;
}

//
header switch_t {
    switchID_t  swid;
    qdepth_t    qdepth;
}

//
struct metadata{
    ingress_metadata_t   ingress_metadata;
    parser_metadata_t   parser_metadata;
}

struct headers {
    ethernet_t   ethernet;
    ipv4_t       ipv4;
    mri_t        mri;//
    switch_t[MAX_HOPS] swtraces;//
}
