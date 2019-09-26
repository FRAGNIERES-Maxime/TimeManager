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
                this.goDashboard()
            }).catch(err => {
                console.log(err);
            });
        }
    },
    getMe(){
        if (this.me == null){
            this.me = new Object();
            this.me.id = 0;
        }
        if (this.me.status == undefined)
            this.getLogin();
        return this.me;
    },
    logOut(){
        auth.logOut();
        localStorage.removeItem("token-auth");
        router.push("/login");
    },
    goDashboard(){
        if (this.me.status == 0){
            router.push("/employe");
        } else if (this.me.status == 1){
            //nouveau composant manager
        }else{
            //nouveau composant admin
        }
    }
}

export default login;