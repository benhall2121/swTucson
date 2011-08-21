// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
       $('.date_picker_field').datepicker();
       
       $(".remove_fields_be_gone").live("click", function(){
       	  $(this).parent().find("input[type=hidden]").val(1);
       	  $(this).parent().hide();
       });
       
       $("#users_search input").keyup(function() {
          $.get($("#users_search").attr("action"), $("#users_search").serialize(), null, "script");
          return false;
       });
       
       $("#users_search input").click(function() {
          $.get($("#users_search").attr("action"), $("#users_search").serialize(), null, "script");
          return false;
       });
});		
		
function remove_fields(link) {
  $(link).previous("input[type=hidden]").value = "1";
  $(link).up(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().parent().before(content.replace(regexp, new_id));
}
