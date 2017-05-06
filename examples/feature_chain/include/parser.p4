/*
* Parse all possible header fields.
*/

#define ETH_TYPE_IPv4 0x0800
#define IP_PROTO_TCP 6

parser start {
    set_metadata(meta.packet_category, UNKNOWN_PACKET);
    return parse_ethernet;
}

parser parse_ethernet {
    extract(ethernet);
    return select(ethernet.eth_type) {
        ETH_TYPE_IPv4 : parse_ipv4;
        default : ingress;
    }
}

parser parse_ipv4 {
    extract(ipv4);
    return select(ipv4.proto) {
        IP_PROTO_TCP : parse_tcp;
        default : ingress;
    }
}

parser parse_tcp {
    extract(tcp);
    return ingress;
}