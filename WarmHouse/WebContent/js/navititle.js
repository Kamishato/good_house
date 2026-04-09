// 显示或隐藏下拉菜单（透明全屏遮罩；须配合 header.css 中 .title-nav 的 z-index > 遮罩，否则菜单会被压在遮罩下）
function showUserMenu(event) {
    if (event) {
        event.stopPropagation();
    }

    var usermenu = document.querySelector('.user-menu');
    if (!usermenu) {
        return;
    }

    var mask = document.getElementById('menu-mask');

    if (!mask) {
        mask = document.createElement('div');
        mask.id = 'menu-mask';
        // 低于 .title-nav(10001)，高于主内容区与 iframe，才能既点到菜单又能在空白处关菜单
        mask.style.cssText =
            'position:fixed;left:0;top:0;width:100%;height:100%;' +
            'z-index:9990;display:none;background:transparent;';

        mask.onclick = function () {
            usermenu.style.display = 'none';
            mask.style.display = 'none';
        };

        document.body.appendChild(mask);
    }

    var opening = (!usermenu.style.display || usermenu.style.display === 'none');
    if (opening) {
        usermenu.style.display = 'block';
        mask.style.display = 'block';
    } else {
        usermenu.style.display = 'none';
        mask.style.display = 'none';
    }
}
