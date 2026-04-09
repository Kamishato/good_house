<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<title>猜你喜欢</title>
	<link rel="stylesheet" type="text/css" href="${basePath}/css/user-manage.css">
	<link rel="stylesheet" type="text/css" href="${basePath}/css/pa.css">
</head>
<style>
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
    .rent-label { font-size: 14px; font-weight: 700; margin-right: 6px; vertical-align: middle; color: #fff; opacity: 0.95; }
    .tip { padding: 12px 16px; color: #606266; font-size: 14px; }
</style>
<body>
    <p class="tip">
        <c:choose>
            <c:when test="${recommendNoCandidate}">当前筛选条件下没有符合条件的房源，无法生成推荐。</c:when>
            <c:when test="${recommendFilterActive}">在符合您筛选条件的房源中，根据浏览与收藏为您推荐（新用户展示符合条件的热门）。</c:when>
            <c:otherwise>根据您的浏览与收藏记录，为您推荐以下房源（新用户展示全站热门）。</c:otherwise>
        </c:choose>
    </p>
    <c:forEach items="${houseinfoList}" var="houseinfo">
    <c:set var="coverList" value="${hosueImgInfoMap[houseinfo.code]}" />
    <a class="house-card" href="${pageContext.request.contextPath}/front/houseDetails?id=${houseinfo.id}" target="content-box">
    <div class="info-box">
    		<div class="img-box">
    		<c:choose>
    		<c:when test="${empty coverList or empty coverList[0] or coverList[0].savingfilename == null}">
    			<img style="width: 100%; height: 100%; border-radius: 10px;" src="${basePath}/img/noimg.png" alt=""/>
    		</c:when>
    		<c:otherwise>
    			<img style="width: 100%; height: 100%; border-radius: 20px;" src="data:image/jpg;base64,${coverList[0].dataBase64}" alt=""/>
    		</c:otherwise>
    		</c:choose>
        	</div>
        <div class="info-con">
            <div class="info-con-son1">
                <div class="con-son1-1">
                    <h2>${houseinfo.title}</h2>
                </div>
                <div class="con-son1-2">
                    <div style="font-size:xx-large; font-weight: 800;color: #ffff00">
                        <img src="${basePath}/img/money1.png" alt="">
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
   	</div>
    </a>
    </c:forEach>

    <div style="clear: both; padding-top: 20px;"></div>

    <c:set var="recFlagQs" value="" />
    <c:if test="${recommendFilterActive}">
        <c:set var="recFlagQs" value="&amp;flag=1" />
    </c:if>

    <c:if test="${totalRecords > 0}">
        <div class="simple-pagination" style="text-align: center; margin-bottom: 20px; font-size: 14px; color: #666; width: 100%;">
            <span style="margin-right: 15px;">共为您推荐 ${totalRecords} 套房源</span>

            <a href="${scheme}://${serverName}:${serverPort}${pageContext.request.contextPath}/front/recommendList?pageNum=1${recFlagQs}" style="margin: 0 5px; color: #007bff; text-decoration: none;">首页</a>

            <c:if test="${pageNum > 1}">
                <a href="${scheme}://${serverName}:${serverPort}${pageContext.request.contextPath}/front/recommendList?pageNum=${pageNum - 1}${recFlagQs}" style="margin: 0 5px; color: #007bff; text-decoration: none;">上一页</a>
            </c:if>

            <span style="margin: 0 10px;"> 第 ${pageNum} / ${totalPages} 页 </span>

            <c:if test="${pageNum < totalPages}">
                <a href="${scheme}://${serverName}:${serverPort}${pageContext.request.contextPath}/front/recommendList?pageNum=${pageNum + 1}${recFlagQs}" style="margin: 0 5px; color: #007bff; text-decoration: none;">下一页</a>
            </c:if>

            <a href="${scheme}://${serverName}:${serverPort}${pageContext.request.contextPath}/front/recommendList?pageNum=${totalPages}${recFlagQs}" style="margin: 0 5px; color: #007bff; text-decoration: none;">尾页</a>
        </div>
    </c:if>

    <div style="height: 80px; width: 100%; clear: both;"></div>

    <c:if test="${empty houseinfoList and not recommendNoCandidate}">
        <p class="tip">暂无推荐房源。</p>
    </c:if>
</body>
</html>
