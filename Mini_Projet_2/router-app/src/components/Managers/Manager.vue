<template>
    <div id='manager' class="container">
      <!-- Site: COREUI.IO ------------------------------------------------------------------------------------->
      <div class="row">
        <div>
        <h1 >List {{manager.username}} team</h1>
        <input type="text" placeholder="Recherche" v-model="query">
        </div>
        <br>
        <div v-if="filtreList().length == 0">Pas d'utilisateur : {{query}}</div>

        <div class="col-sm-6 col-lg-4" v-for="u in filtreList()"
             :key="u.id"
             v-show="filtreList().length">
          <div  class="brand-card" >
            <div class="brand-card-body">
              <div>
                <div class="text-value">Name:</div>
                <div class="text-uppercase text-muted small">{{u.username}}</div>
              </div>
              <div>
                <div class="text-value">Email:</div>
                <div class="text-uppercase text-muted small">{{u.email}}</div>
              </div>
            </div>
            <div v-on:click='ejectFromTeam(u.id)'>ritiri</div>
          </div>
        </div>
         <div class="col-sm-6 col-lg-4" v-for="u in extractUser()"
             :key="u.a"
             v-show="extractUser().length">
          <div  class="brand-card" >
            <div class="brand-card-body">
              <div>
                <div class="text-value">Name:</div>
                <div class="text-uppercase text-muted small">{{u.username}}</div>
              </div>
              <div>
                <div class="text-value">Email:</div>
                <div class="text-uppercase text-muted small">{{u.email}}</div>
              </div>
            </div>
            <div v-on:click='addFromTeam(u.id)'>ajouti</div>
          </div>
        </div>
      </div>
      <!-- Site: COREUI.IO ------------------------------------------------------------------------------------->

        <!--<div v-if="!list_user || !list_user.length">No User</div>
        <div>
            <h3>Create a user</h3>
            <input type="text" placeholder="Username" v-model="new_user.username">
            <br>
            <input type="email" placeholder="Email" v-model="new_user.email">
            <br>
            <div style="color:red" v-if="error">
                <span v-for="(value, key) in error"
                :key="key">
                {{key}} {{value}}
                <br>
                </span>
            </div>
            <button v-on:click="createUser()">submit</button>
        </div>-->
    </div>
</template>

<script>
import axios from 'axios';
import router from '../../router/';
import api from '@/api/api';
import auth from '@/services/auth';
import moment from 'moment';
import login from '@/services/login';


export default {
  name: 'Manager',
  props:{   
        selector: 0
    },
  data () {
    return {
      msg: 'Loaad',
      list_user: "lala",
      q: "",
      new_user:{
            username: "",
            email:""
      },
      manager: {},
      error: "",
      bModeTeam: false,
      query:"",
      listUserNotInTeam:"lala",
      intervals: [],
      timers:[],
      associations: null
    }
  },
    //created : component charged, run functions
    created() {
        if (!this.selector){
          this.me = login.getMe();
            var interval;
            interval = setInterval(() => {
                if (this.me.id) {
                    this.id_user = this.me.id;
                    this.manager_id = this.me.id;
                    clearInterval(interval);
                    this.infoRefresh();

                }
            }, 2000);
        } else{
            this.manager_id = this.selector < 0 ? this.selector * -1 : this.selector;
            
            this.me =login.getMe()
            this.infoRefresh();
            console.log(this.me)
        }
    },
  methods: {

    infoRefresh(){

      if(this.me.status == 2 )
        this.getAllUsersByManager();
      this.getAllUsers();
      this.getAss();
    },
    getAllUsers(){
      api.getAllUsers().then( res => {
        this.listUserNotInTeam = res.data.data;

        console.log(this.listUserNotInTeam)
      });
    },
      getAllUsersByManager(){
        axios.get("http://localhost:9050/api/userbymanager/"+this.manager_id, auth.getHeaders())
          .then(result => {
            console.log(result.data)
                this.list_user = result.data.data;
          })

      },
      filtreList(){
        if (this.list_user != "lala"){
          return this.list_user.filter(user => {
            if (this.bModeTeam == true)  
              return user.status == 1 && user.username.toLowerCase().includes(this.query.toLowerCase())
            return user.username.toLowerCase().includes(this.query.toLowerCase()); 
          });
        }
       
        else
          return 0
      },
      extractUser(){
        if (this.listUserNotInTeam != "lala" && this.list_user != "lala")
        {

          let dif = [];
          
          this.listUserNotInTeam.forEach(u => {
            let contain = false;
            this.list_user.forEach(x => {
              if (x.id == u.id){
                contain = true;
                console.log(x.id + " " + u.id)
              }
            })
            if (contain == false)
                dif.push(u)
          })

          return dif
        }else if(this.listUserNotInTeam != "lala" && this.me.status == 1) {

          return this.listUserNotInTeam.filter(user => {
            return user.username.toLowerCase().includes(this.query.toLowerCase());  
          });
        
      }
  

        else return 0
      },
      createUser(){
          axios.post('http://localhost:9050/api/users', {user: this.new_user},  {crossOrigine: true})
          .then((result) => {
                this.error = "";
                this.list_user = result.data.data;
                this.getAllUsers();
          })
          .catch((err, data) => {
              this.error = err.response.data.errors;
          });
      },
      deleteUser(id, event){
          if (event) event.preventDefault()
          api.deleteUser(id).then( () => {
          this.getAllUsers();
        });
      },
      getAss(){
        axios.get("http://localhost:9050/api/ass", auth.getHeaders()).then(res =>{
            this.associations = res.data.data;
        });
      },

      getClocks(){
        this.list_user.forEach(user => {
          api.getClock(user.id)
          .then((res) => {
            console.log(res)
            if (res.data.data){
              this.timers[user.id] = "co"
            }else {
              this.timers[user.id] = 'déco'
            }
          });
        });
      },
      timer(id){
        return this.timers[id];
      },
      navigate(id){
        this.$emit('childToParent',id);
          //router.push({name: "user", params: {id: id}})
      },
      addFromTeam(id){
        console.log(this.manager_id)
        let ass= {
          "id_user": id,
          "id_manager": this.manager_id
        }
        console.log(ass)  
        axios.post("http://localhost:9050/api/ass",{ association : ass}, auth.getHeaders())
        .then( (res) => {
            this.infoRefresh();
        })
      },
      ejectFromTeam(id){
          let asso = null;

          this.associations.forEach( ass => {
            console.log(ass.id_manager + " " + ass.id_user)
            console.log(this.manager_id + " " + id);
            if (ass.id_manager == this.manager_id && ass.id_user == id){
              console.log(ass);
              asso = ass;
            }
          });
  
        axios.delete("http://localhost:9050/api/ass/" + asso.id, auth.getHeaders())
        .then(() => this.infoRefresh())
      }
  }
}
</script>

<style>
  #users {
    Margin-top: 3%;
  }

  .container {
    background-color: #919191;
    width: 100%;
    box-shadow: -1px 2px 5px 1px rgba(0, 0, 0, 0.7);
    padding: 50px;
  }
</style>
