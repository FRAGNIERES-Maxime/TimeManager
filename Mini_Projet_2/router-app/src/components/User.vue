<template>
    <div id='user'>
        <p>
          User : {{user.username}}
        </p>
        <p>
          email : {{user.email}}
        </p>
    <router-link :to="{ name: 'users' }">back</router-link>
    </div>
</template>

<script>
import axios from 'axios'
export default {
  name: 'User',
  data () {
    return {
      msg: 'coucou',
      id_user: 0,
      user:{
        username:"",
        email:""
      }
    }
  },
   watch: {
      '$route': 'getMeteo'
    },
    created() {
      this.id_user = this.$router.currentRoute.params.id;
      this.getUser();
    },
  methods: {
      getUser(){
        axios.get('http://localhost:4000/api/users/'+this.id_user, {crossOrigine: true})
          .then(result => {
                this.user = result.data.data;
          }, (err) => {
            this.$router.push("/");
          })
      }
  }
}
</script>