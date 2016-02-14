
	
function events(dhxTabbar1){
dhxTabbar1.attachEvent("onContentLoaded", function(id){
  
        var loadcredentials=setInterval(function () { setcredentialsSync()}, 15000);
        
                
	 	/*switch(id){
	 	case 'highsc/com/products|Papers':
		 var loadhighsccomproductsPapers=setInterval(function () {sethighsccomproductsPapersSync()}, 15000);
	     break;
	 	case 'highsc/com/productcategory|Subjects':
	 	 var loadhighsccomproductcategorysubjects=setInterval(function () {sethighsccomproductcategorysubjectsSync()}, 4000);
		break;
	 	case 'highsc/com/employees|Teachers':
	 	 var loadhighsccomemployeesTeachers=setInterval(function () { sethighsccomemployeesTeachersSync()}, 8000);
	 	break;
	 	}*/
	 	
	
	 /*******************ON CLOSING THE TAB******************* */
	 	dhxTabbar1.attachEvent("onTabClose", function(id){
                    
                 
                    window.clearInterval(loadcredentials);
	 		/*switch(id){
		 	case 'highsc/com/products|Papers':
		 		
		 		window.clearInterval(loadhighsccomproductsPapers);
			 break;
		 	case 'highsc/com/productcategory|Subjects':
		 		
		 		window.clearInterval(loadhighsccomproductcategorysubjects);
			break;
		 	case 'highsc/com/employees|Teachers':
		 		window.clearInterval(loadhighsccomemployeesTeachers);
		 	break;
		 	}*/

		 return true;
		 	
	 });


	 return true;
	 
	 });

}

