// admin_02_classManagement_script.js
$(document).ready(function() {

    // 반 구성원 이동
    // 선택가능한인원 > 기존인원
    $(".selectBtn").click(function() {
        var checkbox1 = $("#result1 input[name=user_CheckBox]:checked");

        checkbox1.each(function(i) {
            var tr1 = checkbox1.parent().parent();
            var td1 = tr1.children();

            tr1.appendTo('#result2').find('input[name=user_CheckBox]').prop("checked", false);
        });
    });
    // 선택가능한인원 > 기존인원 끝

    // 기존인원 > 선택가능한인원
    $(".backBtn").click(function() {
        var checkbox2 = $("#result2 input[name=user_CheckBox]:checked");

        checkbox2.each(function(i) {
            var tr2 = checkbox2.parent().parent();
            var td2 = tr2.children();

            tr2.appendTo('#result1').find('input[name=user_CheckBox]').prop("checked", false);
        });
    });
    // 기존인원 > 선택가능한인원 끝
    // 반 구성원 이동 끝 (출처 https://all-record.tistory.com/172)

    // 테이블 헤더(이름) 클릭시 오름차순 정렬
    $('table.table').each(function() {
        var $table = $(this);

        $('th', $table).each(function(column) {
            if ($(this).is('.sortThis')) {
                var direction = -1;
                $(this).click(function() {
                    direction = -direction;
                    var rows = $table.find('tbody > tr').get();

                    rows.sort(function(a, b) {
                        var keyA = $(a).children('td').eq(column).text().toUpperCase();
                        var keyB = $(b).children('td').eq(column).text().toUpperCase();

                        if (keyA < keyB) return -direction;
                        return 0;
                    });
                    $.each(rows, function(index, row) {
                        $table.children('tbody').append(row)
                    });
                });
            };
        });
    });
    // 테이블 헤더(이름) 클릭시 오름차순 정렬 끝

});
