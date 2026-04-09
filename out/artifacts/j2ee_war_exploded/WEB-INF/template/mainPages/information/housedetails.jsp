<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${house.title}</title>
    <style>
        body {
            margin: 0;
            font-family: "Microsoft YaHei", Arial, sans-serif;
            background: #f6f7fb;
            color: #1f2d3d;
        }
        .page {
            max-width: 1200px;
            margin: 0 auto;
            padding: 24px 18px 72px;
        }
        .top {
            display: grid;
            grid-template-columns: 1.2fr 0.8fr;
            gap: 18px;
        }
        .panel {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(31,45,61,0.08);
            overflow: hidden;
        }
        .gallery {
            padding: 14px;
        }
        .main-img {
            width: 100%;
            height: 420px;
            border-radius: 14px;
            background: #eef1f6;
            object-fit: cover;
        }
        .thumbs {
            display: grid;
            grid-template-columns: repeat(6, 1fr);
            gap: 10px;
            margin-top: 12px;
        }
        .thumbs img {
            width: 100%;
            height: 64px;
            border-radius: 10px;
            object-fit: cover;
            cursor: pointer;
            border: 2px solid transparent;
            transition: all .15s ease;
            background: #eef1f6;
        }
        .thumbs img:hover {
            transform: translateY(-1px);
            box-shadow: 0 8px 18px rgba(31,45,61,0.14);
        }
        .thumbs img.active {
            border-color: #409EFF;
        }

        .side {
            padding: 18px 18px 20px;
        }
        .title {
            font-size: 22px;
            font-weight: 800;
            line-height: 1.35;
            margin: 4px 0 10px;
        }
        .price {
            display: flex;
            align-items: baseline;
            gap: 10px;
            margin: 10px 0 16px;
        }
        .price .num {
            font-size: 34px;
            font-weight: 900;
            color: #ff5a5f;
        }
        .price .unit {
            font-size: 14px;
            color: #909399;
            font-weight: 700;
        }
        .meta {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
            margin-top: 12px;
        }
        .meta .item {
            background: #f6f7fb;
            border-radius: 12px;
            padding: 10px 12px;
        }
        .meta .k {
            font-size: 12px;
            color: #909399;
            font-weight: 700;
            margin-bottom: 4px;
        }
        .meta .v {
            font-size: 14px;
            font-weight: 800;
        }
        .contact {
            margin-top: 14px;
            padding: 12px 12px;
            border-radius: 12px;
            background: linear-gradient(135deg, #409EFF 0%, #67C23A 100%);
            color: #fff;
        }
        .contact .line1 {
            font-size: 14px;
            font-weight: 800;
            margin-bottom: 4px;
        }
        .contact .line2 {
            font-size: 16px;
            font-weight: 900;
            letter-spacing: 0.4px;
        }
        .addr {
            margin-top: 12px;
            padding: 12px 12px;
            border-radius: 12px;
            background: #fff7ed;
            color: #7c2d12;
            border: 1px solid rgba(124,45,18,0.12);
        }
        .addr .k { font-size: 12px; font-weight: 800; opacity: 0.8; }
        .addr .v { margin-top: 6px; font-size: 14px; font-weight: 800; }

        .detail {
            margin-top: 18px;
            padding: 18px;
        }
        .section {
            margin-top: 14px;
            padding: 14px 14px;
            border-radius: 14px;
            background: #f6f7fb;
        }
        .section h3 {
            margin: 0 0 8px;
            font-size: 16px;
            font-weight: 900;
        }
        .section p {
            margin: 0;
            font-size: 14px;
            line-height: 1.75;
            color: #303133;
            white-space: pre-wrap;
            word-break: break-word;
        }

        /* 放在侧栏文档流内：在 iframe（content-box）里 fixed 易相对视口错位/被裁切，看起来像按钮消失 */
        .fav-btn {
            width: 100%;
            margin-top: 14px;
            border: 0;
            border-radius: 12px;
            padding: 12px 14px;
            font-size: 15px;
            font-weight: 900;
            cursor: pointer;
            background: #ff5a5f;
            color: #fff;
            box-shadow: 0 8px 24px rgba(255,90,95,0.28);
            transition: transform .15s ease, box-shadow .15s ease, opacity .15s ease;
        }
        .fav-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 12px 28px rgba(255,90,95,0.38);
        }
        .toast {
            position: fixed;
            left: 50%;
            bottom: 26px;
            transform: translateX(-50%);
            background: rgba(31,45,61,0.92);
            color: #fff;
            padding: 10px 14px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 700;
            display: none;
            max-width: 80vw;
        }
    </style>
</head>
<body>
    <div class="page">
        <div class="top">
            <div class="panel">
                <div class="gallery">
                    <c:choose>
                        <c:when test="${not empty photos}">
                            <img id="mainImg" class="main-img" src="${contextPath}/houseimage/check?photocode=${photos[0].photocode}" alt="房源图片">
                            <div class="thumbs" id="thumbs">
                                <c:forEach items="${photos}" var="p" varStatus="st">
                                    <img class="${st.index == 0 ? 'active' : ''}"
                                         src="${contextPath}/houseimage/check?photocode=${p.photocode}"
                                         data-src="${contextPath}/houseimage/check?photocode=${p.photocode}"
                                         alt="缩略图">
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <img class="main-img" src="${contextPath}/img/noimg.png" alt="暂无图片">
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="panel">
                <div class="side">
                    <div class="title">${house.title}</div>
                    <div class="price">
                        <div class="num">${house.price}</div>
                        <div class="unit">元/月</div>
                    </div>

                    <div class="meta">
                        <div class="item">
                            <div class="k">面积</div>
                            <div class="v">${house.area} ㎡</div>
                        </div>
                        <div class="item">
                            <div class="k">户型</div>
                            <div class="v">${house.suiteRoom}室${house.suiteHall}厅${house.suiteBathroom}卫</div>
                        </div>
                        <div class="item">
                            <div class="k">朝向</div>
                            <div class="v">${house.direction}</div>
                        </div>
                        <div class="item">
                            <div class="k">楼层</div>
                            <div class="v">${house.floor}/${house.totalFloor}层</div>
                        </div>
                    </div>

                    <div class="addr">
                        <div class="k">详细地址</div>
                        <div class="v">${house.detailedAddress}</div>
                    </div>

                    <div class="contact">
                        <div class="line1">联系房东（微信）</div>
                        <div class="line2">${house.contactWechat}</div>
                    </div>

                    <c:choose>
                        <c:when test="${isFavorited}">
                            <button type="button" class="fav-btn" style="background-color: #ccc; cursor: not-allowed; box-shadow: none;" disabled>已收藏</button>
                        </c:when>
                        <c:otherwise>
                            <button type="button" class="fav-btn" id="favBtn" onclick="addFavorite()">加入收藏</button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <div class="panel detail">
            <div class="section">
                <h3>房屋亮点</h3>
                <p>${house.highlights}</p>
            </div>
            <div class="section">
                <h3>出租要求</h3>
                <p>${house.rentalReqs}</p>
            </div>
            <div class="section">
                <h3>房源描述</h3>
                <p>${house.description}</p>
            </div>
        </div>
    </div>

    <div id="toast" class="toast"></div>

    <script>
        (function bindThumbs() {
            var thumbs = document.getElementById('thumbs');
            var mainImg = document.getElementById('mainImg');
            if (!thumbs || !mainImg) return;
            thumbs.addEventListener('click', function (e) {
                var target = e.target;
                if (!target || target.tagName !== 'IMG') return;
                var src = target.getAttribute('data-src');
                if (src) mainImg.src = src;
                var imgs = thumbs.querySelectorAll('img');
                for (var i = 0; i < imgs.length; i++) imgs[i].classList.remove('active');
                target.classList.add('active');
            });
        })();

        function showToast(msg) {
            var el = document.getElementById('toast');
            el.textContent = msg || '';
            el.style.display = 'block';
            setTimeout(function () { el.style.display = 'none'; }, 1800);
        }

        function addFavorite() {
            var xhr = new XMLHttpRequest();
            xhr.open('POST', '${contextPath}/front/favorite', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
            xhr.onreadystatechange = function () {
                if (xhr.readyState !== 4) return;
                try {
                    var res = JSON.parse(xhr.responseText || '{}');
                    if (res.code === 1) {
                        alert('收藏成功！');
                        var btn = document.getElementById('favBtn');
                        if (btn) {
                            btn.innerText = '已收藏';
                            btn.style.backgroundColor = '#ccc';
                            btn.style.cursor = 'not-allowed';
                            btn.style.boxShadow = 'none';
                            btn.disabled = true;
                            btn.onclick = null;
                        }
                    } else {
                        showToast(res.msg || '操作失败');
                    }
                } catch (e) {
                    showToast('操作失败');
                }
            };
            xhr.send('houseId=${house.id}');
        }
    </script>
</body>
</html>

