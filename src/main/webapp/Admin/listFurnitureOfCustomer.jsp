<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% String cspNonce = (String) request.getAttribute("cspNonce"); %>

<c:import url="header.jsp" />
<%--------------------------------------------------------%>
<c:import url="sidebar.jsp" />
<script nonce="<%= cspNonce %>">
    document.addEventListener("DOMContentLoaded", function() {
        document.title = "Danh sách đơn hàng";
        const listStaffElement = document.getElementById("list-category");
        if (listStaffElement) {
            listStaffElement.classList.add("active");
        }
    });
</script>

<div class="page-wrapper">
    <div class="content">
        <style nonce="<%= cspNonce %>">
            .page-header{
                display: flex; justify-content: space-between; align-items: flex-start; padding: 20px; border-bottom: 1px solid #ddd;
            }
            .customer-profile{display: flex; gap: 20px; align-items: stretch; height: auto;}
            .img{
                flex-shrink: 0; height: 200px; width: 180px; display: flex; align-items: stretch;
            }
            .avatar{
                height: 100%; width: 100%; object-fit: cover; display: block;
            }
            .tittle{
                text-align: right; margin-top: 20px;
            }
            .h4{
                font-weight: bold; font-size: 1.8em; margin: 0; font-family: 'Poppins', sans-serif; color: #333;
            }
            .h6{
                font-size: 1.1em; color: #777; margin: 5px 0 0; font-family: 'Roboto', sans-serif;
            }
            .search{
                text-align: left; margin-bottom: 15px; padding: 10px; border-left: 5px solid #28a745; border-radius: 5px;
            }
            .search-title{
                font-size: 1.2em; font-weight: 400; color: #4a4a4a; font-family: 'Poppins', sans-serif; font-style: italic; margin: 0;
                padding: 8px 12px; display: flex; align-items: center; background-color: #f9fbfd; border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); text-shadow: 0px 1px 1px rgba(0, 0, 0, 0.1); letter-spacing: 0.5px;
            }
            .margin-left{
                margin-left: 10px;
            }
            .margin-bottom{
                margin-bottom: 15px;
            }
            .margin-bottom0{
                margin-bottom: 0;
            }
            .margin-top{
                margin-top: 10px;
            }
            .category{
                width: 100%; padding: 8px; border-radius: 4px; border: 1px solid #ccc;
            }
            .td{
                max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
            }
            .w90{
                max-width: 90%; width: 90%;
            }
            .large-image{
                width: 100%; max-height: 600px;
            }
        </style>
        <div class="page-header">
            <!-- Phần thông tin khách hàng -->
            <div class="customer-profile" >
                <!-- Ảnh đại diện -->
                <div class="product-img img" >
                    <c:choose>
                        <c:when test="${not empty customer.avatar}">
                            <img src="data:image/jpeg;base64,${customer.avatar}" alt="Avatar" class="avatar"/>
                        </c:when>
                        <c:otherwise>
                            <img src="https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg" alt="Avatar" class="avatar" />
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Thông tin khách hàng -->
                <div id="customer-info">
                    <div>
                        <span>Họ và tên:</span>
                        <span>${customer.name}</span>
                    </div>
                    <div>
                        <span>Số điện thoại:</span>
                        <span>${customer.phone}</span>
                    </div>
                    <div>
                        <span>Email:</span>
                        <span>${customer.email}</span>
                    </div>
                    <div>
                        <span>Địa chỉ:</span>
                        <span>${customer.address}</span>
                    </div>
                    <div>
                        <span>Trạng thái:</span>
                        <span>${customer.status}</span>
                    </div>
                </div>
            </div>

            <!-- Phần Quản lý đơn hàng -->
            <div class="page-title tittle" >
                <h4 class="h4">Phân tích khách hàng</h4>
                <h6 class="h6">Tìm kiếm/xem danh sách sản phẩm yêu thích</h6>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/admin-customer-furniture" method="get"
              id="listForm">
            <div class="card">

                <div class="card-body">
                    <div class="search-header search">
                        <h6 class="search-title">
                            🔍 <span class="margin-left">Tìm Kiếm Sản Phẩm </span>
                        </h6>

                    </div>
                    <div class="card-body pb-0">
                        <div class="row">

                            <input type="hidden" name="customerId" value="${furnitureRequestDTO.customerId}" placeholder="Nhập mã khách hàng...">
                            <div class="col-lg-3 col-sm-6 col-12 margin-bottom" >
                                <div class="form-group margin-bottom0" >
                                    <input type="text" name="categoryName" value="${furnitureRequestDTO.categoryName}" placeholder="Nhập tên sản phẩm..." class="category">
                                </div>
                            </div>
                            <div class="col-lg-3 col-sm-6 col-12 margin-bottom">
                                <div class="form-group margin-bottom0">
                                    <input type="number" name="priceStart" value="${furnitureRequestDTO.priceStart}" placeholder="Nhập giá sản phẩm từ..." class="category">
                                </div>
                            </div>
                            <div class="col-lg-3 col-sm-6 col-12 margin-bottom">
                                <div class="form-group margin-bottom0">
                                    <input type="number" name="priceEnd" value="${furnitureRequestDTO.priceEnd}" placeholder="Nhập giá sản phẩm đến..." class="category">
                                </div>
                            </div>
                            <div
                                    class="col-lg-2 col-sm-6 col-12 ms-auto">
                                <button type="button"
                                        class="btn btn-success"
                                        id="btnSearchfurniture">
                                    <svg xmlns="http://www.w3.org/2000/svg"
                                         width="16"
                                         height="16"
                                         fill="currentColor"
                                         class="bi bi-search"
                                         viewBox="0 0 16 16">
                                        <path
                                                d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0">
                                        </path>
                                    </svg>
                                    Tìm Kiếm
                                </button>
                            </div>
                        </div>
                    </div>
                    <br>
                    <div class="table-responsive">
                        <table class="table" id="orderList">
                            <thead>
                            <tr>
                                <th>Nội Thất</th>
                                <th>Mô Tả</th>
                                <th>Giá Một Sản Phẩm</th>
                                <th>Trạng Thái</th>
                                <th>Số Lượng</th>
                                <th>Tổng Chi Phí</th>
                            </thead>
                            <tbody>
                            <c:forEach var="furniture" items="${furniture}">
                                <tr>
                                    <td class="productimgname">
                                        <a href="javascript:void(0);" class="product-img">
                                            <c:choose>
                                                <c:when test="${not empty furniture.avatar}">
                                                    <img src="data:image/jpeg;base64,${furniture.avatar}" alt="Avatar" />
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg" alt="Avatar" />
                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                        <a href="javascript:void(0);">${furniture.categoryName}</a>
                                    </td>
                                    <td class="td" title="${furniture.categoryDescription}">
                                            ${furniture.categoryDescription}
                                    </td>

                                    <td>
                                        <fmt:formatNumber value="${furniture.furniturePrice}" pattern="#,###" /> VNĐ
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${furniture.furnitureStatus == 'ON_SALE'}">
                                                <span class="badges bg-lightgreen">Đang giảm giá</span>
                                            </c:when>
                                            <c:when test="${furniture.furnitureStatus == 'OUT_OF_STOCK'}">
                                                <span class="badges bg-lightgrey">Hết Hàng</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badges bg-lightred">Hết giảm giá</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>${furniture.quantity}</td>

                                    <td>
                                        <fmt:formatNumber value="${furniture.totalPrice}" pattern="#,###" /> VNĐ
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <!-- Phân trang -->
                    <div class="container mt-5">
                        <div class="d-flex justify-content-center pagination form-group">
                            <button id="prev-page" type="button" class="btn btn-primary me-2" disabled>&lt;</button>
                            <span id="page-info" class="align-self-center">Page 1 of X</span>
                            <button id="next-page" type="button" class="btn btn-primary ms-2">&gt;</button>
                        </div>
                    </div>
                </div>

            </div>
        </form>
    </div>
</div>
<div class="modal fade" id="feedback">
    <div class="modal-dialog">
        <div class="modal-content" id="feedbackCustomer">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Phản Hồi Của Khách Hàng</h5>
                <button type="button" class="close btn-close-feedback" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p id="feedback-description"></p>
                <div id="feedback-rate">
                </div>
                <div id="imageFeedback" class="margin-top">
                    <!-- Danh sách ảnh sẽ được thêm vào đây bằng JavaScript -->
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-cancel-feedback" data-dismiss="modal">Hủy Thao Tác</button>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="productOfOrderList" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
    <div class="modal-dialog modal-xl w90" role="document">
        <div class="modal-content" id="orderModalContent">
            <div class="modal-header" id="orderModalHeader">
                <h5 class="modal-title" id="modalTitle">Chi Tiết Hóa Đơn</h5>
                <button type="button" class="close btn-close-product" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="orderModalBody">
                <!-- Thông tin thanh toán -->
                <div id="paymentInfo">
                    <h5>Thông Tin Thanh Toán</h5>
                    <table>
                        <tr>
                            <td class="payment-label">Tổng chi phí:</td>
                            <td class="payment-value" id="paymentTotalPrice">13,500,000 VNĐ</td>
                        </tr>
                        <tr>
                            <td class="payment-label">Mã giảm giá:</td>
                            <td class="payment-value" id="paymentCoupon">Giảm giá 5%</td>
                        </tr>
                        <tr>
                            <td class="payment-label">Phương thức thanh toán:</td>
                            <td class="payment-value" id="paymentMethod">Cash on Delivery</td>
                        </tr>
                        <tr>
                            <td class="payment-label">Tiền thanh toán:</td>
                            <td class="payment-value" id="paymentMoney">2,000,000 VNĐ</td>
                        </tr>
                    </table>
                </div>
                <!-- Danh sách sản phẩm -->
                <div id="productList">
                    <h5>Danh Sách Sản Phẩm</h5>
                    <div class="table-responsive1">
                        <table class="table table-bordered1">
                            <thead>
                            <tr>
                                <th>STT</th>
                                <th>Nội Thất</th>
                                <th>Mô Tả</th>
                                <th>Giá Một Sản Phẩm</th>
                                <th>Trạng Thái</th>
                                <th>Số Lượng</th>
                                <th>Tổng Chi Phí</th>
                            </tr>
                            </thead>
                            <tbody id="productOrderTableBody">
                            <!-- Dữ liệu sẽ được điền động từ JavaScript -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="modal-footer" id="orderModalFooter">
                <button type="button" class="btn btn-secondary btn-close-product" data-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal for showing large image -->
<!-- Modal for showing large image -->
<div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="imageModalLabel"></h5>
                <button type="button" class="close btn-close-imageModal" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Ảnh lớn sẽ hiển thị ở đây -->
                <img id="largeImage" src="" alt="Large Feedback Image" class="large-image"/>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="feedbackNull" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="thu">Phản hồi từ khách hàng</h5>
                <button type="button" class="close btn-close-feedbackNull" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <h6>Chưa có phản hồi từ khách hàng.</h6>
                <br>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger btn-close-feedbackNull">Đóng</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="orderNull" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="thu1">Chi Tiết Hóa Đơn </h5>
                <button type="button" class="close btn-close-orderNull" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times; </span>
                </button>
            </div>
            <div class="modal-body">
                <h6>Khách Hàng Chưa Thanh Toán</h6>
                <br>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger btn-close-orderNull">Đóng</button>
            </div>
        </div>
    </div>
</div>
<link rel="stylesheet" href="${pageContext.request.contextPath}/ordercustomer/customer.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/ordercustomer/modelDetailBill.css">
<c:import url="footer.jsp"/>
<script src="${pageContext.request.contextPath}/ordercustomer/pageorderCustomer.js"></script>
<script nonce="<%= cspNonce %>">

    $('#btnSearchfurniture').click(function (e){
        e.preventDefault();

        $('#listForm').submit();
    })
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.btn-close-feedback').forEach(function(btn) {
            btn.addEventListener('click', function() {
                $('#feedback').modal('hide');
            });
        });
    });
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.btn-cancel-feedback').forEach(function(btn) {
            btn.addEventListener('click', function() {
                $('#feedback').modal('hide');
            });
        });
    });
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.btn-close-product').forEach(function(btn) {
            btn.addEventListener('click', function() {
                $('#productOfOrderList').modal('hide');
            });
        });
    });
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.btn-close-imageModal').forEach(function(btn) {
            btn.addEventListener('click', function() {
                $('#imageModal').modal('hide');
            });
        });
    });
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.btn-close-feedbackNull').forEach(function(btn) {
            btn.addEventListener('click', function() {
                $('#feedbackNull').modal('hide');
            });
        });
    });
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.btn-close-orderNull').forEach(function(btn) {
            btn.addEventListener('click', function() {
                $('#orderNull').modal('hide');
            });
        });
    });
</script>