function apriNavBar(){
    let nav = document.querySelector(".navigationBar");

    if(nav.classList.contains("navigationBarActivator")){
        nav.classList.remove("navigationBarActivator");
    }else{
        nav.classList.add("navigationBarActivator");
    }
};

let inputTextSearchBar = document.getElementById("searchInput");

inputTextSearchBar.addEventListener('focus', function (){
    document.querySelector(".utility").style.width = "90%";
    inputTextSearchBar.style.visibility = "visible";
    inputTextSearchBar.style.width = "90%";
    document.querySelector(".searchButton").style.borderRadius = "0px 10px 10px 0px";
});

inputTextSearchBar.addEventListener('blur', function (){
    document.querySelector(".utility").style.width = "30%";
    inputTextSearchBar.style.visibility = "hidden";
    inputTextSearchBar.style.width = "0";
    document.querySelector(".searchButton").style.borderRadius = "100%";
});

function searchProduct(){
    document.querySelector(".searchBox").submit();
}