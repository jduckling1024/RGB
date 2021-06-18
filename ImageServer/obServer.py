import cv2
import numpy as np
import json
import socket, threading


def objectDetect(filename):
    # Load Yolo
    net = cv2.dnn.readNet("yolov3.weights", "yolov3.cfg")
    classes = []
    with open("coco.names", "r") as f:
        classes = [line.strip() for line in f.readlines()]
    layer_names = net.getLayerNames()
    output_layers = [layer_names[i[0] - 1] for i in net.getUnconnectedOutLayers()]
    colors = np.random.uniform(0, 255, size=(len(classes), 3))
    # Loading image

    img = cv2.imread("C:\\Users\\DeepLearning_6\\eclipse-workspace\\RoomGuideBook\\src\\main\\webapp\\resources\\image_room\\"+filename)

    height, width, channels = img.shape

    print(height)
    print(width)
    # 배치 좌표를 입력 ( for test )
    arranged_x = 323
    arranged_y = 481

    # Detecting objects
    blob = cv2.dnn.blobFromImage(img, 0.00392, (416, 416), (0, 0, 0), True, crop=False)

    net.setInput(blob)
    outs = net.forward(output_layers)

    # Showing informations on the screen
    class_ids = []
    confidences = []
    boxes = []

    # Detection
    for out in outs:
        for detection in out:
            scores = detection[5:]
            class_id = np.argmax(scores)
            confidence = scores[class_id]
            if confidence > 0.5:
                # Object detected
                center_x = int(detection[0] * width)
                center_y = int(detection[1] * height)
                w = int(detection[2] * width)
                h = int(detection[3] * height)

                # Rectangle coordinates
                x = int(center_x - w / 2)
                y = int(center_y - h / 2)

                boxes.append([x, y, w, h])
                confidences.append(float(confidence))
                class_ids.append(class_id)

    indexes = cv2.dnn.NMSBoxes(boxes, confidences, 0.5, 0.4)
    print(indexes)
    font = cv2.FONT_HERSHEY_PLAIN

    output = ""
    size = 0;
    for i in range(len(boxes)): # 감지된 물체들
        if i in indexes:
            x, y, w, h = boxes[i]

            print("x: "+str(x)+", y: "+str(y)+", w: "+str(w)+", h: "+str(h))
            label = str(classes[class_ids[i]])
            color = colors[class_ids[i]]

            if (x <= arranged_x and x + w >= arranged_x) and (y <= arranged_y and y + h >= arranged_y): print("Fail !")
            else: print("Success !")

            output += str(x) + "#" + str(y) + "#" + str(w) + "#" + str(h) + "#"
            size += 1

            cv2.rectangle(img, (x, y), (x + w, y + h), color, 2)
            cv2.putText(img, label, (x, y + 30), font, 3, color, 3)

    print(len(boxes));
    print(output);
    return size, output

def binder(client_socket, addr):
    print('Connected by', addr);
    try:
         #수신할 데이터의 크기를 먼저 수신
         data = client_socket.recv(4);
         # 최초 4바이트는 전송할 데이터의 크기이다. 그 크기는 little 엔디언으로 byte에서 int형식으로 변환한다.
         length = int.from_bytes(data, "little");
         # 다시 데이터를 수신한다.
         data = client_socket.recv(length)
         received_data = data.decode()
         # 수신 데이터를 str형태로 decode
         jsonData = json.loads(received_data)

         filename = jsonData.get("filename")
         size, output = objectDetect(filename)

         data = (str(size)+"#"+output).encode()
         length = len(data)
         client_socket.sendall(length.to_bytes(4, byteorder="little"))
         client_socket.sendall(data)

    except:
# 접속이 끊기면 except가 발생한다.
        print("except : " , addr);
    finally:
# 접속이 끊기면 socket 리소스를 닫는다.
        client_socket.close();
# 소켓을 만든다.
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM);
# 소켓 레벨과 데이터 형태를 설정한다.
server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1);
# 서버는 복수 ip를 사용하는 pc의 경우는 ip를 지정하고 그렇지 않으면 None이 아닌 ''로 설정한다.
# 포트는 pc내에서 비어있는 포트를 사용한다. cmd에서 netstat -an | find "LISTEN"으로 확인할 수 있다.
server_socket.bind(('', 9997));
# server 설정이 완료되면 listen를 시작한다.
server_socket.listen();

try:
# 서버는 여러 클라이언트를 상대하기 때문에 무한 루프를 사용한다.
    while True:
        # client로 접속이 발생하면 accept가 발생한다.
        # 그럼 client 소켓과 addr(주소)를 튜플로 받는다.
        client_socket, addr = server_socket.accept();
        # 쓰레드를 이용해서 client 접속 대기를 만들고 다시 accept로 넘어가서 다른 client를 대기한다.
        th = threading.Thread(target=binder, args = (client_socket,addr));
        th.start();
except:
    print("server");
finally:
    # 에러가 발생하면 서버 소켓을 닫는다.
    server_socket.close();

