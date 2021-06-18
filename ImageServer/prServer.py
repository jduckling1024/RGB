import json
import socket, threading, cv2
import numpy as np
# clipping을 위한 서버

def binder(client_socket, addr):
    print('Connected by', addr)
    try:
        data = client_socket.recv(4);
        length = int.from_bytes(data, "little");
        data = client_socket.recv(length)
        data = data.decode()
        # 수신 데이터를 str형태로 decode
        jsonData = json.loads(data)

        names_num = len(jsonData.get("file_names"))

        for i in range(names_num):
            file_name = jsonData.get("file_names")[i]
            clipping(file_name)

    except:
            # 접속이 끊기면 except가 발생한다.
            print("except : ", addr);
    finally:
        client_socket.close();

def clipping(file_name):
    file_npath = "C:\\\\Users\\\\DeepLearning_6\\\\eclipse-workspace\\\\RoomGuideBook\\\\src" \
                 "\\\\main\\\\webapp\\\\resources\\\\"
    file_rpath = file_npath+'image_arrange_bp\\\\'+file_name
    file_wpath = file_npath + 'image_arrange_ap\\\\' + file_name

    image = cv2.imread(file_rpath, cv2.IMREAD_UNCHANGED);  # 투명색 배경 유지
    image_gray = cv2.imread(file_rpath, cv2.IMREAD_GRAYSCALE)  # 흑백이미지

    blur = cv2.GaussianBlur(image_gray, ksize=(5, 5), sigmaX=0)  # 가우시안 블러로 배경, 원치않는 영역을 부드럽게
    edged = cv2.Canny(blur, 10, 250)

    # scv2.imshow('Edges', e    dged)
    kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (7, 7))
    closed = cv2.morphologyEx(edged, cv2.MORPH_CLOSE, kernel)
    cv2.waitKey(0)
    contours, _ = cv2.findContours(closed.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    # contours에 외곽 값들 저장

    contours_xy = np.array(contours)

    x_min, x_max = 0, 0
    y_min, y_max = 0, 0
    value = list()
    for i in range(len(contours_xy)):
        for j in range(len(contours_xy[i])):
            value.append(contours_xy[i][j][0][0])
            x_min = min(value)
            x_max = max(value)

    print(x_min)

    value = list()
    for i in range(len(contours_xy)):
        for j in range(len(contours_xy[i])):
            value.append(contours_xy[i][j][0][1])
            y_min = min(value)
            y_max = max(value)

    x = x_min
    y = y_min
    w = x_max - x_min
    h = y_max - y_min

    img_trim = image[y:y + h, x:x + w]  # 이미지 크기 지정

    cv2.imwrite(file_wpath, img_trim)  # 덮어쓰기

    print("Cliiping Completely !")

server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM);
# 소켓 레벨과 데이터 형태를 설정한다.
server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1);
server_socket.bind(('', 9999));
server_socket.listen();

try:
    while True:
        client_socket, addr = server_socket.accept();
        th = threading.Thread(target=binder, args = (client_socket,addr));
        th.start();
except:
    print("server");
finally:
    server_socket.close();