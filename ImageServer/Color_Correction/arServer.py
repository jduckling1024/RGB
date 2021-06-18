# *** 은 결과를 보기위한 코드, 시연할 때 필요 X
import socket, threading
import json, cv2
from Color_Correction import matchColor as mc
from time import sleep
import os


# binder함수는 서버에서 accept가 되면 생성되는 socket 인스턴스를 통해 client로 부터 데이터를 받으면 echo형태로 재송신하는 메소드이다.
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

         arranged_x = int(jsonData.get("pos").get("x"))
         arranged_y = int(jsonData.get("pos").get("y"))
         room_filepath = jsonData.get("image").get("r_filepath")
         furniture_filepath = jsonData.get("image").get("f_filepath")
        # 슬래시 몇 개로 나오는지 확인
         furniture_filename = jsonData.get("image").get("f_filename")
         r_width = int(jsonData.get("shape").get("r_width"))
         r_height = int(jsonData.get("shape").get("r_height"))
         f_width = int(jsonData.get("shape").get("f_width"))
         f_height = int(jsonData.get("shape").get("f_height"))
         print('배치 좌표: ('+str(arranged_x)+', '+str(arranged_y)+")")

         source = cv2.imread(room_filepath)
         target = cv2.imread('C:\\Users\\DeepLearning_6\\eclipse-workspace\\.metadata\\.plugins\\'
                     'org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\RoomGuideBook\\resources\\image_arrange_ap\\'+furniture_filename, cv2.IMREAD_UNCHANGED)
         # 한 줄 잘못되면 다른 코드에도 영향을 주니 주의해야함.
         # 문자열에다 입력된 백슬래시를 출력하면 파이썬에선 자동으로 /2 로 줄이기때문에 
         # 경로 표현을 위해선 백슬래시 4개를 작성
         #이미지 크기 조정
         rh_rate = r_width / source.shape[1];
         rv_rate = r_height / source.shape[0];

         source = cv2.resize(source, dsize=(0, 0), fx= rh_rate, fy=rv_rate, interpolation=cv2.INTER_AREA)
         # *** 이미지 위 배치 좌표찍기
         cv2.putText(source, "here", (arranged_x, arranged_y), cv2.FONT_HERSHEY_COMPLEX, 0.5, (0, 0, 255), 1,
                    cv2.LINE_AA)
         # ***

         img = mc.color_transfer(source, target, f_width, f_height, arranged_x, arranged_y)
         print('complete transfer')
         # ***
         #cv2.imshow('result!', img)
         #cv2.waitKey(0)
         # ***
         img = cv2.GaussianBlur(img, (3, 3), 0)
         cv2.imwrite('C:\\Users\\DeepLearning_6\\eclipse-workspace\\RoomGuidebook\\src\\main\\webapp\\'
                       'resources\\image_result\\'+furniture_filename, img)
         #cv2.imwrite('C:\\Users\\DeepLearning_7\\eclipse-workspace\\.metadata\\.plugins\\'
         #            'org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\RoomGuideBook\\resources\\image_result\\'+furniture_filename, img)
         # 일단은 자바와 공통으로 사용하는 서버에 저장 -> 스프링 서버에서 jsp로 띄우는 방법
         # 파이썬에서 바로 자바랑 통신에서 jsp로 띄우는 방법 고안
         sleep(4);
         msg = "complete transfer"
         data = msg.encode()
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
server_socket.bind(('', 9998));
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
