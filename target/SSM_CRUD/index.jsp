<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2020/3/21
  Time: 16:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

</head>
<body>

<!-- 员工添加的模态框 -->
<div class="modal fade" id="userAndModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="userName_input" class="col-sm-2 control-label">UserName</label>
                        <div class="col-sm-10">
                            <input type="text" name="name" class="form-control" id="userName_input" placeholder="name">
                            <span class="help-block"></span>
                         </div>
                    </div>
                    <div class="form-group">
                        <label for="userMoney_input" class="col-sm-2 control-label">Money</label>
                        <div class="col-sm-10">
                            <input type="text" name="money" class="form-control" id="userMoney_input" placeholder="money">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">DeptName</label>
                        <div class="col-sm-4" >
                            <!-- 部门提交部门的id即可 -->
                            <select class="form-control" name="dId" id="dept_add_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="user_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>


<!-- 员工修改的模态框 -->
<div class="modal fade" id="userUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="userName_input" class="col-sm-2 control-label">UserName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="name_Update_static">email@example.com</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="userMoney_input" class="col-sm-2 control-label">Money</label>
                        <div class="col-sm-10">
                            <input type="text" name="money" class="form-control" id="userMoney_update_input" placeholder="money">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">DeptName</label>
                        <div class="col-sm-4" >
                            <!-- 部门提交部门的id即可 -->
                            <select class="form-control" name="dId" id="dept_update_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="user_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>


<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM_CRUD</h1>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-8"> <!--偏移-->
            <button class="btn btn-primary" btn-sm id="user_and_modal_btn">新增</button>
            <button type="button" class="btn btn-danger" id="user_delete_all_btn" btn-sm>删除</button>
        </div>
    </div>
    <!--显示表格数据-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="user_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all"/>
                        </th>
                        <th>#</th>
                        <th>name</th>
                        <th>money</th>
                        <th>DeptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!--分页信息-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6" id="page_info_area"></div>
        <!--分页条-->
        <div class="col-md-6" id="page_nav_area"></div>
    </div>
</div>

<!--引入jQuery-->
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.4.1.min.js"></script>
<!--引入bootstrap样式-->
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<!--Ajax处理-->
<script type="text/javascript">
    //全局变量,总页数
    var totalPageNum;
    //当前页数
    var currentPageNum;

    //1.页面加载完成后,直接发生Ajax请求获得分页信息
    $(function () {
        //首页
        to_page(1)
    });
    //跳转功能
    function to_page(pn) {
        //Ajax请求
        $.ajax({
            url:"${APP_PATH}/users",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                // console.log(result);
                //1.解析并显示员工信息
                build_user_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析显示分页条数据
                build_page_nav(result);
            }
        });
    }

    //解析显示表格
    function build_user_table(result) {
        //清空table表格
        $("#user_table tbody").empty();
        var users = result.extend.pageInfo.list;
        $.each(users,function (index, item) {
            var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
            var idTd=$("<td></td>").append(item.id);
            var nameTd=$("<td></td>").append(item.name);
            var moneyTd=$("<td></td>").append(item.money);
            var DeptnameTd=$("<td></td>").append(item.dept.dName);
            /*
            <button class="btn btn-primary">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"  btn-xs></span>
                编辑
            </button>
            * */
            var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑添加一个属性,表示当前员工ID
            editBtn.attr("edit_id",item.id);
            var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加一个属性,表示当前员工ID
            delBtn.attr("delete_id",item.id);
            var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append方法执行完成后还是会返回原来的元素
            $("<tr></tr>")
                .append(checkBoxTd)
                .append(idTd)
                .append(nameTd)
                .append(moneyTd)
                .append(DeptnameTd)
                .append(btnTd )
                .appendTo("#user_table tbody");
        })
    }
    //解析显示分页
    function build_page_info(result) {
        //清空分页信息
        $("#page_info_area").empty();
        $("#page_info_area").append("当前 "+result.extend.pageInfo.pageNum+" 页，总 "
            +result.extend.pageInfo.pages+" 页，共 "+result.extend.pageInfo.total+" 条记录");
            totalPageNum = result.extend.pageInfo.total;
            currentPageNum = result.extend.pageInfo.pageNum;
    }

    //解析显示分页条
    function build_page_nav(result) {
        //page_nav_area
        $("#page_nav_area").empty();
        var ul=$("<ul></ul>").addClass("pagination");
        //构建元素
        var fistPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.pageInfo.hasPreviousPage == false){    //如果没有前一项,就不能点
            fistPageLi.addClass("previous disabled");
            prePageLi.addClass("previous disabled");
        }else {
            //为元素添加点击翻页事件
            fistPageLi.click(function () {
                to_page(1);
            })
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);
            })
        }

        //构建元素
        var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(result.extend.pageInfo.hasNextPage == false){    //如果没有后一项,就不能点
            nextPageLi.addClass("previous disabled");
            lastPageLi.addClass("previous disabled");
        }else {
            //为元素添加点击翻页事件
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum+1);
            })
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            })
        }

        //添加首页和前一页的提示
        ul.append(fistPageLi).append(prePageLi);
        //遍历给ul中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums,function (index, item) {

            var numLi=$("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum == item){
                numLi.addClass("active")
            }
            numLi.click(function () {
                to_page(item);
            })
            ul.append(numLi);
        })
        //添加下一页和末页
        ul.append(nextPageLi).append(lastPageLi);
        //把ul添加到nav中
        var navEle=$("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }
    //封装的表单刷新方法
    function reset_form(ele){
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }
    <!-- 按钮绑定点击事件(点击新增按钮弹出对话框) -->
    $("#user_and_modal_btn").click(function () {
        //首先将表单历史记录清除(数据+样式)
        reset_form("#userAndModal form");
        //$("#userAndModal form")[0].reset();
        //应该先发送ajax请求,将部门信息传达到下拉列表中
        getDepts("#userAndModal select");
        //弹出
        $("#userAndModal").modal({
            <!-- 设置点击背景不会消失 -->
            backdrop:"static"
        })
    })

    //查出所有部门信息
    function getDepts(ele) {
        //清空历史记录
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
                //console.log(result);
                //遍历前清空一下
                $("#dept_add_select").empty();
                //显示部门到下拉页表
                    //遍历一个添加一个
                $.each(result.extend.depts,function() {
                    var optionEle=$("<option></option>").append(this.dName).attr("value",this.dId);
                    optionEle.appendTo(ele);

                })

            }
        });
    }

    //表单校验
    function validate_add_form(){
        //1.拿到要校验的数据,使用正则表达式
        var userName = $("#userName_input").val();
        var regName =  /(^[a-z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;   //正则表达式
        if(!regName.test(userName)){
            //alert("用户名不符合规则(2-5位中文或者6-16位英文和下划线组合)");
            show_validata_msg("#userName_input","error","用户名不符合规则(2-5位中文或者6-16位英文和下划线组合)");
            return false;
        }else {
            show_validata_msg("#userName_input","success","");
        };
        //2.校验金额
        var money = $("#userMoney_input").val();
        var regMoney =  /(^[0-9]{4})/;   //正则表达式
        if(!regMoney.test(money)){
            //alert("金额");
            show_validata_msg("#userMoney_input","error","金额输入不规范");
            return false;
        }else {
            show_validata_msg("#userMoney_input","success","");
        };
        return true;
    }

    //校验信息封装
    function show_validata_msg(ele,status,msg){
        //1.首先先清除历史状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error"==status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        };
    }
    //校验用户名是否可用
    $("#userName_input").change(function () {
        //发送ajax请求,校验用户名是否可用
        var name = this.value;
        $.ajax({
            url:"${APP_PATH}/checkname/",
            data:"name="+name,
            type:"POST",
            success:function (result) {
                if(result.code==100){
                    show_validata_msg("#userName_input","success","用户名可用");
                    $("#user_save_btn").attr("ajax_name","success");
                }else {     //有错误
                    show_validata_msg("#userName_input","error",result.extend.regx_msg);
                    $("#user_save_btn").attr("ajax_name","error");
                }
            }
        })


    })


   // <!-- 新增按钮绑定点击事件(点击新增按钮保存操作) -->
    $("#user_save_btn").click(function () {
        //1.表单数据提交给服务器
        //1.2 应该先登录校验
       if(!validate_add_form()){
            return false;   //校验不通过
        }
        //1.3查看ajax请求的校验用户名是否成功
        if($(this).attr("ajax_name")=="error"){
            return false;
        }
        //2.发送Ajax请求保存员工
        //alert($("#userAndModal form").serialize());
        $.ajax({
            url:"${APP_PATH}/users/",
            type: "POST",
            //使用serialize序列化数据
            data: $("#userAndModal form").serialize(),
            success:function (result) { //读取服务器返回的信息
                alert(result.msg);
                if(result.code == 100){
                    //console.log(result);
                    //关闭模态框
                    $("#userAndModal").modal('hide')
                    //显示最后一页
                    //发送ajax请求,显示最后一页数据
                    //to_page(totalPageNum-1);
                }else {
                    //显示失败信息
                    //console.log(result);
                    //哪个错就显示哪个
                    if(undefined!=result.extend.errorFields.name){
                        show_validata_msg("#userName_input","error",result.extend.errorFields.name);
                    }
                    if(undefined!=result.extend.errorFields.money){
                        show_validata_msg("#userMoney_input","error",result.extend.errorFields.money);
                    }

                }

            }
        })
    });

    //查询员工信息
    function getOneUser(id) {
        $.ajax({
            url:"${APP_PATH}/users/"+id,
            type:"GET",
            success:function (result) {
                //console.log(result);
                var userData = result.extend.user;
                //初始选定状态
                $("#name_Update_static").text(userData.name);
                $("#userMoney_update_input").val(userData.money);
                $("#dept_update_select").val([userData.dId])
            }
        })
    }

    //绑定编辑点击事件
    $(document).on("click",".edit_btn",function () {
        //alert("edit_btn")
        //1.查询部门信息
        getDepts("#userUpdateModal select")
        //2.查询用户信息
        getOneUser($(this).attr("edit_id"));
        //3.将员工ID传递给模态框的更新按钮
        $("#user_update_btn").attr("edit_id",$(this).attr("edit_id"));
        //弹出
        $("#userUpdateModal").modal({
            <!-- 设置点击背景不会消失 -->
            backdrop:"static"
        })
    })

    //更新按钮绑定单击事件,点击后更新
    $("#user_update_btn").click(function () {
        //校验金额是否合法
        var money = $("#userMoney_update_input").val();
        var regMoney =  /(^[0-9]{4})/;   //正则表达式
        if(!regMoney.test(money)){
            //alert("金额");
            show_validata_msg("#userMoney_update_input","error","金额输入不规范");
            return false;
        }else {
            show_validata_msg("#userMoney_update_input","success","");
        };
        //2.发送ajax请求保存员工数据
        $.ajax({
            url:"${APP_PATH}/users/"+$(this).attr("edit_id"),
            type:"PUT",
            data:$("#userUpdateModal form").serialize(),
            success:function (result) {
                //alert(result.msg);
                //1.关闭对话框
                $("#userUpdateModal").modal('hide');
                //2.回到本页面
                to_page(currentPageNum);

            }
        })
    });

    //绑定单个删除点击事件
    $(document).on("click",".delete_btn",function () {
        //1.弹出是否删除确认对话框
        var name = $(this).parents("tr").find("td:eq(2)").text();
        var id = $(this).attr("delete_id");
        //alert($(this).parents("tr").find("td:eq(1)").text());
        if(confirm("确认删除 "+name+" 信息么？")){
            //确认了 可以发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/users/"+id,
                type:"DELETE",
                data:$("#userUpdateModal form").serialize(),
                success:function (result) {
                    alert(result.msg);
                    //回到本页(刷新本页)
                    to_page(currentPageNum);
                }
            });

        }
    });
    //添加全选和全不选效果
    $("#check_all").click(function () {
        //使用prop修改和读取dom原生属性
        //通过class属性设置全选或者不选
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    $(document).on("click",".check_item",function () {
        //判断是否全点上
        var flag = $(".check_item:checked").length == $(".check_item").length;
        //全点上就设置全选状态
        $("#check_all").prop("checked",flag);
    });

    //绑定点击全部删除的按钮事件
    $("#user_delete_all_btn").click(function () {

        var usersNames = "";
        var del_ids = "";
        $.each($(".check_item:checked"),function () {
            usersNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            //员工id字符串
            del_ids += $(this).parents("tr").find("td:eq(1)").text() + "-";
        })
            //去除usersNames最后多余的 , 号
            usersNames = usersNames.substring(0,usersNames.length-1);
            //去除del_ids最后多余的 - 号
            del_ids = del_ids.substring(0,del_ids.length-1);
            if(confirm("确认删除 "+usersNames+" 的信息么？")){
                //确认了 可以发送ajax请求删除
                $.ajax({
                    url:"${APP_PATH}/users/"+del_ids,
                    type:"DELETE",
                    data:$("#userUpdateModal form").serialize(),
                    success:function (result) {
                        alert(result.msg);
                        //回到本页(刷新本页)
                        to_page(currentPageNum);
                    }
                });

            }
        });
</script>
</body>
</html>

