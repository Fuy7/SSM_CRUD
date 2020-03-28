<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2020/3/22
  Time: 23:50
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
    <%--引入jQuery--%>
    <script type="text/javascript" src="static/js/jquery.min.js"></script>
    <%--引入bootstrap样式--%>
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
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
                 <button class="btn btn-primary" btn-sm>新增</button>
                 <button type="button" class="btn btn-danger" btn-sm>删除</button>
             </div>
        </div>
        <!--显示表格数据-->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover ">
                    <tr>
                        <th>#</th>
                        <th>name</th>
                        <th>money</th>
                        <th>DeptName</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="use">
                        <tr>
                            <th>${use.id}</th>
                            <th>${use.name}</th>
                            <th>${use.money}</th>
                            <th>${use.dept.dName}</th>
                            <th>
                                <button class="btn btn-primary">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"  btn-xs></span>
                                    编辑
                                </button>
                                <button class="btn btn-danger"  btn-xs>
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true" ></span>
                                    删除
                                </button>
                            </th>
                        </tr>
                    </c:forEach>    
                </table>
            </div>
        </div>
        <!--分页信息-->
        <div class="row">
            <!--分页文字信息-->
            <div class="col-md-6">
                <span>当前${pageInfo.pageNum}页，总${pageInfo.pages}页，共${pageInfo.total}条记录</span>
            </div>
            <!--分页条-->
            <div class="col-md-6">
             <nav aria-label="Page navigation">
               <ul class="pagination">

               <li><a href="${APP_PATH}/users?pn=1">首页</a></li>
                   <!--如果有上一页,就显示<<,否则不显示-->
                   <c:if test="${pageInfo.hasPreviousPage}">
                     <li>
                        <a href="${APP_PATH}/users?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                          </a>
                     </li>
                   </c:if>
                   <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                       <!--当前页码需要添加样式,并且不能点击-->
                       <c:if test="${page_Num==pageInfo.pageNum}">
                           <li class="active"><a href="#">${page_Num}</a></li>
                       </c:if>
                       <!--点击其他页码要发送请求-->
                       <c:if test="${page_Num != pageInfo.pageNum}">
                           <li ><a href="${APP_PATH}/users?pn=${page_Num}">${page_Num}</a></li>
                       </c:if>
                   </c:forEach>
                   <c:if test="${pageInfo.hasNextPage}">
                      <li>
                        <a href="${APP_PATH}/users?pn=${pageInfo.pageNum+1}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                      </li>
                   </c:if>
                   <li><a href="${APP_PATH}/users?pn=${pageInfo.pages}">末页</a></li>
               </ul>
             </nav>
            </div>
        </div>
    </div>
</body>
</html>
