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
    <link rel="stylesheet" type="text/css" href="${basePath}/css/editForm.css">
</head>
<style>
    .edit-box{
        max-width: 1450px;
        width: calc(100% - 60px);
        margin: 30px auto;
        padding: 20px;
        /* 底部下拉控件可能溢出，给足容器内空间，避免超过白色容器底部 */
        padding-bottom: 60px;
        background: #fff;
        border-radius: 16px;
        box-shadow: 0 10px 30px rgba(31,45,61,0.06);
    }

    /* 统一的“左标签右输入”对齐 */
    .listuser{
        display: flex;
        flex-direction: column;
        gap: 14px;
    }

    .field-row{
        display: flex;
        align-items: center;
        gap: 12px;
        width: 100%;
    }

    .field-label{
        width: 120px;
        text-align: right;
        font-size: 14px;
        font-weight: 700;
        color: #000;
        flex: 0 0 120px;
        padding-right: 8px;
        box-sizing: border-box;
    }

    .field-control{
        flex: 1;
        min-width: 260px;
    }

    /* 标题与售房人区域：缩短标题输入框长度，给出更舒适的留白 */
    .title-with-seller input.form-input{
        width: 60%;
        max-width: 500px;
        min-width: 260px;
        flex: 0 0 auto;
    }
    .title-with-seller select.form-select{
        width: 200px;
        flex: 0 0 200px;
    }

    /* 输入样式：现代感 + 圆角 + padding */
    .form-input,
    .form-select{
        width: 100%;
        box-sizing: border-box;
        outline-style: none;
        border: 1px solid #dcdfe6;
        border-radius: 4px;
        padding: 9px 10px;
        font-size: 14px;
        font-family: "Microsoft soft";
        background: #fff;
    }

    .form-textarea{
        width: 100%;
        min-height: 120px; /* 至少 100px */
        box-sizing: border-box;
        outline-style: none;
        border: 1px solid #dcdfe6;
        border-radius: 4px;
        padding: 9px 10px;
        font-size: 14px;
        font-family: "Microsoft soft";
        resize: vertical;
        line-height: 1.6;
    }

    /* 短输入（组 1）与属性下拉（组 4）采用 Flex 换行 */
    .group1,
    .group4{
        display: flex;
        flex-wrap: wrap;
        gap: 14px 18px;
    }

    /* 让“装修/产权/物业/状态”这一行离底部按钮留出空间 */
    .group4{
        padding-bottom: 10px;
    }

    .field-short{
        flex: 1 1 calc(33.33% - 18px);
        min-width: 320px;
    }

    .field-quarter{
        /* 允许在小屏/窄容器下继续“挤”进 1 行（不再被 min-width 拉爆宽度） */
        flex: 1 1 0;
        min-width: 0;
    }

    /* 仅针对“装修/产权/物业/状态”这一行：缩小总长度并避免超过白色容器 */
    .group4{
        width: 100%;
        gap: 14px 12px; /* 比默认更紧凑，减少总宽度 */
    }

    /* field-quarter 内部控件不再强制最小宽度 */
    .group4 .field-quarter .field-control{
        min-width: 0;
    }

    /* 房型“三小输入” */
    .house-type{
        display: flex;
        align-items: center;
        gap: 8px;
    }
    .house-type .mini-input{
        width: 90px;
        text-align: center;
    }
    .house-type .unit{
        font-weight: 700;
        color: #606266;
    }


    /* 标题 + 售房人同一行展示（普通用户：售房人只读文本） */
    .title-with-seller{
        display: flex;
        align-items: center;
        gap: 12px;
    }
    .seller-view{
        flex: 0 0 auto;
        background: #f6f7fb;
        border: 1px solid rgba(64, 158, 255, 0.15);
        border-radius: 10px;
        padding: 8px 10px;
        font-size: 14px;
        font-weight: 900;
        color: #409EFF;
        white-space: nowrap;
    }

    /* 单位同一行：面积/建造年份/租金 */
    .unit-inline{
        display: flex;
        align-items: center;
        white-space: nowrap;
        gap: 5px;
        flex-wrap: nowrap;
    }
    .unit-inline .form-input{
        width: 140px; /* 覆盖 .form-input 的 width:100% */
        flex: 0 0 140px;
    }

    .form-actions{
        display: flex;
        justify-content: flex-end;
        gap: 12px;
        margin-top: 6px;
    }

    .btn{
        cursor: pointer;
        width: 110px;
        height: 34px;
        line-height: 34px;
        background-color: rgb(64,158,255);
        text-align: center;
        border-radius: 10px;
        color: #fff;
        border: 0;
        font-size: 14px;
        font-weight: 900;
    }
    .btn.secondary{
        background-color: #606266;
    }
    .btn.ghost{
        background-color: #909399;
    }
</style>
<body>
<div class="edit-box">

    <c:if test="${houseInfoFlag==1}">
        <form class="listuser" action="${basePath}/information/addHouseInfoSubmit" method="post" target="content-box">
    </c:if>
    <c:if test="${houseInfoFlag!=1}">
        <form class="listuser" action="${basePath}/information/houseInfoSubmit" method="post" target="content-box">
    </c:if>

        <!-- 任务一：隐藏注册编号（code），禁止用户填写；新增时后端会覆盖生成 -->
        <input type="hidden" name="code" value="${showHouseInfoTable.code}">

        <!-- 任务二：第二组（长输入）- 房源标题 + 售房人（普通用户只读展示） -->
        <div class="field-row">
            <div class="field-label">房源标题：</div>
            <div class="field-control">
                <div class="title-with-seller">
                    <input placeholder="请输入房源标题" type="text" name="title" class="form-input" value="${showHouseInfoTable.title}">

                    <c:if test="${houseinfoPutFlag==1}">
                        <!-- 普通用户：售房人无需输入文本 -->
                        <input type="hidden" name="salesman" value="${houseinfoUsername}">
                        <div class="seller-view">售房人：${houseinfoUsername}</div>
                    </c:if>

                    <c:if test="${houseinfoPutFlag!=1}">
                        <!-- 管理员：允许选择售房人 -->
                        <select class="form-select" name="salesman">
                            <c:forEach items="${allUser}" var="auser">
                                <c:choose>
                                    <c:when test="${auser.username == showHouseInfoTable.salesman}">
                                        <option value="${auser.username}" selected="selected">${auser.username}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${auser.username}">${auser.username}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- 任务二：第一组（短输入） -->
        <div class="group1">
            <div class="field-row field-short">
                <div class="field-label">房型：</div>
                <div class="field-control">
                    <div class="house-type">
                        <input type="number" name="suiteRoom" min="0" class="form-input mini-input" value="${showHouseInfoTable.suiteRoom}">
                        <span class="unit">室</span>
                        <input type="number" name="suiteHall" min="0" class="form-input mini-input" value="${showHouseInfoTable.suiteHall}">
                        <span class="unit">厅</span>
                        <input type="number" name="suiteBathroom" min="0" class="form-input mini-input" value="${showHouseInfoTable.suiteBathroom}">
                        <span class="unit">卫</span>
                    </div>
                </div>
            </div>

            <div class="field-row field-short">
                <div class="field-label">面积：</div>
                <div class="field-control">
                    <div class="unit-inline">
                        <input type="number" name="area" min="0.0" step="0.01" class="form-input" value="${showHouseInfoTable.area}">
                        <span style="font-weight: 900; color: #606266;">㎡</span>
                    </div>
                </div>
            </div>

            <div class="field-row field-short">
                <div class="field-label">朝向：</div>
                <div class="field-control">
                    <select class="form-select" name="direction">
                        <c:forEach items="${directionList}" var="direction">
                            <c:choose>
                                <c:when test="${direction.code == 00 && direction.title == showHouseInfoTable.direction}">
                                    <option value="" selected="selected">${direction.title}</option>
                                </c:when>
                                <c:when test="${direction.code == 00 && direction.title != showHouseInfoTable.direction}">
                                    <option value="">${direction.title}</option>
                                </c:when>
                                <c:when test="${direction.code != 00 && direction.title == showHouseInfoTable.direction}">
                                    <option value="${direction.title}" selected="selected">${direction.title}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${direction.title}">${direction.title}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="field-row field-short">
                <div class="field-label">建造年份：</div>
                <div class="field-control">
                    <div class="unit-inline">
                        <input type="number" name="birth" min="0" max="2022" class="form-input" value="${showHouseInfoTable.birth}">
                        <span style="font-weight: 900; color: #606266;">年</span>
                    </div>
                </div>
            </div>

            <div class="field-row field-short">
                <div class="field-label">楼层：</div>
                <div class="field-control">
                    <input type="number" name="floor" min="0" class="form-input" value="${showHouseInfoTable.floor}">
                </div>
            </div>

            <div class="field-row field-short">
                <div class="field-label">总楼层：</div>
                <div class="field-control">
                    <input type="number" name="totalFloor" min="0" class="form-input" value="${showHouseInfoTable.totalFloor}">
                </div>
            </div>

            <div class="field-row field-short">
                <div class="field-label">所属区：</div>
                <div class="field-control">
                    <select class="form-select" name="housebelong">
                        <c:forEach items="${housebelongList}" var="housebelong">
                            <c:choose>
                                <c:when test="${housebelong.code == 00 && housebelong.title == showHouseInfoTable.housebelong}">
                                    <option value="" selected="selected">${housebelong.title}</option>
                                </c:when>
                                <c:when test="${housebelong.code == 00 && housebelong.title != showHouseInfoTable.housebelong}">
                                    <option value="">${housebelong.title}</option>
                                </c:when>
                                <c:when test="${housebelong.code != 00 && housebelong.title == showHouseInfoTable.housebelong}">
                                    <option value="${housebelong.title}" selected="selected">${housebelong.title}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${housebelong.title}">${housebelong.title}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="field-row field-short">
                <div class="field-label">租金：</div>
                <div class="field-control">
                    <div class="unit-inline">
                        <input type="number" name="price" min="0" step="0.01" class="form-input" value="${showHouseInfoTable.price}">
                        <span style="font-weight: 900; color: #606266;">元/月</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- 任务二：第二组（长输入，单独占满一行） -->
        <div class="field-row">
            <div class="field-label">详细地址：</div>
            <div class="field-control">
                <input placeholder="请输入详细地址" type="text" name="detailedAddress" class="form-input" value="${showHouseInfoTable.detailedAddress}">
            </div>
        </div>

        <div class="field-row">
            <div class="field-label">联系人微信：</div>
            <div class="field-control">
                <input placeholder="请输入联系人微信" type="text" name="contactWechat" class="form-input" value="${showHouseInfoTable.contactWechat}">
            </div>
        </div>

        <div class="field-row">
            <div class="field-label">房屋亮点：</div>
            <div class="field-control">
                <input placeholder="请输入房屋亮点" type="text" name="highlights" class="form-input" value="${showHouseInfoTable.highlights}">
            </div>
        </div>

        <div class="field-row">
            <div class="field-label">出租要求：</div>
            <div class="field-control">
                <input placeholder="请输入出租要求" type="text" name="rentalReqs" class="form-input" value="${showHouseInfoTable.rentalReqs}">
            </div>
        </div>

        <!-- 任务二：第三组（文本域：房源描述） -->
        <div class="field-row" style="align-items:flex-start;">
            <div class="field-label">房源描述：</div>
            <div class="field-control">
                <textarea name="description" class="form-textarea" placeholder="请输入房源描述">${showHouseInfoTable.description}</textarea>
            </div>
        </div>

        <!-- 任务二：第四组（属性下拉：装修/产权/物业/状态） -->
        <div class="group4">
            <div class="field-row field-quarter">
                <div class="field-label">装修：</div>
                <div class="field-control">
                    <select class="form-select" name="decoration">
                        <c:forEach items="${decorationList}" var="decoration">
                            <c:choose>
                                <c:when test="${decoration.code == 00 && decoration.title == showHouseInfoTable.decoration}">
                                    <option value="" selected="selected">${decoration.title}</option>
                                </c:when>
                                <c:when test="${decoration.code == 00 && decoration.title != showHouseInfoTable.decoration}">
                                    <option value="">${decoration.title}</option>
                                </c:when>
                                <c:when test="${decoration.code != 00 && decoration.title == showHouseInfoTable.decoration}">
                                    <option value="${decoration.title}" selected="selected">${decoration.title}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${decoration.title}">${decoration.title}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="field-row field-quarter">
                <div class="field-label">产权：</div>
                <div class="field-control">
                    <select class="form-select" name="propertyrights">
                        <c:forEach items="${propertyrightsList}" var="propertyrights">
                            <c:choose>
                                <c:when test="${propertyrights.code == 00 && propertyrights.title == showHouseInfoTable.propertyrights}">
                                    <option value="" selected="selected">${propertyrights.title}</option>
                                </c:when>
                                <c:when test="${propertyrights.code == 00 && propertyrights.title != showHouseInfoTable.propertyrights}">
                                    <option value="">${propertyrights.title}</option>
                                </c:when>
                                <c:when test="${propertyrights.code != 00 && propertyrights.title == showHouseInfoTable.propertyrights}">
                                    <option value="${propertyrights.title}" selected="selected">${propertyrights.title}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${propertyrights.title}">${propertyrights.title}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="field-row field-quarter">
                <div class="field-label">物业：</div>
                <div class="field-control">
                    <select class="form-select" name="property">
                        <c:forEach items="${propertyList}" var="property">
                            <c:choose>
                                <c:when test="${property.code == 00 && property.title == showHouseInfoTable.property}">
                                    <option value="" selected="selected">${property.title}</option>
                                </c:when>
                                <c:when test="${property.code == 00 && property.title != showHouseInfoTable.property}">
                                    <option value="">${property.title}</option>
                                </c:when>
                                <c:when test="${property.code != 00 && property.title == showHouseInfoTable.property}">
                                    <option value="${property.title}" selected="selected">${property.title}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${property.title}">${property.title}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="field-row field-quarter">
                <div class="field-label">状态：</div>
                <div class="field-control">
                    <select class="form-select" name="housestatus">
                        <c:forEach items="${housestatusList}" var="housestatus">
                            <c:choose>
                                <c:when test="${housestatus.code == 00 && housestatus.title == showHouseInfoTable.housestatus}">
                                    <option value="" selected="selected">${housestatus.title}</option>
                                </c:when>
                                <c:when test="${housestatus.code == 00 && housestatus.title != showHouseInfoTable.housestatus}">
                                    <option value="">${housestatus.title}</option>
                                </c:when>
                                <c:when test="${housestatus.code != 00 && housestatus.title == showHouseInfoTable.housestatus}">
                                    <option value="${housestatus.title}" selected="selected">${housestatus.title}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${housestatus.title}">${housestatus.title}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>

        <div class="form-actions">
            <button type="button" class="btn" onclick="submitSearchUser()">提交</button>
            <button type="button" class="btn secondary" onclick="cancel()">取消</button>
            <button type="button" class="btn ghost" onclick="resetForm()">重置</button>
        </div>

        <br>
        </form>
</div>
</body>

<script>
    function submitSearchUser(){
        document.querySelector('.listuser').submit();
    }

    function resetForm(){
        document.querySelector('.listuser').reset();
    }

    function cancel(){
        window.location.href = "${basePath}/information/listinfo?username=${houseinfoUsername}&pageNum=1&pageSize=10";
    }
</script>

</html>

