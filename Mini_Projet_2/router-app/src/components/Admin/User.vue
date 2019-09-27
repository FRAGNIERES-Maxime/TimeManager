<template>
  <div id='User' class="container">
    <div>
    </div>
    <div class="row">
      <div id="identity" class="col-md-6">
        <form>
          <div class="form-group">
            <label>User:</label>
            <input :placeholder=user.username>
          </div>
          <div class="form-group">
            <label>Email:</label>
            <input :placeholder=user.email>
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
      <div class="col-md-5">
        <apexchart type="pie" :options="optionsPie" :series="seriesPie"></apexchart>
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
    import api from '@/api/api';

    export default {
        name: 'User',
        props:{
          test: 0,
        },
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
                /* --- Pie --- */
                optionsPie: {
                    colors: ["#25CC00", "#cccccc"],
                    labels: ["Time active", "Time inactive"]
                },
                seriesPie: [44, 55],

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
          
            if (this.test ==0)
              this.id_user = this.$router.currentRoute.params.id;
            else
              this.id_user = this.test;
          console.log(this.id_user);
            this.getUser();
        },
        methods: {
            getUser() {
                api.getUser(this.id_user)
                    .then(result => {
                        this.user = result.data.data[0];
                        this.getClock()
                    });
            },
            getClock() {
                api.getClock(this.id_user)
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
                api.postClock(this.id_user)
                    .then(res => {
                        this.getClock()
                    })
            },
            getListWork() {
                api.getListWork(this.id_user)
                    .then(res => {
                        this.list_work = res.data.data;
                    })
            }

        }
    }
</script>

<style>
  select {
    border-radius: 5px;
    padding: 10px;
    background-color: #ffffff;
  }

  input {
    border-radius: 5px;
    padding: 10px;
    background-color: #ffffff;
  }

  .container {
    background-color: #919191;
    width: 100%;
    box-shadow: -1px 2px 5px 1px rgba(0, 0, 0, 0.7);
    padding: 50px;
  }

  #user {
    margin-top: 2%;
    font-size: 18px;
    font-max-size: 18px;
  }

  #submit {
    font-size: 18px;
  }

  #submit:hover {
    background-color: #0067a8;
  }

  #btn-back {
    font-size: 24px;
  }

  #btn-back:hover {
    background-color: #0067a8;
  }

  #identity {
    padding: 20px;
    background-color: #cccccc;
    box-shadow: -1px 2px 5px 1px rgba(0, 0, 0, 0.5);
    border-radius: 10px;
    margin: 15px;
  }

  #charts {
    background-color: #cccccc;
    box-shadow: -1px 2px 5px 1px rgba(0, 0, 0, 0.5);
    border-radius: 10px;
  }

  input {
    width: 100%;
  }
</style>
