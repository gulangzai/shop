/**
 * Created by Administrator on 2017/2/15.
 */
$(document).ready(function () {
    $('#myModal').modal({
        backdrop: 'static',
        show:false
    });
    $('#sidebar-collapse').click(function () {//??????????????~?????????????~????????????//
        if($(this).children('i').is('.fa-angle-double-left')){
            $(this).css({
                'text-align':'left',
                'margin-left':'10px'
            });
            $('#sidebar-shortcuts').text(' ').removeClass('sidebar-shortcuts').addClass('sidebar-shortcuts_tab');
            $('#rightBox').width(($(document).width() - 40) + 'px').css({'float':'none', 'left':'40px'});
            $('#rightBox .rightBox_Top span').css('margin-left','-140px');
            $('.rightBox_Content').width(($('#rightBox').width()-20)+'px');
            $(this).children('i').removeClass('fa-angle-double-left').addClass('fa-angle-double-right');
            $('.nav>li').hover(
                function(){
                    $(this).find('.submenu_tab').css('display','block')
                },
                function () {
                    $(this).find('.submenu_tab').css('display','none')
                })
        }else if($(this).children('i').is('.fa-angle-double-right')){
            $(this).css({
                'text-align':'center',
                'margin-left':'0'
            });
            $('#sidebar-shortcuts').text('????????????').removeClass('sidebar-shortcuts_tab').addClass('sidebar-shortcuts');
            $('#rightBox').width(($(document).width() - 160) + 'px').css({'float':'left', 'left':'0px'});
            $('#rightBox .rightBox_Top span').css('margin-left','30px');
            $('.rightBox_Content').width(($('#rightBox').width()-20)+'px');
            $(this).children('i').removeClass('fa-angle-double-right').addClass('fa-angle-double-left');
            $('.nav>li').hover(
                function(){
                    $(this).find('.submenu_tab').css('display','none')
                })
        }
    });
    //$('#33').find('.menu-text').addClass('active2');//ҳ���ʼ��������~�ȸ����˵���ҳ2���ּӸ���ɫ
    $('.nav-list a').click(function () {
        $('.nav-list a').children('.menu-text').removeClass('active2');
        // var time = new Date().getTime();
        // console.log(time);
        $(this).children('.menu-text').addClass('active2');
        // console.log($(this).parents('li').attr('id'))
        window.localStorage['active'] = $(this).parents('li').attr('id')
        // $('#'+$(this).attr('data_name')).show().siblings().hide();
    });
    //$('#' + window.localStorage['active']).find('.menu-text').addClass('active2')

    $('#leftMenu_ul>li[grade="1"]>a').click(function () {
        // $(this).parent().siblings().removeClass('open');
        // $(this).parent().addClass('open');
        // alert(2323);
        // $(this).parent().siblings().find('.Add').text('+');
        //
        // // alert(1)
        // // $(this).siblings('.submenu').addClass('nav-show').parent().siblings().find('.submenu').removeClass('nav-show').addClass('nav-hide');
        // // alert(2)
        // if($(this).parent().is('.open')&&$(this).siblings('.submenu').is('nav-show')){
        //
        //     $(this).children('.Add').text('-');
        //     alert(3)
        //     // $(this).siblings('.submenu').css('display','none');
        //
        // }else{
        //     $(this).children('.Add').text('+');
        //     // $(this).siblings('.submenu').css('display','block');
        //     alert(4)
        // }
    });

    $(".rightBox_Content_middle").on('click','i',function(){
        if($(this).is('.check')){
            $(this).removeClass('check').addClass('check_click');
        }else if($(this).is('.check_click')){
            $(this).removeClass('check_click').addClass('check');
        }
    });
    $("#informationBox4").on('click','i',function(){
        if($(this).is('.check')){
            $(this).removeClass('check').addClass('check_click');
        }else if($(this).is('.check_click')){
            $(this).removeClass('check_click').addClass('check');
        }
    });


    $('#pager span a').click(function () {
        $(this).addClass('active1').parent().siblings().children().removeClass('active1');
    })
});