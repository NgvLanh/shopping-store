<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="content-wrapper">
    <div class="main-panel">
        <div class="content-wrapper">
            <div class="page-header">
                <h3 class="page-title">Discounts Management</h3>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/admin/dashboard">Admin</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Discounts Management</li>
                    </ol>
                </nav>
            </div>
            <div class="row">
                <div class="col-md-12 grid-margin stretch-card">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">Discount Form</h4>
                            <p class="card-description">Create - Update</p>
                            <%--@elvariable id="discount" type="com.poly.entities.Discount"--%>
                            <form:form class="forms-sample row" method="post"
                                       action="/admin/discounts-management/create"
                                       modelAttribute="discount" enctype="multipart/form-data">
                                <form:hidden path="discountId"/>
                                <div class="form-group col-md-6">
                                    <label for="productItem">Product Item</label>
                                    <form:select path="productItem" class="form-control" id="productItem">
                                        <form:option value="">-- Select Product --</form:option>
                                        <form:options items="${productItemList}" itemLabel="product.name"/>
                                    </form:select>
                                    <form:errors path="productItem" cssClass="text-danger"
                                                 cssStyle="font-size: 14px; margin: 4px"/>
                                </div>

                                <div class="form-group col-md-6">
                                    <label for="code">Code</label>
                                    <div class="d-flex">
                                        <form:input path="code" type="text" class="form-control" id="code"
                                                    placeholder="Code" readonly="true"/>
                                        <button type="button" class="btn btn-inverse-danger" onclick="generateCode(8)">Generate
                                        </button>
                                    </div>
                                    <form:errors path="code" cssClass="text-danger"
                                                 cssStyle="font-size: 14px; margin: 4px"/>
                                </div>

                                <div class="form-group col-md-6">
                                    <label for="percentNumber">Percent</label>
                                    <form:input path="percentNumber" type="number" class="form-control"
                                                id="percentNumber" placeholder="PercentNumber"/>
                                    <form:errors path="percentNumber" cssClass="text-danger"
                                                 cssStyle="font-size: 14px; margin: 4px"/>
                                </div>
                                <form:input path="createTime" type="text" class="form-control" id="endTime"
                                            placeholder="End Time" cssStyle="display: none"/>
                                <div class="form-group col-md-6">
                                    <label for="endTime">End Time</label>
                                    <form:input path="endTime" type="text" class="form-control" id="endTime"
                                                placeholder="End Time"/>
                                    <span class="text-danger" style="font-size: 14px; margin: 4px"></span>
                                </div>

                                <div class="col-md-12">
                                    <button type="submit" class="btn btn-primary mr-2" ${disabledSave}>Save</button>
                                    <button type="submit" class="btn btn-primary mr-2" ${disabledUpdate}
                                            formaction="/admin/discounts-management/update">Update
                                    </button>
                                    <button type="button" class="btn btn-light"
                                            onclick="window.location.href='/admin/discounts-management'">Cancel
                                    </button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>

                <div class="col-lg-12 grid-margin stretch-card">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">Discount Table</h4>
                            <p class="card-description">All discounts</p>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                    <tr>
                                        <th>Discount ID</th>
                                        <th>Product Item</th>
                                        <th>Code</th>
                                        <th>Percent</th>
                                        <th>Create Time</th>
                                        <th>End Time</th>
                                        <th>Update</th>
                                        <th>Delete</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="discount" items="${discounts}">
                                        <tr>
                                            <td>${discount.discountId}</td>
                                            <td>${discount.productItem.product.name}</td>
                                            <td>${discount.code}</td>
                                            <td>${discount.percentNumber}</td>
                                            <td>
                                                <fmt:formatDate value="${discount.createTime}" type="both"
                                                                timeStyle="short"/>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${discount.endTime}" type="both"
                                                                timeStyle="short"/>
                                            </td>
                                            <td>
                                                <a href="/admin/discounts-management/edit/${discount.discountId}"
                                                   class="btn btn-warning">Edit</a>
                                            </td>
                                            <td>
                                                <button class="btn btn-danger">Delete</button>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer class="footer">
            <div class="d-sm-flex justify-content-center justify-content-sm-between">
                <span class="text-muted d-block text-center text-sm-left d-sm-inline-block">Design by Teo</span>
            </div>
        </footer>
    </div>
</div>
<script>
    function generateCode(length) {
        const code = document.getElementById('code');
        const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        let result = '';
        for (let i = 0; i < length; i++) {
            result += characters.charAt(Math.floor(Math.random() * characters.length));
        }
        code.value = result;
    }
</script>