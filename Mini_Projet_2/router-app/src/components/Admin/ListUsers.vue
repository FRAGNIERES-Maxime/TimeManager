<template>
    <div id='users' class="container">
      <!-- Site: COREUI.IO ------------------------------------------------------------------------------------->
      <div class="row">
        <div>
        <h1 v-if="!bModeTeam">List employer</h1>
        <h1 v-if="bModeTeam">List Manager/teams</h1>
        <input type="text" placeholder="Recherche" v-model="query">
        <span v-on:click="bModeTeam=!bModeTeam"> toggle</span>
        </div>
        <br>
        <div v-if="filtreList().length == 0">Pas d'utilisateur : {{query}}</div>

        <div class="col-sm-6 col-lg-4" v-for="u in filtreList()"
             :key="u.id"
             v-show="filtreList().length">
          <div  class="brand-card" v-on:click="navigate(u.id)">
            <div class="brand-card-header bg-success">
              <h3>{{timer(u.id)}}</h3>
            </div>
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
            <div v-on:click='deleteUser(u.id)'><img src="../../assets/delete.png"></div>
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

export default {
  name: 'Users',
  data () {
    return {
      msg: 'Loaad',
      list_user: "lala",
      q: "",
      new_user:{
            username: "",
            email:""
      },
      error: "",
      bModeTeam: false,
      query:"",
      intervals: [],
      timers:[]
    }
  },
   watch: {
      '$route': 'getAllUsers'
    },
    //created : component charged, run functions
    created() {
      this.getAllUsers()
    },
  methods: {
      getAllUsers(){
        console.log(auth.getHeaders());
          api.getAllUsers()
          .then(result => {
                this.list_user = result.data.data;
                console.log(result);
                this.list_user.forEach(u => this.timers[u.id] = "déco")
                this.getClocks();
          })

      },
      filtreList(){
        if (this.list_user != "lala")
          return this.list_user.filter(user => {
            if (this.bModeTeam == true)  
              return user.status == 1 && user.username.toLowerCase().includes(this.query.toLowerCase())
            return user.username.toLowerCase().includes(this.query.toLowerCase()); 
          });
        else
          return "lala"
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
          //router.push({name: "user", params: {id: id}})
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
