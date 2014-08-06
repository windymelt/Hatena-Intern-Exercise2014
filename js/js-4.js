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
    });
}

// incremenral search
$('#query').keyup(function(){
    console.log('query keyup');
    if(! $(this).val()){
	console.log('no query');
	$('#table tbody tr').unhighlight();
	$('#table tbody tr').show();
    } else {
	console.log('query found: ' + this.value);
	$('#table tbody tr').hide();
	var queries = $.trim(this.value).split(' ');
	// remove last empty element

	var queriesString = ':not(:not(tr:contains(' + queries.join(')), :not(tr:contains(') + ')))';
	console.log('qstr: ' + queriesString);
	$('#table tbody ' + queriesString).show();
	$('#table tbody tr').unhighlight();
	$('#table tbody').highlight(queries, {caseSensitive: true});
    }
})

