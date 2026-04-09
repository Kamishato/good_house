<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="scheme" value="${pageContext.request.scheme}" />
<c:set var="serverName" value="${pageContext.request.serverName}" />
<c:set var="serverPort" value="${pageContext.request.serverPort}" />
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="basePath" value="${scheme}://${serverName}:${serverPort}${contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>user table</title>
	<link rel="stylesheet" type="text/css" href="${basePath}/css/user-manage.css">
 	<link rel="stylesheet" type="text/css" href="${basePath}/css/paging.css">
 	<link rel="stylesheet" type="text/css" href="${basePath}/css/pa.css">
    <script type="text/javascript" src="${basePath}/js/qu.js"></script>
    <script type="text/javascript" src="${basePath}/js/paging.js"></script>
</head>
<style>
    /* 整卡可点击 + hover 效果 */
    .house-card {
        display: block;
        text-decoration: none;
        color: inherit;
    }
    .info-box {
        cursor: pointer;
        transition: transform 0.15s ease, box-shadow 0.15s ease;
    }
    .house-card:hover .info-box {
        transform: translateY(-2px);
        box-shadow: 18px 18px 40px rgba(0,0,0,0.18), -18px -18px 40px rgba(255,255,255,0.9);
    }
    .rent-label {
        font-size: 14px;
        font-weight: 700;
        margin-right: 6px;
        vertical-align: middle;
        color: #fff;
        opacity: 0.95;
    }
</style>
<body>

    <c:forEach items="${sessionScope.houseinfoList}" var="houseinfo">
    <a class="house-card" href="<c:choose><c:when test="${houseinfo.housestatus == '已售'}">javascript:alert('该房源已售出，仅供历史参考！');</c:when><c:otherwise>${pageContext.request.contextPath}/front/houseDetails?id=${houseinfo.id}</c:otherwise></c:choose>" <c:if test="${houseinfo.housestatus != '已售'}">target="content-box"</c:if>>
    <div class="info-box" style="position: relative;<c:if test="${houseinfo.housestatus == '已售'}"> opacity: 0.6; filter: grayscale(100%);</c:if>">
    		<div class="img-box">
    		<c:if test="${hosueImgInfoMap[houseinfo.code][0].savingfilename == null}">
    			<img style="width: 100%; height: 100%; border-radius: 10px;" src="${basePath}/img/noimg.png"/>
    		</c:if>
    		<c:if test="${hosueImgInfoMap[houseinfo.code][0].savingfilename != null}">
    			<img style="width: 100%; height: 100%; border-radius: 20px;" src="data:image/jpg;base64,${hosueImgInfoMap[houseinfo.code][0].dataBase64}"/>
    		</c:if>
        	</div>
        <div class="info-con">
            <div class="info-con-son1">
                <div class="con-son1-1">
                    <h2>${houseinfo.title}</h2>
                </div>
                <div class="con-son1-2">
                    <div style="font-size:xx-large; font-weight: 800;color: #ffff00">
                        <img src="${basePath}/img/money1.png">
                        <span class="rent-label">租金</span>
                        <fmt:formatNumber value="${houseinfo.price}" type="currency" currencySymbol=""></fmt:formatNumber>元/月
                    </div>
                </div>
            </div>
            <div class="info-house">
                <div class="tag1">${houseinfo.suiteRoom}室${houseinfo.suiteHall}厅${houseinfo.suiteBathroom}卫</div>
                <div class="tag1">${houseinfo.area}㎡</div>
                <div class="tag1">${houseinfo.direction}</div>
                <div class="tag1">${houseinfo.floor}/${houseinfo.totalFloor}层</div>
                <div class="tag1">${houseinfo.birth}年建造</div>
                <div class="tag1">${houseinfo.housebelong}</div>
                <div class="tag1">${houseinfo.propertyrights}</div>
                <div class="tag1">${houseinfo.decoration}</div>
                <div class="tag1">${houseinfo.housestatus}</div>
            </div>
        </div>
        <%-- 印章放在 .info-box 内、相对整卡居中；勿放在 .img-box 内，否则会相对左侧图区居中 --%>
        <c:if test="${houseinfo.housestatus == '已售'}">
            <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%) rotate(-15deg);
                        border: 3px solid #dc3545; color: #dc3545; font-size: 24px; font-weight: bold;
                        padding: 5px 15px; border-radius: 10px; z-index: 20; letter-spacing: 2px;
                        background: rgba(255,255,255,0.8); pointer-events: none;">
                已售
            </div>
        </c:if>
   	</div>
    </a>
    </c:forEach>
    
</body>
</html>