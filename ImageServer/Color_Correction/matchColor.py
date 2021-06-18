import socket, threading, cv2
import numpy as np
# clipping을 위한 서버

def simage_stats(image, start_x, start_y, end_x, end_y):  # source
    # compute the mean and standard deviation of each channel
    clip_image = image[start_y:end_y, start_x:end_x]
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


def color_transfer(source, target, f_width, f_height, arranged_x, arranged_y):
    # convert the images from the RGB to L*ab* color space, being
    # sure to utilizing the floating point data type (note: OpenCV
    # expects floats to be 32-bit, so use that instead of 64-bit)

    sheight = source.shape[0];

    source = cv2.cvtColor(source, cv2.COLOR_BGR2LAB).astype("float32")
    (_, _, _, alpha) = cv2.split(target);  # lab 색상공간으로 변경 전, alpha 채널 획득
    target = cv2.cvtColor(target, cv2.COLOR_BGR2LAB).astype("float32")

    print('f_width'+str(f_width))

    start_x = arranged_x - int(f_width * 2);  # + alpha
    start_y = 0;
    end_x = arranged_x + int(f_width * 2 );  # + alpha 261+150
    end_y = sheight - 1;

    """
    start_x = arranged_x - int(f_width / 2) - 120;  # + alpha
    start_y = arranged_y - int(f_height / 2) - 120;
    end_x = arranged_x + int(f_width / 2) + 120;  # + alpha 261+150
    end_y = arranged_y + int(f_height / 2) + 120;

    
    print('가구 픽셀: '+str(f_width)+", "+str(f_height))
    print('시작좌표: ('+ str(start_x)+', '+ str(start_y)+')')
    print('도착좌표: (' + str(end_x) + ', ' + str(end_y) + ')')
   

    start_x = int(fsx - fsx*0.3);
    start_y = int(fsy - fsy*0.3);
    end_x = int(fsx + fsx*0.3);
    end_y = int(fsy + fsy*0.3);
    """
    # compute color statistics for the source and target images

    # 픽셀 값을 넘어가면 최소 및 최대치만 반영
    if start_x < 1: start_x = 1
    if start_y < 1: start_y = 1
    if end_x >= source.shape[1]: end_x = source.shape[1] - 1
    if end_y >= source.shape[0]: end_y = source.shape[0] - 1


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

    l += lMeanSrc -40
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