<template>
    <div id='user'>
        <p>
          User : {{user.username}}
        </p>
        <p>
          email : {{user.email}}
        </p>
        <p>p {{since}}</p>
        <button @click="postClock()">active désactive</button>
        <div v-for="w in list_work"
          :key="w.id">
          {{w}}
          </div>
    <router-link :to="{ name: 'users' }">back</router-link>
    </div>
</template>

<script>
import axios from 'axios'
import moment from 'moment'

export default {
  name: 'User',
  data () {
    return {
      msg: 'coucou',
      id_user: 0,
      user:{
        username:"",
        email:""
      },
      since: "",
      intervalclock: 0,
      list_work: []

    }
  },
   watch: {
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
                this.getClock()
          }, (err) => {
            this.$router.push("/");
          })
      },
      getClock(){
        axios.get('http://localhost:4000/api/clocks/'+this.id_user, {crossOrigine: true})
        .then(res => {
          if (res.data.data){
            this.intervalclock = setInterval(() =>
            this.since = moment(moment().diff(res.data.data.clock)).format('HH-mm-ss'),
            1000);
          }
          else {
            this.since = "déconnecter"
            clearInterval(this.intervalclock)
          }
          this.getListWork();
        })
      },
      postClock(){
        axios.post('http://localhost:4000/api/clocks/'+this.id_user, {crossOrigine: true})
          .then(res => {
              this.getClock()
          })
      },
      getListWork(){
        axios.get('http://localhost:4000/api/workingtimes/'+this.id_user, {crossOrigine: true})
          .then(res => {
            this.list_work = res.data.data;
          })
      }

  }
}
</script>

<style>
  #user {
    margin-top: 2%;
  }
</style>
