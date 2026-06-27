#!/usr/bin/env python3
"""双栈 TCP 转发器：同时监听 IPv4 和 IPv6，转发到后端"""
import socket
import threading
import sys

BACKEND_HOST = "127.0.0.1"
BACKEND_PORT = 8888  # 后端实际端口

def forward(src, dst):
    try:
        while True:
            data = src.recv(4096)
            if not data:
                break
            dst.sendall(data)
    except:
        pass
    finally:
        src.close()
        dst.close()

# 创建双栈 IPv4 socket
s4 = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s4.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s4.bind(("0.0.0.0", 9119))
s4.listen(128)

# 创建 IPv6 socket
s6 = socket.socket(socket.AF_INET6, socket.SOCK_STREAM)
s6.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s6.setsockopt(socket.IPPROTO_IPV6, socket.IPV6_V6ONLY, 1)
s6.bind(("::", 9119))
s6.listen(128)

print(f"Dual-stack proxy listening on 0.0.0.0:9119 and [::]:9119 -> {BACKEND_HOST}:{BACKEND_PORT}")

while True:
    conn, addr = s4.accept()
    backend = socket.create_connection((BACKEND_HOST, BACKEND_PORT))
    threading.Thread(target=forward, args=(conn, backend), daemon=True).start()
    threading.Thread(target=forward, args=(backend, conn), daemon=True).start()
