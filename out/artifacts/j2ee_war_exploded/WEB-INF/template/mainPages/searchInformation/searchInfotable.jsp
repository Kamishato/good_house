<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
    <title>用户管理</title>
    <link rel="stylesheet" type="text/css" href="${basePath}/css/user-manage.css">
    <link rel="stylesheet" type="text/css" href="${basePath}/css/paging.css">
    <script type="text/javascript" src="${basePath}/js/qu.js"></script>
    <script type="text/javascript" src="${basePath}/js/paging.js"></script>
</head>
<style>
/*
 * 列表区高度：用 calc(100vh - 顶栏预留) 固定可视区，避免 Flex 高度链导致滚动条丢失/分页被挤出。
 * 注：若嵌在 content-box iframe 内，100vh 仍为浏览器视口，与 iframe 高度不一致时可在后续改为 100% + 父级定高。
 */
html, body {
	margin: 0;
	box-sizing: border-box;
}
body {
	min-height: 100vh;
}
.searchUser span {
    font-size: 16px;
    font-weight: 700;
    color: black;
    margin: 0px 0px;
}

.searchUser {
    padding: 0px 10px;
}

.searchUser .getArea,
.searchUser .getPrice,
.searchUser .getBirth {
    width: 60px;
}

.searchUser .getFloor,
.searchUser .getTotalFloor {
    width: 40px;
}

.getDecoration {
    width: 100px;
    height: 33px;
    border: 1px solid #ccc;
}

.card {
    width: 70vw;
    height: auto;
    border-radius: 20px;
    background: #ffffff;
    box-shadow: 15px 15px 30px #bebebe, -15px -15px 30px #ffffff;
    padding: 5px 5px;
    margin: auto;
}
.radio-input{
	margin: 3px 0px;
	font-size: 16px;
    font-weight: 700;
    color: black;
}

.radio-input input {
    width: 10px;
}

.radio-input label {
    font-size: 15px;
    font-weight: 700;
    color: #777;
}
.user-manage {
	width: 100%;
	box-sizing: border-box;
	margin: 0;
	padding: 0;
	min-height: 100vh;
}

/* Tab 导航：Flex + 下划线高亮 */
.house-tab-nav {
	display: flex;
	gap: 0;
	align-items: stretch;
	border-bottom: 2px solid #e8eaed;
	margin: 4px 12px 0;
	padding: 0 8px;
	background: #fafbfc;
	border-radius: 8px 8px 0 0;
}
.house-tab-nav .tab-btn {
	background: transparent;
	border: none;
	padding: 14px 22px;
	font-size: 16px;
	cursor: pointer;
	color: #606266;
	border-bottom: 3px solid transparent;
	margin-bottom: -2px;
	transition: color 0.2s, border-color 0.2s;
	font-family: inherit;
}
.house-tab-nav .tab-btn:hover {
	color: #409eff;
}
.house-tab-nav .tab-btn.active {
	color: #409eff;
	font-weight: 700;
	border-bottom-color: #409eff;
}

/* Tab 内容区：calc 定高 + 外层可滚，避免整页把分页顶出视口 */
.tab-pane-wrap,
#all-houses-pane,
#recommend-houses-pane.tab-pane-wrap {
	width: 100%;
	/* 预留 ≈ 搜索卡片 + Tab 条；可按实际再调 150px～180px */
	height: calc(100vh - 170px);
	overflow-x: hidden;
	overflow-y: auto;
	box-sizing: border-box;
}
.user-table {
	width: 100%;
	height: 100%;
	box-sizing: border-box;
	position: relative;
}
.user-table iframe {
	display: block;
	width: 100%;
	height: 100%;
	border: none;
}
#recommend-houses-pane {
	padding: 24px;
	color: #909399;
	font-size: 14px;
}
</style>
<body>
	<div class="user-manage">
		<div class="searchUser">
			<div class="card">
	    	<form class="form" action="${basePath}/searchInformation/infotb" method="post" target="userTableList">
		    	
	    		<div class="radio-input">区域:
					<c:forEach items="${housebelongList}" var="housebelong">
						<c:if test="${housebelong.code == 00}">
						<input type="radio" id="'${housebelong.title}'+'1'" name="housebelong" value="" checked="checked">
						</c:if>
						<c:if test="${housebelong.code != 00}">
						<input type="radio" id="'${housebelong.title}'+'1'" name="housebelong" value="${housebelong.title}">
						</c:if>
						<label for="'${housebelong.title}'+'1'">${housebelong.title}</label>
					</c:forEach>
				</div>
	    	
	    		<div class="radio-input">房型:
					<c:forEach items="${suiteList}" var="suite">
						<c:if test="${suite.code == 00}">
						<input type="radio" id="'${suite.title}'+'2'" name="suiteRoom" value="" checked="checked">
						</c:if>
						<c:if test="${suite.code != 00}">
						<input type="radio" id="'${suite.title}'+'2'" name="suiteRoom" value="${suite.title}">
						</c:if>
						<label for="'${suite.title}'+'2'">${suite.title}</label>
					</c:forEach>
				</div>
	    	
	    		<div class="radio-input">面积:
					<c:forEach items="${areaList}" var="area">
						<c:if test="${area.code == 00}">
						<input type="radio" id="'${area.title}'+'3'" name="area" value="" checked="checked">
						</c:if>
						<c:if test="${area.code != 00}">
						<input type="radio" id="'${area.title}'+'3'" name="area" value="${area.title}">
						</c:if>
						<label for="'${area.title}'+'3'">${area.title}</label>
					</c:forEach>
				</div>
				
				<div class="radio-input">朝向:
					<c:forEach items="${directionList}" var="direction">
						<c:if test="${direction.code == 00}">
						<input type="radio" id="'${direction.title}'+'4'" name="direction" value="" checked="checked">
						</c:if>
						<c:if test="${direction.code != 00}">
						<input type="radio" id="'${direction.title}'+'4'" name="direction" value="${direction.title}">
						</c:if>
						<label for="'${direction.title}'+'4'">${direction.title}</label>
					</c:forEach>
				</div>
				
				<div class="radio-input">
					<span>建造年份：</span>
					<input type="number" id="birth" name="minBirth" min="0" max="2099" class="getBirth" value="1949">-
					<input type="number" id="birth" name="maxBirth" min="0" max="2099" class="getBirth" value="9999">年
					<span style="margin: 0px 10px">|</span> 
		    		
					<span>楼层：</span>
					<input type="number" id="floor" name="floor" min="0" class="getFloor">
					<span>总楼层：</span>
					<input type="number" id="totalFloor" name="totalFloor" min="0" class="getTotalFloor">
					<span style="margin: 0px 10px">|</span> 
					
					<span>租金：</span>
					<input type="number" id="price" name="minPrice" min="0.0" class="getPrice" step="1" value="0">-
					<input type="number" id="price" name="maxPrice" min="0.0" class="getPrice" step="1" value="99999">元/月			
				</div>
				
				
				<span>装修：</span>
	         	<select class="getDecoration" name="decoration">
	        			<c:forEach items="${decorationList}" var="decoration">
	        			<c:if test="${decoration.code == 00}">
	        				<option value="">${decoration.title}</option>
	        			</c:if>
	        			<c:if test="${decoration.code != 00}">
	         			<option value="${decoration.title}">${decoration.title}</option>
	         		</c:if>
					</c:forEach>
				</select><span style="margin: 0px 10px">|</span> 
				
				<span>物业：</span>
	         	<select class="getDecoration" name="property">
	        			<c:forEach items="${propertyList}" var="property">
	        			<c:if test="${property.code == 00}">
	        				<option value="">${property.title}</option>
	        			</c:if>
	        			<c:if test="${property.code != 00}">
	        				<option value="${property.title}">${property.title}</option>
	        			</c:if>
					</c:forEach>
				</select><span style="margin: 0px 10px">|</span> 
				
				<span>产权：</span>
	         	<select class="getDecoration" name="propertyrights">
	        			<c:forEach items="${propertyrightsList}" var="propertyrights">
	        			<c:if test="${propertyrights.code == 00}">
	        				<option value="">${propertyrights.title}</option>
	        			</c:if>
	        			<c:if test="${propertyrights.code != 00}">
	        				<option value="${propertyrights.title}">${propertyrights.title}</option>
	        			</c:if>
					</c:forEach>
				</select><span style="margin: 0px 10px">|</span> 
				
				<span>状态：</span>
	         	<select class="getDecoration" name="housestatus">
	        			<c:forEach items="${housestatusList}" var="housestatus">
	        			<c:if test="${housestatus.code == 00}">
	        				<option value="">${housestatus.title}</option>
	        			</c:if>
	        			<c:if test="${housestatus.code != 00}">
	        				<option value="${housestatus.title}">${housestatus.title}</option>
	        			</c:if>
					</c:forEach>
				</select>
				
				<span class="searchUserBtn" onclick="submitSearchUser()"><a target="usertable">查询</a></span>
	         	<span class="searchUserBtn" onclick="resetSearchUser()">重置</span><br>
	         	<input type="text" class="pageNum" name="pageNum" style="display:none" value="">
	         	<input type="text" class="pageSize" name="pageSize" style="display:none" value="">
	         	<!-- flag=1：分页时只信任 session 中的查询条件，避免 POST 绑定不完整导致总条数/结果集错位 -->
	         	<input type="hidden" name="flag" id="searchInformationFlag" value="">
		    </form>
		    </div>
	    </div>	  

		<div class="house-tab-nav" role="tablist" aria-label="房源视图切换">
			<button type="button" class="tab-btn active" id="tab-all-houses" role="tab" aria-selected="true" data-tab="all">🏠 全部房源</button>
			<button type="button" class="tab-btn" id="tab-recommend-houses" role="tab" aria-selected="false" data-tab="recommend">✨ 猜你喜欢</button>
		</div>

		<div id="all-houses-pane" class="tab-pane-wrap" role="tabpanel" aria-labelledby="tab-all-houses">
			<div class="user-table">
				<iframe id="userframe" name="userTableList" src="informationTable" width="100%" height="100%" frameborder="0" scrolling="yes"></iframe>
			</div>
		</div>
		<div id="recommend-houses-pane" class="tab-pane-wrap" style="display:none;" role="tabpanel" aria-labelledby="tab-recommend-houses" aria-hidden="true">
			<div class="user-table" style="height:100%;min-height:400px;">
				<iframe id="recommendFrame" name="recommendTableList" title="猜你喜欢" src="${basePath}/front/recommendList" width="100%" height="100%" frameborder="0" scrolling="yes"></iframe>
			</div>
		</div>
	</div>   
	
    <script>
	    function submitSearchUser(){
			var f = document.getElementById('searchInformationFlag');
			if (f) f.value = '';
			document.querySelector('.pageNum').value = 1;
			document.querySelector('.pageSize').value = 10;
			document.querySelector('.form').submit();
	    };
	   
	    function resetSearchUser(){
	    	document.querySelector('.form').reset();
	    	var f = document.getElementById('searchInformationFlag');
			if (f) f.value = '';
	    };

	    (function initHouseSearchTabs() {
	    	var buttons = document.querySelectorAll('.house-tab-nav .tab-btn');
	    	var paneAll = document.getElementById('all-houses-pane');
	    	var paneRec = document.getElementById('recommend-houses-pane');
	    	var form = document.querySelector('.form');
	    	var basePath = '${basePath}';
	    	if (!buttons.length || !paneAll || !paneRec || !form) return;
	    	function applyTabToForm(isRecommend) {
	    		if (isRecommend) {
	    			form.action = basePath + '/front/recommendList';
	    			form.target = 'recommendTableList';
	    		} else {
	    			form.action = basePath + '/searchInformation/infotb';
	    			form.target = 'userTableList';
	    		}
	    	}
	    	buttons.forEach(function(btn) {
	    		btn.addEventListener('click', function() {
	    			var tab = btn.getAttribute('data-tab');
	    			buttons.forEach(function(b) {
	    				b.classList.toggle('active', b === btn);
	    				b.setAttribute('aria-selected', b === btn ? 'true' : 'false');
	    			});
	    			if (tab === 'all') {
	    				paneAll.style.display = 'block';
	    				paneRec.style.display = 'none';
	    				paneRec.setAttribute('aria-hidden', 'true');
	    				applyTabToForm(false);
	    			} else {
	    				paneAll.style.display = 'none';
	    				paneRec.style.display = 'block';
	    				paneRec.setAttribute('aria-hidden', 'false');
	    				applyTabToForm(true);
	    			}
	    		});
	    	});
	    	applyTabToForm(false);
	    })();
    </script>
</body>

</html>