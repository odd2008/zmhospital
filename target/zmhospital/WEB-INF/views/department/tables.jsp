<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>

<!doctype html>
<html class="no-js" lang="">
<head>
    <title>列表</title>
    <%@include file="/commons/basejs.jsp" %>
</head>
<body>

<div class="app">

    <%--头部--%>
    <c:import url="../common/header.jsp"/>

    <section class="layout">

        <%--导入菜单--%>
        <c:import url="../common/menu.jsp"/>

        <%--主要页面--%>
        <section class="main-content">

            <div class="content-wrap">
                <div class="row">
                    <div class="col-md-12">
                        <section class="panel">
                            <%--<header class="panel-heading">Sortable table</header>--%>
                            <div class="panel-body no-padding">
                                <%--搜索--%>
                                <div>
                                    <form id="myform" class="form-inline" method="get" action="${cur_url}" role="form">
                                        <div class="form-group">
                                            <label class="sr-only" for="search_name">Email</label>
                                            <input type="text" class="form-control" name="search_name" id="search_name"
                                                   value="${pageinfo.condition['search_name']}"
                                                   placeholder="科室名称">
                                        </div>
                                        <button type="submit" class="btn btn-default">查询</button>
                                        <shiro:hasPermission name="/department/add">
                                            <a href="${add_url}" class="btn btn-default">新增</a>
                                        </shiro:hasPermission>
                                    </form>
                                </div>
                                <%--列表--%>
                                <div class="table-responsive">
                                    <table class="table table-striped responsive" data-sortable>
                                        <thead>
                                        <tr>
                                            <th>科室id</th>
                                            <th>科室名称</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="item" items="${pageinfo.list}">
                                            <tr>
                                                <td>
                                                    <c:out value="${item.id}"/>
                                                </td>
                                                <td>
                                                    <c:out value="${item.name}"/>
                                                </td>
                                                <td>
                                                    <div class="btn-group">

                                                        <a class="btn btn-success" title="查看">
                                                            <i class="fa fa-book"></i>
                                                        </a>

                                                        <shiro:hasPermission name="/department/edit">
                                                            <a href="${edit_url}?id=${item.id}" class="btn btn-info"
                                                               title="修改">
                                                                <i class="fa fa-edit"></i>
                                                            </a>
                                                        </shiro:hasPermission>

                                                        <shiro:hasPermission name="/department/delete">
                                                            <a class="btn btn-danger button_delete"
                                                               data-deleteid="${item.id}"
                                                               title="删除">
                                                                <i class="fa fa-remove"></i>
                                                            </a>
                                                        </shiro:hasPermission>

                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </section>
                    </div>
                </div>
                <div class="row">
                    <%--导入分页--%>
                    <c:import url="/WEB-INF/views/common/pagination.jsp">
                        <c:param name="total" value="${pageinfo.total}"/>
                        <c:param name="pageSize" value="${pageinfo.pagesize}"/>
                        <c:param name="pageUrl" value="${cur_url}"/>
                        <c:param name="pageIndex" value="${pageinfo.nowpage}"/>
                        <c:param name="pagesCount" value="${pageinfo.totalPage}"/>
                    </c:import>
                </div>
            </div>

        </section>

    </section>
</div>

<%@include file="/commons/basejs2.jsp" %>
<script type="text/javascript">
    $(document).ready(function () {
        var $btn_deletes = $('a.button_delete');

        //删除按钮
        $btn_deletes.click(function () {
            //本按钮
            var $this = $(this);

            $.ajax({
                url: "${delete_url}",
                type: "POST",
                datatype: "json",
                data: {
                    id: $this.attr("data-deleteid")
                },
                success: function (data, textStatus) {
                    var index = layer.alert(data.msg, {icon: 3, title: '提示'}, function (index) {
                        //do something
                        if (data.success) {
                            window.location.reload(true);
                        } else {
                            layer.close(index);
                        }
                    });
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest + textStatus + errorThrown);
                }
            });
        });

    });
</script>


</body>
</html>