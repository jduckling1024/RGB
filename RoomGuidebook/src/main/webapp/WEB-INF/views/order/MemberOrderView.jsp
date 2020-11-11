<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 구매</title>
<link rel="stylesheet" href="/resources/css/memberOrder.css">
</head>
<body>
    <div class="wrap">
        <div class="top">
            <div class="header">
                <p class="Title"><strong>RGB : Room Guide Book</p></strong>
            </div>
        </div>


        <div class="middle"> </div>

        <div class="orderInfo">
            <h3>배송지</h3>
            <div class="deliveryAddress">
                <table id="table1">
                    <tr>
                        <th>받는 분</th>
                        <td colspan="2">
                            <input type="text" id="name" class = "ip_text">
                        </td>
                    </tr>
                    <tr>
                        <th>우편번호</th>
                        <td><input type="text" id="addressNum" class = "ip_text"></td>
                        <td><button type="button" id="changeBtn">변경</button></td>
                    </tr>
                    <tr>
                        <th rowspan="2">주소</th>
                        <td colspan="2"><input type="text" id="address" class = "ip_text"></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="text" id="address2" class = "ip_text"></td>
                    </tr>
                    <tr>
                        <th>휴대전화</th>
                        <td colspan="2"><input type="text" id="phoneNum" class = "ip_text"></td>
                    </tr>
                </table>
            </div>

            <Br>
            <hr><Br>
            <h3>주문자</h3>
            <div class="orderer">
                <table id="table1">
                    <tr>
                        <th>이름</th>
                        <td>
                            <input type="text" id="ordererName" class = "ip_text">
                        </td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <td>
                            <input type="text" id="email" class = "ip_text">
                        </td>
                    </tr>
                    <tr>
                        <th>휴대전화</th>
                        <td>
                            <input type="text" id="ordererPhonenum" class = "ip_text">
                        </td>
                    </tr>
                </table>
            </div>

            <Br>
            <hr><Br>
            <h3>주문상품</h3>
            <div class="orderItem">
                <Table id="table2">
                    <tr>
                        <th rowspan="2"><img class="itemImage" src="image/item.jpg"></th>
                        <td>orderItem Name</td>
                    </tr>
                    <tr>
                        <td>price | ordercount</td>
                    </tr>
                </Table>
            </div>

            <Br>
            <hr><Br>
            <h3>최종 결제 금액</h3>
            <div class="totalPrice">
                <table id="table3">
                    <tr>
                        <th>총 상품금액</th>
                        <td>total Item Price</td>
                    </tr>
                    <tr>
                        <th>배송비</th>
                        <td>delivery Price</td>
                    </tr>
                    <tr>
                        <td colspan="2">Total Price</td>
                    </tr>

                </table>
            </div>

            <Br>
            <hr><Br>
            <h3>결제수단</h3>
            <div class="pay">
                <ul>
                    <li>
                        <input type='radio' name='pay' value='card' checked />카드</li>
                    <li><input type='radio' name='pay' value='deposit' checked />무통장입금</li>
                </ul>
                <button class = "completeBtn" type="submit">결제하기</button>
            </div>

        </div>

        <div class="bottom">

        </div>

    </div>
</body>
</html>