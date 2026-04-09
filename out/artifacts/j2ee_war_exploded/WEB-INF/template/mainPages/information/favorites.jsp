<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="scheme" value="${pageContext.request.scheme}" />
<c:set var="serverName" value="${pageContext.request.serverName}" />
<c:set var="serverPort" value="${pageContext.request.serverPort}" />
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="basePath" value="${scheme}://${serverName}:${serverPort}${contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的收藏夹</title>
    <link rel="stylesheet" type="text/css" href="${basePath}/css/user-manage.css">
    <link rel="stylesheet" type="text/css" href="${basePath}/css/paging.css">
    <link rel="stylesheet" type="text/css" href="${basePath}/css/pa.css">
</head>
<style>
    h2{
        width: 85vw;
        margin: 18px auto 12px;
        color: #303133;
    }
    /* 卡片结构与租赁列表保持一致 */
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
    <h2>我的收藏夹</h2>

    <c:forEach items="${houseList}" var="houseinfo">
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
                                ${houseinfo.price} 元/月
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

    <div style="clear: both; padding-top: 20px;"></div>

    <c:if test="${pageInfo != null && pageInfo.total > 0}">
        <div class="simple-pagination" style="text-align: center; margin-bottom: 20px; font-size: 14px; color: #666; width: 100%;">
            <span style="margin-right: 15px;">共 ${pageInfo.total} 条收藏记录</span>
            <a href="${pageContext.request.contextPath}/user/favorites?pageNum=1" style="margin: 0 5px; color: #007bff; text-decoration: none;">首页</a>
            <c:if test="${pageInfo.pageNum > 1}">
                <a href="${pageContext.request.contextPath}/user/favorites?pageNum=${pageInfo.pageNum - 1}" style="margin: 0 5px; color: #007bff; text-decoration: none;">上一页</a>
            </c:if>
            <span style="margin: 0 10px;"> 第 ${pageInfo.pageNum} / ${pageInfo.pages == 0 ? 1 : pageInfo.pages} 页 </span>
            <c:if test="${pageInfo.pageNum < pageInfo.pages}">
                <a href="${pageContext.request.contextPath}/user/favorites?pageNum=${pageInfo.pageNum + 1}" style="margin: 0 5px; color: #007bff; text-decoration: none;">下一页</a>
            </c:if>
            <a href="${pageContext.request.contextPath}/user/favorites?pageNum=${pageInfo.pages == 0 ? 1 : pageInfo.pages}" style="margin: 0 5px; color: #007bff; text-decoration: none;">尾页</a>
        </div>
    </c:if>
    <div style="height: 80px; width: 100%; clear: both;"></div>
</body>
</html>

