<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Print Bill - PahanaEdu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8f9fa;
        }

        .print-container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        .bill-header {
            background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }

        .bill-content {
            padding: 2rem;
        }

        .bill-info {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .bill-table {
            width: 100%;
            border-collapse: collapse;
            margin: 2rem 0;
        }

        .bill-table th,
        .bill-table td {
            border: 1px solid #dee2e6;
            padding: 12px;
            text-align: left;
        }

        .bill-table th {
            background: #f8f9fa;
            font-weight: 600;
        }

        .bill-total {
            background: #28a745;
            color: white;
            padding: 1rem;
            border-radius: 10px;
            text-align: right;
            font-size: 1.2rem;
            font-weight: bold;
        }

        .action-buttons {
            margin-top: 2rem;
            text-align: center;
        }

        .btn {
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            padding: 0.5rem 1.5rem;
            margin: 0 0.5rem;
        }

        .btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .btn-primary {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            border: none;
        }

        .btn-success {
            background: linear-gradient(135deg, #27ae60 0%, #229954 100%);
            border: none;
        }

        @media print {
            body {
                background: white;
            }
            .print-container {
                box-shadow: none;
                border-radius: 0;
            }
            .action-buttons {
                display: none;
            }
            .no-print {
                display: none;
            }
        }

        .no-print {
            display: block;
        }
    </style>
</head>
<body>
    <div class="container-fluid py-4">
        <div class="print-container">
            <!-- Bill Header -->
            <div class="bill-header">
                <h1><i class="fas fa-graduation-cap"></i> PahanaEdu Bookshop</h1>
                <h2>Bill Receipt</h2>
                <p class="mb-0">Quality Education, Quality Books</p>
            </div>

            <!-- Bill Content -->
            <div class="bill-content">
                <!-- Success Message -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i> ${success}
                    </div>
                </c:if>

                <!-- Bill Information -->
                <div class="bill-info">
                    <div class="row">
                        <div class="col-md-6">
                            <h5><i class="fas fa-file-invoice"></i> Bill Details</h5>
                            <p><strong>Bill Number:</strong> ${bill.billNumber}</p>
                            <p><strong>Bill Date:</strong> <fmt:formatDate value="${bill.billDate}" pattern="dd/MM/yyyy"/></p>
                            <p><strong>Status:</strong> <span class="badge bg-${bill.status eq 'pending' ? 'warning' : 'success'}">${bill.status}</span></p>
                        </div>
                        <div class="col-md-6">
                            <h5><i class="fas fa-user"></i> Customer Information</h5>
                            <c:if test="${not empty customer}">
                                <p><strong>Name:</strong> ${customer.name}</p>
                                <p><strong>Account Number:</strong> ${customer.accountNumber}</p>
                                <p><strong>Address:</strong> ${customer.address}</p>
                                <p><strong>Telephone:</strong> ${customer.telephone}</p>
                            </c:if>
                        </div>
                    </div>
                </div>

                <!-- Bill Items Table -->
                <h5><i class="fas fa-list"></i> Bill Items</h5>
                <table class="bill-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Item Code</th>
                            <th>Quantity</th>
                            <th>Unit Price</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="billItem" items="${billItems}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${billItem.itemCode}</td>
                                <td>${billItem.quantity}</td>
                                <td>$<fmt:formatNumber value="${billItem.unitPrice}" pattern="#,##0.00"/></td>
                                <td>$<fmt:formatNumber value="${billItem.totalPrice}" pattern="#,##0.00"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- Bill Total -->
                <div class="bill-total">
                    <h4>Total Amount: $<fmt:formatNumber value="${bill.totalAmount}" pattern="#,##0.00"/></h4>
                </div>

                <!-- Action Buttons -->
                <div class="action-buttons no-print">
                    <button type="button" class="btn btn-primary" onclick="window.print()">
                        <i class="fas fa-print"></i> Print Bill
                    </button>
                    
                    <a href="${pageContext.request.contextPath}/dashboard.jsp" class="btn btn-secondary">
                        <i class="fas fa-home"></i> Back to Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
