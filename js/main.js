// 課題 JS-1: 関数 `parseLTSVLog` を記述してください
function parseLTSVLog(logStr){
    if(! logStr instanceof String){
	throw new InvalidArgumentsException('Argument logStr must be String');
    }
    
    // empty input, empty array
    if(logStr == ""){ return []; }

    var logStrLines = logStr.split("\n");
    var parsedLogs = [];
    
    logStrLines.forEach(function(aLine){
	if(aLine != ''){
	    var logHashTable = new Object();
	    var tabSplitedElements = aLine.split("\t");

	    tabSplitedElements.forEach(function(anElement){
		// keyValuePair[0]:keyValuePair[1] == hoge:piyo
		var keyValuePair = anElement.split(':');
		
		// when key equals 'reqtime_microsec', treat value as Int
		if(keyValuePair[0] == 'reqtime_microsec'){
		    logHashTable[keyValuePair[0]] = parseInt(keyValuePair[1]);
		}else{
		    logHashTable[keyValuePair[0]] = keyValuePair[1];
		}
	    })
	    
	    // push one hashtable into the array
	    parsedLogs.push(logHashTable);
	}})
    return parsedLogs;
}
// 課題 JS-2: 関数 `createLogTable` を記述してください
function createLogTable(divDOM, parsedLTSV){
    var tableDOM = divDOM.appendChild(document.createElement('table'));
    tableDOM.id = 'table';
    var theadDOM = tableDOM
	.appendChild(document.createElement('thead'))
	.appendChild(document.createElement('tr'));
    
    for(key in parsedLTSV[0]) {
	theadDOM.appendChild(document.createElement('th')).innerHTML = key;
    }
    
    var tbodyDOM = divDOM.firstChild.appendChild(document.createElement('tbody'));
    
    parsedLTSV.forEach(function(anHashTable){
	var trDOM = tbodyDOM.appendChild(document.createElement('tr'));
	for(key in anHashTable){
	    trDOM.appendChild(document.createElement('td')).innerHTML = anHashTable[key];
	}
    })
}

