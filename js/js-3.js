// 課題 JS-3 の実装をここに記述してください。

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

