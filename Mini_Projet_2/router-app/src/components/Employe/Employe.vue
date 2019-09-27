<template>

  <div id='user' class="container">
    <div id="chrono" class="row col-md-6">
      <form>
        <div class="timer form-group">
          <span class="seconds">{{ timers }}</span>
        </div>

        <div class="controls form-group">

          <button type="button" class="buttonSign btn-primary btn-lg fadeIn fourth start" style="width: 100%;" v-if="!resetButton" v-on:click="postClock()">start
            <i data-feather="play"></i>
          </button>

          <button type="button" class="buttonSign btn-primary btn-lg fadeIn fourth stop" v-if="resetButton" v-on:click="postClock()">stop
            <i data-feather="rotate-cw"></i>
          </button>

        </div>
      </form>
    </div>

    <div class="row">
      <div id="identity" class="col-md-6">
        <form>
          <div class="form-group">
            <label>Username: </label>
            <label v-if="me.username"> {{username}} </label>
          </div>
          <div class="form-group">
            <label>Edit Username: </label>
            <input type="text" v-model="me.username" id="First_Name" class="fadeIn second" name="login"
                   placeholder="Username">
          </div>
          <span v-if="errors" style="color:red"><p v-for="(e, index) in errors" :key="index">{{index}}-{{e}}</p></span>
          <button type="button" class="buttonSign btn-primary btn-lg fadeIn fourth" value="Update user"
                  v-on:click="updateUser()">Update user
          </button>

        </form>
        <button class="btn btn-danger btn-supp" v-on:click="supprimerCompte()"> supprimer mon compte</button>
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

    import api from '@/api/api';
    import auth from '@/services/auth';
    import login from '@/services/login';
    import moment from 'moment';
    import axios from 'axios';

    export default {


        name: 'Employe',
        data() {
            return {
                id_user: 0,
                timer: null,
                totalTime: (0 * 60),
                resetButton: false,
                title: "working hours",
                edit: false,
                me: {},
                timers: "Déco",
                inter: null,
                errors: null,
                username: "",
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
        created() {
            this.me = login.getMe();
            var interval;
            interval = setInterval(() => {
                console.log(this.me)
                if (this.me.id) {
                    this.id_user = this.me.id;

                    this.getClock();
                    this.username = this.me.username;
                    clearInterval(interval);
                    this.getWorkingtimes();
                }
            }, 2000)
        },
        methods: {

            startTimer: function () {
                this.timer = setInterval(() => this.count(), 1000); //1000ms = 1 second
                this.resetButton = true;
            },

            resetTimer: function () {
                this.totalTime = (0 * 60);
                clearInterval(this.timer);
                this.timer = null;
                this.resetButton = false;
            },
            editTimer: function () {
                this.edit = true;
            },
            padTime: function (time) {
                return (time < 10 ? '0' : '') + time;
            },
            count: function () {
                this.totalTime++;
            },

            getClock() {
                api.getClock(this.id_user)
                    .then(res => {
                        console.log(res)
                        if (res.data.data) {
                            this.inter = setInterval(() => this.timers = moment(moment().diff(res.data.data.clock)).subtract(1, "hour").format("HH:mm:ss"), 1000);
                            this.resetButton = true;
                        } else {
                            this.timers = "déco"
                            this.resetButton = false;

                            clearInterval(this.inter);
                        }
                    })
                    .catch(err => {
                        console.log(err)
                    })
            },


            postClock() {
                api.postClock(this.id_user)
                    .then(res => {
                        console.log(res);
                        this.getClock();
                    })
                    .catch(err => {
                        console.log(err)
                    })
            },
            supprimerCompte() {
                api.deleteUser(this.id_user)
                    .then(result => {
                        login.logOut();
                    })
            },
            updateUser() {
                this.me.password = "123456789"
                this.me.password_confirmation = "123456789"

                console.log(this.me)
                api.updateUser(this.me)
                    .then(result => {
                        Object.assign(this.me, result.data);
                        this.$nextTick(() => console.log(this.me))
                        this.username = this.me.username;
                        console.log(this.me)
                        //login.getLogin()
                    })

            },
            getWorkingtimes() {
                api.getWorkingtimes(this.id_user)
                    .then(result => {
                        let test = result.data.data
                        let timers = []

                        test.forEach((w) => {
                            timers.push(moment(moment(w.end).diff(w.start)).format("HH:mm:ss"))
                            //    console.log(timers)
                        });
                        //console.log(moment().add(7, 'days'));
                        console.table(timers)
                    })
            }

        },
        computed: {
            hours: function () {
                const hours = Math.floor(this.totalTime / 60);
                return this.padTime(hours);
            },
            minutes: function () {
                const minutes = Math.floor(this.totalTime / 60);
                return this.padTime(minutes);
            },
            seconds: function () {
                const seconds = this.totalTime - (this.minutes * 60);
                return this.padTime(seconds);
            },
        }
    }
</script>

<style>

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


  .theme--light.v-card {
    margin-top: 10%;
    background-color: #fff;
    color: rgba(0, 0, 0, .87);
  }

  #chrono {
    display: flex;
    justify-content: center;
    background-color: #cccccc;
    width: 100%;
    box-shadow: -1px 2px 5px 1px rgba(0, 0, 0, 0.7);
    padding: 50px;
    margin: 10px;
    border-radius: 10px;
    font-size: 18px;
    font-max-size: 18px;
  }

  .timer {
    display: flex;
    justify-content: center;
    font-size: 3rem;
    color: black;
    padding-top: 10%;
    width: 50%;
    margin: 0 auto;

  }

  .controls {
    display: flex;
    justify-content: space-evenly;
    width: 100%;
  }

  .input {
    background-color: white;
    border: none;
    font-size: 2rem;
    padding: 1em;
    text-align: center;
    color: black;

  }

  .mx-auto {
    background-color: white;
    margin: auto;
    width: 30%;
    padding: 10px;
    border: 0.2px solid black;
  }

  .start {
    display: flex;
    justify-content: center;
    font-size: 2rem;
  }

  .stop {
    display: flex;
    justify-content: center;
    font-size: 2rem;
  }

  .pause {
    display: flex;
    justify-content: center;
    font-size: 2rem;
  }

  .buttonSign {
    font-size: 24px;
    width: 100%;
  }

  .btn-supp {
    font-size: 24px;
    margin: 10px;
  }

  .btn-supp:hover {
    background-color: #a80300;
  }
</style>
