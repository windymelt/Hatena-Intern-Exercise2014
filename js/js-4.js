// Work JS-4
// status:200	method:GET	path:/keyword	reqtime_microsec:819146

// do only if 'submit-button' is defined to avoid an error when testing
if(document.getElementById('submit-button')){
// when submit-button is clicked
    document.getElementById('submit-button').addEventListener('click', function(){
	var tableContainerDOM = document.getElementById('table-container');
	var LTSVText = document.getElementById('log-input').value;
	// clearing div for the table
	tableContainerDOM.innerHTML = '';
	createLogTable(tableContainerDOM, parseLTSVLog(LTSVText));
	//jQuery(function(){
	//    $('#table').tablesorter();
	//});
    });
}

// incremenral search
$('#query').keyup(function(){
    console.log('query keyup');
    if(! $(this).val()){
	console.log('no query');
	$('#table tbody tr').show();
    } else {
	console.log('query found');
	$('#table tbody tr').hide();
	$('#table tbody tr:contains(' + this.value + ')').show();
    }
})

