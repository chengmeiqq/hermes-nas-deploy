#!/bin/bash
exec python3 -c "
import socket, threading, sys
BACKEND = '127.0.0.1'
BPORT = 9119
s = socket.socket(socket.AF_INET6, socket.SOCK_STREAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.setsockopt(socket.IPPROTO_IPV6, socket.IPV6_V6ONLY, 1)
s.bind(('::', 9119))
s.listen(128)
print(f'IPv6 proxy listening on [::]:9119 -> {BACKEND}:{BPORT}')
sys.stdout.flush()
def forward(src, dst):
    try:
        while True:
            d = src.recv(8192)
            if not d: break
            dst.sendall(d)
    finally:
        try: src.close()
        except: pass
        try: dst.close()
        except: pass
while True:
    conn, addr = s.accept()
    try:
        backend = socket.create_connection((BACKEND, BPORT))
        threading.Thread(target=forward, args=(conn, backend), daemon=True).start()
        threading.Thread(target=forward, args=(backend, conn), daemon=True).start()
    except:
        conn.close()
"
