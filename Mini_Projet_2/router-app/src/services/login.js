import axios from 'axios';
import router from '@/router';
import auth from '@/services/auth';


var login = {
    me : null,
    getLogin(){
        console.log(auth.token)
        if (auth.isAuth()){
            axios.get('http://localhost:9050/api/me', auth.getHeaders())
            .then(res => {
                Object.assign(this.me, res.data);
                // redir vers les bonne routes 
                if (this.me.status == 0){
                    //nouveau composant employer
                } else if (this.me.status == 1){
                    //nouveau composant manager
                }else{
                    //nouveau composant admin
                }
            }).catch(err => {
                console.log(err);
            });
        } else {
            router.push("/login");
        }
    },
    getMe(){
        if (this.me == null)
            this.me = new Object();
        if (this.me.status == undefined)
            this.getLogin();
        return this.me;
    },
    logOut(){
        auth.logOut();
        localStorage.removeItem("token-auth");
        router.push("/login");
    }
}

export default login;