<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 이동준
  Date: 2021-08-19
  Time: 오후 11:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="/resources/jquery/jquery.twbsPagination.min.js"></script>
<html>
<head>
    <title>Title</title>
    <!-- overlayScrollbars -->
    <link rel="stylesheet" href="/resources/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
</head>
<body>

<div class="content-wrapper" style="min-height: 1113.69px;">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>DataTables</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                        <li class="breadcrumb-item active">DataTables</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">DataTable with default features</h3>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div id="example1_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                <div class="row">
                                    <div class="col-sm-12 col-md-6">
                                        <div class="dt-buttons btn-group flex-wrap">
                                            <button class="btn btn-secondary buttons-copy buttons-html5" tabindex="0"
                                                    aria-controls="example1" type="button"><span>Copy</span></button>
                                            <button class="btn btn-secondary buttons-csv buttons-html5" tabindex="0"
                                                    aria-controls="example1" type="button"><span>CSV</span></button>
                                            <button class="btn btn-secondary buttons-excel buttons-html5" tabindex="0"
                                                    aria-controls="example1" type="button"><span>Excel</span></button>
                                            <button class="btn btn-secondary buttons-pdf buttons-html5" tabindex="0"
                                                    aria-controls="example1" type="button"><span>PDF</span></button>
                                            <button class="btn btn-secondary buttons-print" tabindex="0"
                                                    aria-controls="example1" type="button"><span>Print</span></button>
                                            <div class="btn-group">
                                                <button class="btn btn-secondary buttons-collection dropdown-toggle buttons-colvis"
                                                        tabindex="0" aria-controls="example1" type="button"
                                                        aria-haspopup="true" aria-expanded="false"><span>Column visibility</span>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 col-md-6">
                                        <div id="example1_filter" class="dataTables_filter"><label>Search:<input
                                                type="search" class="form-control form-control-sm" placeholder=""
                                                aria-controls="example1"></label></div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <table id="example1"
                                               class="table table-bordered table-striped dataTable dtr-inline"
                                               role="grid" aria-describedby="example1_info">
                                            <thead>
                                            <tr role="row">
                                                <th class="sorting sorting_asc" tabindex="0" aria-controls="example1"
                                                    rowspan="1" colspan="1" aria-sort="ascending"
                                                    aria-label="Rendering engine: activate to sort column descending">
                                                    Rendering engine
                                                </th>
                                                <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1"
                                                    colspan="1" aria-label="Browser: activate to sort column ascending">
                                                    Browser
                                                </th>
                                                <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1"
                                                    colspan="1"
                                                    aria-label="Platform(s): activate to sort column ascending">
                                                    Platform(s)
                                                </th>
                                                <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1"
                                                    colspan="1"
                                                    aria-label="Engine version: activate to sort column ascending">
                                                    Engine version
                                                </th>
                                                <th class="sorting" tabindex="0" aria-controls="example1" rowspan="1"
                                                    colspan="1"
                                                    aria-label="CSS grade: activate to sort column ascending">CSS grade
                                                </th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr class="odd">
                                                <td class="sorting_1 dtr-control" tabindex="0">Presto</td>
                                                <td>Nintendo DS browser</td>
                                                <td>Nintendo DS</td>
                                                <td>8.5</td>
                                                <td>C/A<sup>1</sup></td>
                                            </tr>
                                            <tr class="even">
                                                <td class="sorting_1 dtr-control" tabindex="0">Tasman</td>
                                                <td>Internet Explorer 4.5</td>
                                                <td>Mac OS 8-9</td>
                                                <td>-</td>
                                                <td>X</td>
                                            </tr>
                                            <tr class="odd">
                                                <td class="sorting_1 dtr-control" tabindex="0">Tasman</td>
                                                <td>Internet Explorer 5.1</td>
                                                <td>Mac OS 7.6-9</td>
                                                <td>1</td>
                                                <td>C</td>
                                            </tr>
                                            <tr class="even">
                                                <td class="sorting_1 dtr-control" tabindex="0">Tasman</td>
                                                <td>Internet Explorer 5.2</td>
                                                <td>Mac OS 8-X</td>
                                                <td>1</td>
                                                <td>C</td>
                                            </tr>
                                            <tr class="odd">
                                                <td class="dtr-control sorting_1" tabindex="0">Trident</td>
                                                <td>Internet
                                                    Explorer 4.0
                                                </td>
                                                <td>Win 95+</td>
                                                <td> 4</td>
                                                <td>X</td>
                                            </tr>
                                            <tr class="even">
                                                <td class="dtr-control sorting_1" tabindex="0">Trident</td>
                                                <td>Internet
                                                    Explorer 5.0
                                                </td>
                                                <td>Win 95+</td>
                                                <td>5</td>
                                                <td>C</td>
                                            </tr>
                                            <tr class="odd">
                                                <td class="dtr-control sorting_1" tabindex="0">Trident</td>
                                                <td>Internet
                                                    Explorer 5.5
                                                </td>
                                                <td>Win 95+</td>
                                                <td>5.5</td>
                                                <td>A</td>
                                            </tr>
                                            <tr class="even">
                                                <td class="dtr-control sorting_1" tabindex="0">Trident</td>
                                                <td>Internet
                                                    Explorer 6
                                                </td>
                                                <td>Win 98+</td>
                                                <td>6</td>
                                                <td>A</td>
                                            </tr>
                                            <tr class="odd">
                                                <td class="dtr-control sorting_1" tabindex="0">Trident</td>
                                                <td>Internet Explorer 7</td>
                                                <td>Win XP SP2+</td>
                                                <td>7</td>
                                                <td>A</td>
                                            </tr>
                                            <tr class="even">
                                                <td class="dtr-control sorting_1" tabindex="0">Trident</td>
                                                <td>AOL browser (AOL desktop)</td>
                                                <td>Win XP</td>
                                                <td>6</td>
                                                <td>A</td>
                                            </tr>
                                            </tbody>
                                            <tfoot>
                                            <tr>
                                                <th rowspan="1" colspan="1">Rendering engine</th>
                                                <th rowspan="1" colspan="1">Browser</th>
                                                <th rowspan="1" colspan="1">Platform(s)</th>
                                                <th rowspan="1" colspan="1">Engine version</th>
                                                <th rowspan="1" colspan="1">CSS grade</th>
                                            </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12 col-md-5">
                                        <div class="dataTables_info" id="example1_info" role="status"
                                             aria-live="polite">Showing 41 to 50 of 57 entries
                                        </div>
                                    </div>
                                    <div class="col-sm-12 col-md-7">
                                        <div class="dataTables_paginate paging_simple_numbers" id="example1_paginate">
                                            <ul class="pagination">
                                                <li class="paginate_button page-item previous" id="example1_previous"><a
                                                        href="#" aria-controls="example1" data-dt-idx="0" tabindex="0"
                                                        class="page-link">Previous</a></li>
                                                <li class="paginate_button page-item "><a href="#"
                                                                                          aria-controls="example1"
                                                                                          data-dt-idx="1" tabindex="0"
                                                                                          class="page-link">1</a></li>
                                                <li class="paginate_button page-item "><a href="#"
                                                                                          aria-controls="example1"
                                                                                          data-dt-idx="2" tabindex="0"
                                                                                          class="page-link">2</a></li>
                                                <li class="paginate_button page-item "><a href="#"
                                                                                          aria-controls="example1"
                                                                                          data-dt-idx="3" tabindex="0"
                                                                                          class="page-link">3</a></li>
                                                <li class="paginate_button page-item "><a href="#"
                                                                                          aria-controls="example1"
                                                                                          data-dt-idx="4" tabindex="0"
                                                                                          class="page-link">4</a></li>
                                                <li class="paginate_button page-item active"><a href="#"
                                                                                                aria-controls="example1"
                                                                                                data-dt-idx="5"
                                                                                                tabindex="0"
                                                                                                class="page-link">5</a>
                                                </li>
                                                <li class="paginate_button page-item "><a href="#"
                                                                                          aria-controls="example1"
                                                                                          data-dt-idx="6" tabindex="0"
                                                                                          class="page-link">6</a></li>
                                                <li class="paginate_button page-item next" id="example1_next"><a
                                                        href="#" aria-controls="example1" data-dt-idx="7" tabindex="0"
                                                        class="page-link">Next</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container-fluid -->
    </section>
    <!-- /.content -->
</div>


<script type="text/javascript">
    if ($('#pagination').data("twbs-pagination")) {
        $('#pagination').twbsPagination('destroy');
    }

    $("#pagination").twbsPagination({
        startPage: 1,
        totalPages: 6, //전체 페이지
        visiblePages: 10, //최대로 보여줄 페이지
        first: '<span sria-hidden="true">«</span>',
        prev: "이전",
        next: "다음",
        last: '<span sria-hidden="true">»</span>',
        initiateStartPageClick: false,
        onPageClick: function (event, page) {
            /*location.href = "/account/community.do?bbstype=" + '
            ${bbstype}' + "&pageNumber=" + (page - 1);*/
        }
    });
</script>
<!-- jQuery -->
<script src="/resources/plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="/resources/plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Bootstrap 4 -->
<script src="/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- DataTables  & Plugins -->
<script src="/resources/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="/resources/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="/resources/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="/resources/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
<script src="/resources/plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
<script src="/resources/plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
<script src="/resources/plugins/jszip/jszip.min.js"></script>
<script src="/resources/plugins/pdfmake/pdfmake.min.js"></script>
<script src="/resources/plugins/pdfmake/vfs_fonts.js"></script>
<script src="/resources/plugins/datatables-buttons/js/buttons.html5.min.js"></script>
<script src="/resources/plugins/datatables-buttons/js/buttons.print.min.js"></script>
<script src="/resources/plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
<!-- AdminLTE App -->
<script src="/resources/dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="/resources/dist/js/demo.js"></script>
<!-- Page specific script -->
<script>

    $(function () {
        $("#example1").DataTable({
            "responsive": true, "lengthChange": false, "autoWidth": false,
            "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
        }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
    });
</script>


</body>
</html>
