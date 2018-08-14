<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>RushToBuyCart</title>
    <style type="text/css">
        .ordersTableStyle{
            width:150px;
            align:center;
        }
        .ordersTableStyleLong{
            width:200px;
            align:center;
        }
    </style>
</head>
<body>
    <jsp:include page="commonHeaderBanner.jsp"/>
    <div>
        <form id="goodsFrom">
        <table align="center" id="ordersTable">
            <tr>
                <td class="ordersTableStyle"><h3>待付款编号</h3></td>
                <td class="ordersTableStyle"><h3>商品编号</h3></td>
                <td class="ordersTableStyle"><h3>商品图像</h3></td>
                <td class="ordersTableStyle"><h3>价格</h3></td>
            </tr>
            <c:forEach items="${goodsInCartList}" var="orders" varStatus="status">
                <tr>
                    <td class="ordersTableStyle">${orders.pendingPaymentId}</td>
                    <td class="ordersTableStyle">${orders.goodsId}</td>
                    <td class="ordersTableStyle">
                        <img src="${orders.goodsPicturePath}"  width="70" height="70">
                    </td>
                    <td class="ordersTableStyle">${orders.goodsPrice}</td>
                    <td><input id="payBt" type="button" onclick="pay(${orders.goodsPrice},${orders.goodsId},${orders.pendingPaymentId})" value="支付"></td>
                </tr>
            </c:forEach>
        </table>
        </form>
    </div>
    <div align="center">
        <form action="mall" id="noGoodsFrom">
            <H1>您还没有未付款的商品!</H1>
            <br>
            <br>
            <input type="submit" value="返回首页">
        </form>
    </div>
</body>
<script type="text/javascript">

    var size = "${goodsInCartListSize}".toString();

    if(size == "0"){
        $('#goodsFrom').hide();
        $('#noGoodsFrom').show();
    }else{
        $('#goodsFrom').show();
        $('#noGoodsFrom').hide();
    }

    function pay(goodsPrice,goodsId,pendingPaymentId){
        var userId='${sessionScope.userId}'.toString();
        if(userId != "" ){

            goodsId=goodsId.toString();
            goodsPrice=goodsPrice.toString();
            goodsPrice=pendingPaymentId.toString();

            if(!(goodsId==''||goodsPrice=='')) {
                $.ajax({
                    type: 'post',
                    url: 'payPendingPayment',
                    data: 'userId=' + userId + '&goodsId=' + goodsId + '&goodsPrice=' + goodsPrice + '&pendingPaymentId=' + pendingPaymentId,
                    success: function (data) {
                        if (data == "PaySuccess") {
                            window.location.href = "shoppingCart?userId=" + userId;
                        } else {
                            alert("提示：付款失败！");
                        }
                    }
                })
            }else {
                console.error('Params exits empty,please check it!');
            }
        }else{
            alert("请先登录");
        }
    }
</script>
</html>

