import socket, threading, cv2
import numpy as np
# clipping을 위한 서버

def simage_stats(image, start_x, start_y, end_x, end_y):  # source
    # compute the mean and standard deviation of each channel
    clip_image = image[start_x:end_x, start_y:end_y]
    (l, a, b) = cv2.split(clip_image)  # get 3 channels
    (lMean, lStd) = (l.mean(), l.std())
    (aMean, aStd) = (a.mean(), a.std())
    (bMean, bStd) = (b.mean(), b.std())
    # return the color statistics
    return (lMean, lStd, aMean, aStd, bMean, bStd)


def timage_stats(image):  # target
    # compute the mean and standard deviation of each channel
    (l, a, b) = cv2.split(image)  # get 3 channels
    (lMean, lStd) = (l.mean(), l.std())
    (aMean, aStd) = (a.mean(), a.std())
    (bMean, bStd) = (b.mean(), b.std())
    # return the color statistics
    return (lMean, lStd, aMean, aStd, bMean, bStd)


def color_transfer(source, target, arranged_x, arranged_y):
    # convert the images from the RGB to L*ab* color space, being
    # sure to utilizing the floating point data type (note: OpenCV
    # expects floats to be 32-bit, so use that instead of 64-bit)

    source = cv2.cvtColor(source, cv2.COLOR_BGR2LAB).astype("float32")
    (_, _, _, alpha) = cv2.split(target);  # lab 색상공간으로 변경 전, alpha 채널 획득
    target = cv2.cvtColor(target, cv2.COLOR_BGR2LAB).astype("float32")

    start_x = arranged_x - int(target.shape[1] / 2) - 80;  # + alpha
    start_y = arranged_y - int(target.shape[0] / 2) - 80;
    end_x = arranged_x + int(target.shape[1] / 2) + 80;  # + alpha
    end_y = arranged_y + int(target.shape[0] / 2) + 80;
    # compute color statistics for the source and target images

    # 픽셀 값을 넘어가면 최소 및 최대치만 반영
    if start_x < 0: start_x = 0
    if start_y < 0: start_y = 0
    if end_x > 0: end_x = source.shape[1] - 1
    if end_y > 0: end_y = source.shape[0] - 1

    (lMeanSrc, lStdSrc, aMeanSrc, aStdSrc, bMeanSrc, bStdSrc) \
        = simage_stats(source, start_x, start_y, end_x, end_y)  # 방 이미지와 시작좌표, 가구의 크기를 입력
    (lMeanTar, lStdTar, aMeanTar, aStdTar, bMeanTar, bStdTar) = timage_stats(target)
    # subtract the means from the target image
    (l, a, b) = cv2.split(target);

    l -= lMeanTar
    a -= aMeanTar
    b -= bMeanTar
    # scale by the standard deviations
    l = (lStdTar / lStdSrc) * l
    a = (aStdTar / aStdSrc) * a
    b = (bStdTar / bStdSrc) * b
    # add in the source mean
    l += lMeanSrc
    a += aMeanSrc
    b += bMeanSrc
    # clip the pixel intensities to [0, 255] if they fall outside
    # this range
    l = np.clip(l, 0, 255)
    a = np.clip(a, 0, 255)
    b = np.clip(b, 0, 255)
    # merge the channels together and convert back to the RGB color
    # space, being sure to utilize the 8-bit unsigned integer data
    # type
    transfer = cv2.merge([l, a, b])
    transfer = cv2.cvtColor(transfer.astype("uint8"), cv2.COLOR_LAB2BGR)
    transfer = cv2.cvtColor(transfer.astype("uint8"), cv2.COLOR_BGR2BGRA)

    # 원본 target에서 alpha 뽑아내서 transfer에 덮어쓰기
    # 알파값 설정, 0 ~ 255 (투명 ~ 불투명)
    for i in range(target.shape[0]):
        for j in range(target.shape[1]):
            if alpha[i - 1, j - 1] != 255:
                transfer[i - 1, j - 1] = (0, 0, 0, 0)
    # return the color transferred image
    return transfer

		# 배치좌표, 방 이미지, 가구 이미지 데이터 수신
"""
arranged_x = 450
arranged_y = 500

source = cv2.imread('C:\\Users\\DeepLearning_7\\Desktop\\RoomImage\\small.PNG')
target = cv2.imread('C:\\Users\\DeepLearning_7\\Desktop\\ForArrange\\clipfabricsopaSide.PNG',
                            cv2.IMREAD_UNCHANGED)
# 가구 이미지의 크기를 직접 할당하는 것이 아닌 비율로 조정, 영역 보간법 사용
# 물체 깊이
# x_ratio = target.shape[1]/(target.shape[1] + target.shape[0])
# y_ratio = target.shape[0]/(target.shape[1] + target.shape[0]);
# cv2.imshow('room', target)

target = cv2.resize(target, dsize=(0, 0), fx=0.7, fy=0.95, interpolation=cv2.INTER_AREA)

print('Room image info: (width: ' + str(source.shape[1]) + ', height: ' + str(source.shape[0]) + ')\n''')
print('Furniture image info: (width: ' + str(target.shape[1]) + ", height: " + str(target.shape[0]) + ")\n")

# 이미지 위 배치 좌표찍기
cv2.putText(source, "here", (arranged_x, arranged_y), cv2.FONT_HERSHEY_COMPLEX, 0.5, (0, 0, 255), 1,
            cv2.LINE_AA)

cv2.imshow('room', source)
img = color_transfer(source, target, arranged_x, arranged_y)  # 시작좌표 입력
cv2.imshow('result !', img)
cv2.imwrite('C:\\Users\\DeepLearning_7\\Desktop\\ForArrange\\trans.png', img)
cv2.waitKey(0)
 """