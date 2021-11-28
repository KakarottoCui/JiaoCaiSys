
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<div id="barDemo" style="display: none;">
    <button type="button"   class="layui-btn layui-btn-sm layui-btn-danger" onclick="receive_book()">
        领书
    </button>
    <button type="button"   class="layui-btn layui-btn-sm layui-btn-danger" >
        修改
    </button>
</div>
<body class="layui-anim layui-anim-up">
<div class="x-nav">
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
    <table id="stuquery_teach_store" lay-filter="teach_store_view"></table>
</div>
</body>
<script>
    layui.use([ "element", "laypage", "layer", "upload","table"], function() {
        var element = layui.element;
        var laypage = layui.laypage;
        var layer = layui.layer;
        var upload = layui.upload;//主要是这个
        var table = layui.table;
        var tableIns = table.render({
            elem: '#stuquery_teach_store'  //绑定table表格
            ,id:'stuquery_teach_store'
            ,dataType:'json'
            ,method:'post'
            ,url: '${pageContext.request.contextPath}/getStoreOutByUserId' //后台springmvc接收路径
            ,page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                //,curr: 5 //设定初始在第 5 页
                ,groups: 1 //只显示 1 个连续页码
                ,first: false //不显示首页
                ,last: false //不显示尾页
                ,limit:3
                ,limits:[3,6,9]
            }
            ,cols: [
                [
                    {type: 'checkbox'}
                    ,{field:'stoo_id',title:'教师的出库单号', sort: true}
                    ,{field:'id',title:'教材单号', sort: true}
                    ,{field:'book_name',title:'教材名称', sort: true}
                    ,{field:'book_price', title:'教材单价',sort:true}
                    ,{field:'qs_name', title:'供应商名称'}
                    ,{field:'total', title:'可领教材'}
                    ,{field:'operation',title:'操作',toolbar: '#barDemo'}
                ]
            ]
        });
    });

    function addStore(){
        layer.open(
            {
                type: 2,
                title: '添加库存',
                skin: 'layui-layer-lan',
                shadeClose: false,
                shade: 0.8,
                area:  ['400px', '450px'],
                resize:true,
                content:'${pageContext.request.contextPath}/store_in_add',
                end: function(){
                    window.location.reload(); //刷新父页面
                }
            }
        );
    }
    
    function receive_book() {
        var store_in_num="";//库存单号
        layui.use('table',function(){
            var table = layui.table
            var checkStatus = table.checkStatus('stuquery_teach_store');
            store_in_num = checkStatus.data[0].id;
        });
        layer.open({
            type: 2,
            title: '领取教材',
            skin: 'layui-layer-molv',
            shadeClose: false,
            shade: 0.8,
            area:  ['700px', '450px'],
            content: 'stu_receive_book?num='+store_in_num,
            end: function(){
                window.location.reload(); //刷新父页面
            }
        });
    }
    
</script>
</html>
