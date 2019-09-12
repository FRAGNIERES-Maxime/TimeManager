<template>
    <div id='users'>
        <input type="text" placeholder="Search ..." v-model="q" v-on:keyup="getAllUsers()"/>
        <br>
        <br>
        <br>
        <ul v-if="list_user && list_user.length">
            <li v-for="u in list_user"
                :key="u.id"
                >
                <span v-on:click="navigate(u.id)">username : {{u.username}} - {{u.email}}</span>
                <button v-on:click="deleteUser(u.id)">x</button>
                
            </li>
        </ul>
        <div v-if="!list_user || !list_user.length">No User</div>
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
        </div>
    </div>
</template>

<script>
import axios from 'axios'
import router from '../router/'
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
      error: ""
    }
  },
   watch: {
      '$route': 'getAllUsers'
    },
    created() {
      this.getAllUsers()
    },
  methods: {
      getAllUsers(){
          axios.get('http://localhost:4000/api/users?email=&username='+this.q, {crossOrigine: true})
          .then(result => {
                this.list_user = result.data.data;
                
          })
          
      },
      createUser(){
          axios.post('http://localhost:4000/api/users', {user: this.new_user},  {crossOrigine: true})
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
          axios.delete('http://localhost:4000/api/users/'+id ,  {crossOrigine: true})
          .then(result => {
                this.list_user = result.data.data;
                this.getAllUsers()
          })
      },
      navigate(id){
          router.push({name: "user", params: {id: id}})
      }
  }
}
</script>