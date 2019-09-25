var auth = {
    token:localStorage.getItem("token-auth"),
    setToken(_token){
        this.token =  _token;
        localStorage.setItem("token-auth", _token);
        console.log(_token);
    },
    getToken(){
        return this.token;
    },
    getHeaders(){
        if (this.token){
            return ({ headers : { 'Authorization': 'Bearer ' + this.token}})
        }else{
            console.log("No Token");
            return "";
        }
    },
    isAuth(){
        return ((this.token) != null);
    },
    logOut(){
        this.token = null;
        localStorage.removeItem("token-auth");
    }

}

export default auth;