#!/opt/bin/astra

sat_mx1 = dvb_tune({
    name = "sat_mx1",
    type = "S2",
    adapter = 0,
    tp = "12576:H:14990",
    lnb = "9750:10600:11700",
    modulation="PSK8",
    log_signal = 1,
    raw_signal=0
})

plp0 = make_t2mi_decap({
            name = "PLP 0",
            input = "dvb://sat_mx1",
            plp = 0, -- optional, defaults to first PLP listed in L1
            pnr = 0, -- optional, PNR containing T2-MI payload
            pid = 4096, -- optional, force payload pid
        })

plp1 = make_t2mi_decap({
            name = "PLP 1",
            input = "dvb://sat_mx1",
            plp = 1, -- optional, defaults to first PLP listed in L1
            pnr = 0, -- optional, PNR containing T2-MI payload
            pid = 4096, -- optional, force payload pid
        })

plp2 = make_t2mi_decap({
            name = "PLP 2",
            input = "dvb://sat_mx1",
            plp = 2, -- optional, defaults to first PLP listed in L1
            pnr = 0, -- optional, PNR containing T2-MI payload
            pid = 4096, -- optional, force payload pid
        })

make_channel({
    name = "ПЕРВЫЙ КАНАЛ",
    input = {
        "t2mi://plp0#pnr=1010"
    },
    output = {
        "http://0.0.0.0:1010"
    }
})

make_channel({
    name = "РОССИЯ 1",
    input = {
        "t2mi://plp1#pnr=1020"
    },
    output = {
        "http://0.0.0.0:1020"
    }
})

make_channel({
    name = "МАТЧ",
    input = {
        "t2mi://plp0#pnr=1030"
    },
    output = {
        "http://0.0.0.0:1030"
    }
})

make_channel({
    name = "НТВ",
    input = {
        "t2mi://plp0#pnr=1040"
    },
    output = {
        "http://0.0.0.0:1040"
    }
})

make_channel({
    name = "5 КАНАЛ",
    input = {
        "t2mi://plp0#pnr=1050"
    },
    output = {
        "http://0.0.0.0:1050"
    }
})

make_channel({
    name = "КУЛЬТУРА",
    input = {
        "t2mi://plp0#pnr=1060"
    },
    output = {
        "http://0.0.0.0:1060"
    }
})

make_channel({
    name = "РОССИЯ 24",
    input = {
        "t2mi://plp2#pnr=1070"
    },
    output = {
        "http://0.0.0.0:1070"
    }
})

make_channel({
    name = "КАРУСЕЛЬ",
    input = {
        "t2mi://plp0#pnr=1080"
    },
    output = {
        "http://0.0.0.0:1080"
    }
})

make_channel({
    name = "ОТР",
    input = {
        "t2mi://plp0#pnr=1090"
    },
    output = {
        "http://0.0.0.0:1090"
    }
})

make_channel({
    name = "ТВЦентр",
    input = {
        "t2mi://plp0#pnr=1100"
    },
    output = {
        "http://0.0.0.0:1100"
    }
})

make_channel({
    name = "ВЕСТИ ФМ",
    input = {
        "t2mi://plp0#pnr=1110"
    },
    output = {
        "http://0.0.0.0:1110"
    }
})

make_channel({
    name = "МАЯК",
    input = {
        "t2mi://plp0#pnr=1120"
    },
    output = {
        "http://0.0.0.0:1120"
    }
})

make_channel({
    name = "РАДИО РОССИИ",
    input = {
        "t2mi://plp1#pnr=1130"
    },
    output = {
        "http://0.0.0.0:1130"
    }
})
