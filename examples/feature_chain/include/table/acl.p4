/**
* Permit or deny packets according to header fields
*/

action acl_mark() {
   modify_field(meta.packet_category, DENIED_PACKET);
}

table ipv4_tcp_acl {
    reads {
        standard_metadata.ingress_port : exact;
        ipv4.src_addr : ternary;
        ipv4.dst_addr : ternary;
        tcp.src_port  : ternary;
        tcp.dst_port  : ternary;
        tcp.flags     : ternary;
    }
    actions {
        nop;
        acl_mark;
    }
}
