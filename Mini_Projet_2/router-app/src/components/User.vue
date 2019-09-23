<template>
  <div id='user' class="container">
    <div>
      <router-link id="btn-back" class="btn btn-dark" :to="{ name: 'users' }">Back to Users List</router-link>
    </div>
    <div class="row">
      <div id="identity" class="col-md-6">
        <form>
          <div class="form-group">
            User: {{user.username}}
          </div>
          <div class="form-group">
            Email: {{user.email}}
          </div>
          <div class="form-group">
            <select>
              <option>Manager</option>
              <option>Admin</option>
              <option>Employer</option>
            </select>
          </div>
          <div class="form-group">
            <select>
              <option>TEAM (Back a lié)</option>
            </select>
          </div>
          <div class="form-group">
            <button id="submit" class="btn btn-dark" type="submit">Submit</button>
          </div>
        </form>
      </div>


      <!------------------------------------- https://apexcharts.com/docs/vue-charts/ ------------------------------------------>
      <div class="col-md-6">
        <apexchart type="donut" :options="optionsDonut" :series="seriesDonut"></apexchart>
      </div>
    </div>
    <div id="charts">
      <apexchart height="300" type="line" :options="optionsLine" :series="seriesLine"></apexchart>
    </div>
    <!------------------------------------- https://apexcharts.com/docs/vue-charts/ ------------------------------------------>

    <div v-for="w in list_work"
         :key="w.id">
      {{w}}
    </div>
  </div>
</template>

<script>
    import axios from 'axios'
    import moment from 'moment'

    export default {
        name: 'User',
        data() {
            return {
                msg: 'coucou',
                id_user: 0,
                user: {
                    username: "",
                    email: ""
                },
                since: "",
                intervalclock: 0,
                list_work: [],
                /* ------------------------------------ Chart ------------------------------------ */
                /* --- Donut --- */
                optionsDonut: {
                    colors: ["#25CC00", "#cccccc"],
                    labels: ["Time active", "Time inactive"]
                },
                seriesDonut: [44, 55],

                /* --- Line --- */
                optionsLine: {
                    colors: ["#25CC00"],
                    chart: {
                        id: 'vuechart',
                        toolbar: {
                            show: false
                        }
                    },

                    xaxis: {
                        categories: [1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998]
                    }
                },
                seriesLine: [{
                    name: 'series-1',
                    data: [30, 40, 45, 50, 49, 60, 70, 91]
                }]
                /* ------------------------------------ Chart ------------------------------------ */
            }
        },
        watch: {},
        created() {
            this.id_user = this.$router.currentRoute.params.id;
            this.getUser();
        },
        methods: {
            getUser() {
                axios.get('http://localhost:4000/api/users/' + this.id_user, {crossOrigine: true})
                    .then(result => {
                        this.user = result.data.data;
                        this.getClock()
                    }, (err) => {
                        this.$router.push("/");
                    })
            },
            getClock() {
                axios.get('http://localhost:4000/api/clocks/' + this.id_user, {crossOrigine: true})
                    .then(res => {
                        if (res.data.data) {
                            this.intervalclock = setInterval(() =>
                                    this.since = moment(moment().diff(res.data.data.clock)).format('HH-mm-ss'),
                                1000);
                        } else {
                            this.since = "déconnecter"
                            clearInterval(this.intervalclock)
                        }
                        this.getListWork();
                    })
            },
            postClock() {
                axios.post('http://localhost:4000/api/clocks/' + this.id_user, {crossOrigine: true})
                    .then(res => {
                        this.getClock()
                    })
            },
            getListWork() {
                axios.get('http://localhost:4000/api/workingtimes/' + this.id_user, {crossOrigine: true})
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
    font-size: 24px;
    font-max-size: 24px;
  }

  #submit {
    font-size: 24px;
  }

  #btn-back {
    font-size: 24px;
  }

  #btn-back:hover {
    background-color: #0067a8;
  }

  #identity {
    padding: 20px;
  }

  #charts {
    background-color: #cccccc;
    border-radius: 10px;
  }
</style>
