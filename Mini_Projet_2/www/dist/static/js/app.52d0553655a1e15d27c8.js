webpackJsonp([1],{GmXn:function(t,s){},NHnr:function(t,s,e){"use strict";Object.defineProperty(s,"__esModule",{value:!0});var a=e("7+uW"),n=e("bOdI"),r=e.n(n),i=e("mtWM"),o=e.n(i),l=e("/ocq"),c={render:function(){var t=this,s=t.$createElement,e=t._self._c||s;return e("div",{staticClass:"hello"},[e("h1",[t._v(t._s(t.msg))]),t._v(" "),e("h2",[t._v("Essential Links")]),t._v(" "),t._m(0),t._v(" "),e("h2",[t._v("Ecosystem")]),t._v(" "),t._m(1),t._v(" "),e("router-link",{staticClass:"nav-link my-2",attrs:{to:{name:"login"}}},[t._v("Sign in")])],1)},staticRenderFns:[function(){var t=this,s=t.$createElement,e=t._self._c||s;return e("ul",[e("li",[e("a",{attrs:{href:"https://vuejs.org",target:"_blank"}},[t._v("\n        Core Docs\n      ")])]),t._v(" "),e("li",[e("a",{attrs:{href:"https://forum.vuejs.org",target:"_blank"}},[t._v("\n        Forum\n      ")])]),t._v(" "),e("li",[e("a",{attrs:{href:"https://chat.vuejs.org",target:"_blank"}},[t._v("\n        Community Chat\n      ")])]),t._v(" "),e("li",[e("a",{attrs:{href:"https://twitter.com/vuejs",target:"_blank"}},[t._v("\n        Twitter\n      ")])]),t._v(" "),e("br"),t._v(" "),e("li",[e("a",{attrs:{href:"http://vuejs-templates.github.io/webpack/",target:"_blank"}},[t._v("\n        Docs for This Template\n      ")])])])},function(){var t=this.$createElement,s=this._self._c||t;return s("ul",[s("li",[s("a",{attrs:{href:"http://router.vuejs.org/",target:"_blank"}},[this._v("\n        vue-router\n      ")])]),this._v(" "),s("li",[s("a",{attrs:{href:"http://vuex.vuejs.org/",target:"_blank"}},[this._v("\n        vuex\n      ")])]),this._v(" "),s("li",[s("a",{attrs:{href:"http://vue-loader.vuejs.org/",target:"_blank"}},[this._v("\n        vue-loader\n      ")])]),this._v(" "),s("li",[s("a",{attrs:{href:"https://github.com/vuejs/awesome-vue",target:"_blank"}},[this._v("\n        awesome-vue\n      ")])])])}]};e("VU/8")({name:"HelloWorld",data:function(){return{msg:"Welcome to Your Vue.js App"}}},c,!1,function(t){e("uYhG")},"data-v-42bb1e40",null).exports;var u=e("PJh5"),v=e.n(u),m={name:"User",data:function(){return{msg:"coucou",id_user:0,user:{username:"",email:""},since:"",intervalclock:0,list_work:[],optionsPie:{colors:["#25CC00","#cccccc"],labels:["Time active","Time inactive"]},seriesPie:[44,55],optionsLine:{colors:["#25CC00"],chart:{id:"vuechart",toolbar:{show:!1}},xaxis:{categories:[1991,1992,1993,1994,1995,1996,1997,1998]}},seriesLine:[{name:"series-1",data:[30,40,45,50,49,60,70,91]}]}},watch:{},created:function(){this.id_user=this.$router.currentRoute.params.id,this.getUser()},methods:{getUser:function(){var t=this;o.a.get("http://localhost:9050/api/users/"+this.id_user,{crossOrigine:!0}).then(function(s){t.user=s.data.data,t.getClock()},function(s){t.$router.push("/")})},getClock:function(){var t=this;o.a.get("http://localhost:9050/api/clocks/"+this.id_user,{crossOrigine:!0}).then(function(s){s.data.data?t.intervalclock=setInterval(function(){return t.since=v()(v()().diff(s.data.data.clock)).format("HH-mm-ss")},1e3):(t.since="déconnecter",clearInterval(t.intervalclock)),t.getListWork()})},postClock:function(){var t=this;o.a.post("http://localhost:9050/api/clocks/"+this.id_user,{crossOrigine:!0}).then(function(s){t.getClock()})},getListWork:function(){var t=this;o.a.get("http://localhost:9050/api/workingtimes/"+this.id_user,{crossOrigine:!0}).then(function(s){t.list_work=s.data.data})}}},h={render:function(){var t=this,s=t.$createElement,e=t._self._c||s;return e("div",{staticClass:"container",attrs:{id:"user"}},[e("div",[e("router-link",{staticClass:"btn btn-dark",attrs:{id:"btn-back",to:{name:"users"}}},[t._v("Back to Users List")])],1),t._v(" "),e("div",{staticClass:"row"},[e("div",{staticClass:"col-md-6",attrs:{id:"identity"}},[e("form",[e("div",{staticClass:"form-group"},[e("label",[t._v("User:")]),t._v(" "),e("input",{attrs:{placeholder:t.user.username}})]),t._v(" "),e("div",{staticClass:"form-group"},[e("label",[t._v("Email:")]),t._v(" "),e("input",{attrs:{placeholder:t.user.email}})]),t._v(" "),t._m(0),t._v(" "),t._m(1),t._v(" "),t._m(2)])]),t._v(" "),e("div",{staticClass:"col-md-5"},[e("apexchart",{attrs:{type:"pie",options:t.optionsPie,series:t.seriesPie}})],1)]),t._v(" "),e("div",{attrs:{id:"charts"}},[e("apexchart",{attrs:{height:"300",type:"line",options:t.optionsLine,series:t.seriesLine}})],1),t._v(" "),t._l(t.list_work,function(s){return e("div",{key:s.id},[t._v("\n    "+t._s(s)+"\n  ")])})],2)},staticRenderFns:[function(){var t=this.$createElement,s=this._self._c||t;return s("div",{staticClass:"form-group"},[s("select",[s("option",[this._v("Manager")]),this._v(" "),s("option",[this._v("Admin")]),this._v(" "),s("option",[this._v("Employer")])])])},function(){var t=this.$createElement,s=this._self._c||t;return s("div",{staticClass:"form-group"},[s("select",[s("option",[this._v("TEAM (Back a lié)")])])])},function(){var t=this.$createElement,s=this._self._c||t;return s("div",{staticClass:"form-group"},[s("button",{staticClass:"btn btn-dark",attrs:{id:"submit",type:"submit"}},[this._v("Submit")])])}]};var d=e("VU/8")(m,h,!1,function(t){e("GmXn")},null,null).exports,p={name:"Users",data:function(){return{msg:"Loaad",list_user:"lala",q:"",new_user:{username:"",email:""},error:""}},watch:{$route:"getAllUsers"},created:function(){this.getAllUsers()},methods:{getAllUsers:function(){var t=this;o.a.get("http://localhost:9050/api/users?email=&username="+this.q,{crossOrigine:!0}).then(function(s){t.list_user=s.data.data})},createUser:function(){var t=this;o.a.post("http://localhost:9050/api/users",{user:this.new_user},{crossOrigine:!0}).then(function(s){t.error="",t.list_user=s.data.data,t.getAllUsers()}).catch(function(s,e){t.error=s.response.data.errors})},deleteUser:function(t,s){var e=this;s&&s.preventDefault(),o.a.delete("http://localhost:9050/api/users/"+t,{crossOrigine:!0}).then(function(t){e.list_user=t.data.data,e.getAllUsers()})},navigate:function(t){y.push({name:"user",params:{id:t}})}}},f={render:function(){var t=this,s=t.$createElement,e=t._self._c||s;return e("div",{staticClass:"container",attrs:{id:"users"}},[e("div",{staticClass:"row"},t._l(t.list_user,function(s){return e("div",{key:s.id,staticClass:"col-sm-6 col-lg-4"},[e("div",{staticClass:"brand-card",on:{click:function(e){return t.navigate(s.id)}}},[t._m(0,!0),t._v(" "),e("div",{staticClass:"brand-card-body"},[e("div",[e("div",{staticClass:"text-value"},[t._v("Name:")]),t._v(" "),e("div",{staticClass:"text-uppercase text-muted small"},[t._v(t._s(s.username))])]),t._v(" "),e("div",[e("div",{staticClass:"text-value"},[t._v("Email:")]),t._v(" "),e("div",{staticClass:"text-uppercase text-muted small"},[t._v(t._s(s.email))])])])])])}),0)])},staticRenderFns:[function(){var t=this.$createElement,s=this._self._c||t;return s("div",{staticClass:"brand-card-header bg-success"},[s("h3",[this._v("00:00:00")])])}]};var j=e("VU/8")(p,f,!1,function(t){e("hGKg")},null,null).exports,_={render:function(){var t=this.$createElement,s=this._self._c||t;return s("div",{staticClass:"wrapper fadeInDown"},[s("div",{attrs:{id:"formContent"}},[this._m(0),this._v(" "),s("form",[s("input",{staticClass:"fadeIn second",attrs:{type:"text",id:"Email",name:"Email",placeholder:"Email"}}),this._v(" "),s("input",{staticClass:"fadeIn third",attrs:{type:"text",id:"Password",name:"login",placeholder:"Password"}}),this._v(" "),s("router-link",{attrs:{to:{name:"users"}}},[s("input",{staticClass:"fadeIn fourth",attrs:{type:"submit",value:"Log In"}})])],1)])])},staticRenderFns:[function(){var t=this.$createElement,s=this._self._c||t;return s("div",{staticClass:"fadeIn first"},[s("img",{attrs:{src:e("zhec"),id:"icon",alt:"User Icon"}})])}]};var g=e("VU/8")({name:"Login"},_,!1,function(t){e("r8eh")},null,null).exports,b={render:function(){var t=this.$createElement,s=this._self._c||t;return s("div",{staticClass:"wrapper fadeInDown"},[s("div",{attrs:{id:"formContent"}},[this._m(0),this._v(" "),s("form",[s("input",{staticClass:"fadeIn second",attrs:{type:"text",id:"Name",name:"Email",placeholder:"Name"}}),this._v(" "),s("input",{staticClass:"fadeIn second",attrs:{type:"text",id:"First_Name",name:"Email",placeholder:"First Name"}}),this._v(" "),s("input",{staticClass:"fadeIn second",attrs:{type:"text",id:"Email",name:"Email",placeholder:"Email"}}),this._v(" "),s("input",{staticClass:"fadeIn third",attrs:{type:"text",id:"password",name:"login",placeholder:"Password"}}),this._v(" "),s("input",{staticClass:"fadeIn third",attrs:{type:"text",id:"confirm_password",name:"login",placeholder:"Confirm Password"}}),this._v(" "),s("router-link",{attrs:{to:{name:"users"}}},[s("input",{staticClass:"fadeIn fourth",attrs:{type:"submit",value:"Create user"}})])],1)])])},staticRenderFns:[function(){var t=this.$createElement,s=this._self._c||t;return s("div",{staticClass:"fadeIn first"},[s("img",{attrs:{src:e("zhec"),id:"icon",alt:"User Icon"}})])}]};var k=e("VU/8")({name:"NewUser"},b,!1,function(t){e("mESb")},null,null).exports;a.a.use(l.a);var C,y=new l.a({mode:"history",routes:[{path:"/",name:"HelloWorld",component:g},{path:"/users",name:"users",component:j},{path:"/NewUser",name:"newUser",component:k},{path:"/login",name:"login",component:g},{path:"/user/:id",name:"user",component:d}]}),w=(C={name:"App"},r()(C,"name","Users"),r()(C,"data",function(){return{msg:"Loaad",list_user:"lala",q:"",new_user:{username:"",email:""},error:""}}),r()(C,"watch",{$route:"getAllUsers"}),r()(C,"created",function(){this.getAllUsers()}),r()(C,"methods",{getAllUsers:function(){var t=this;o.a.get("http://localhost:9050/api/users?email=&username="+this.q,{crossOrigine:!0}).then(function(s){t.list_user=s.data.data})},navigate:function(t){y.push({name:"user",params:{id:t}})}}),C),x={render:function(){var t=this,s=t.$createElement,e=t._self._c||s;return e("div",{attrs:{id:"app"}},[e("nav",{staticClass:"navbar navbar-expand-lg navbar-dark bg-dark"},[t._m(0),t._v(" "),e("div",{staticClass:"collapse navbar-collapse",attrs:{id:"navbarTogglerDemo01"}},[e("router-link",{staticClass:"navbar-brand text-light ",attrs:{to:{name:"HelloWorld"}}},[t._v("Time Manager")]),t._v(" "),e("ul",{staticClass:"navbar-nav mr-auto"},[e("li",{staticClass:"nav-item"},[e("router-link",{staticClass:"nav-link my-2",attrs:{to:{name:"login"}}},[t._v("Sign in")])],1),t._v(" "),e("li",[e("router-link",{staticClass:"nav-link my-2",attrs:{to:{name:"newUser"}}},[t._v("Sign up")])],1)]),t._v(" "),e("form",{staticClass:"form-inline my-2 my-lg-0"},[e("input",{directives:[{name:"model",rawName:"v-model",value:t.q,expression:"q"}],staticClass:"form-control mr-sm-2",attrs:{type:"text",placeholder:"Search ..."},domProps:{value:t.q},on:{keyup:function(s){return t.getAllUsers()},input:function(s){s.target.composing||(t.q=s.target.value)}}}),t._v(" "),e("button",{staticClass:"btn btn-outline-success my-2 my-sm-0",attrs:{type:"submit"}},[t._v("Search")])])],1)]),t._v(" "),e("router-view")],1)},staticRenderFns:[function(){var t=this.$createElement,s=this._self._c||t;return s("button",{staticClass:"navbar-toggler",attrs:{type:"button","data-toggle":"collapse","data-target":"#navbarTogglerDemo01","aria-controls":"navbarTogglerDemo01","aria-expanded":"false","aria-label":"Toggle navigation"}},[s("span",{staticClass:"navbar-toggler-icon"})])}]};var E=e("VU/8")(w,x,!1,function(t){e("yk0U")},null,null).exports,U=e("HJCm"),z=e.n(U);a.a.use(z.a),a.a.component("apexchart",z.a),a.a.config.productionTip=!1,new a.a({el:"#app",router:y,components:{App:E},template:"<App/>"})},hGKg:function(t,s){},mESb:function(t,s){},r8eh:function(t,s){},uYhG:function(t,s){},uslO:function(t,s,e){var a={"./af":"3CJN","./af.js":"3CJN","./ar":"3MVc","./ar-dz":"tkWw","./ar-dz.js":"tkWw","./ar-kw":"j8cJ","./ar-kw.js":"j8cJ","./ar-ly":"wPpW","./ar-ly.js":"wPpW","./ar-ma":"dURR","./ar-ma.js":"dURR","./ar-sa":"7OnE","./ar-sa.js":"7OnE","./ar-tn":"BEem","./ar-tn.js":"BEem","./ar.js":"3MVc","./az":"eHwN","./az.js":"eHwN","./be":"3hfc","./be.js":"3hfc","./bg":"lOED","./bg.js":"lOED","./bm":"hng5","./bm.js":"hng5","./bn":"aM0x","./bn.js":"aM0x","./bo":"w2Hs","./bo.js":"w2Hs","./br":"OSsP","./br.js":"OSsP","./bs":"aqvp","./bs.js":"aqvp","./ca":"wIgY","./ca.js":"wIgY","./cs":"ssxj","./cs.js":"ssxj","./cv":"N3vo","./cv.js":"N3vo","./cy":"ZFGz","./cy.js":"ZFGz","./da":"YBA/","./da.js":"YBA/","./de":"DOkx","./de-at":"8v14","./de-at.js":"8v14","./de-ch":"Frex","./de-ch.js":"Frex","./de.js":"DOkx","./dv":"rIuo","./dv.js":"rIuo","./el":"CFqe","./el.js":"CFqe","./en-SG":"oYA3","./en-SG.js":"oYA3","./en-au":"Sjoy","./en-au.js":"Sjoy","./en-ca":"Tqun","./en-ca.js":"Tqun","./en-gb":"hPuz","./en-gb.js":"hPuz","./en-ie":"ALEw","./en-ie.js":"ALEw","./en-il":"QZk1","./en-il.js":"QZk1","./en-nz":"dyB6","./en-nz.js":"dyB6","./eo":"Nd3h","./eo.js":"Nd3h","./es":"LT9G","./es-do":"7MHZ","./es-do.js":"7MHZ","./es-us":"INcR","./es-us.js":"INcR","./es.js":"LT9G","./et":"XlWM","./et.js":"XlWM","./eu":"sqLM","./eu.js":"sqLM","./fa":"2pmY","./fa.js":"2pmY","./fi":"nS2h","./fi.js":"nS2h","./fo":"OVPi","./fo.js":"OVPi","./fr":"tzHd","./fr-ca":"bXQP","./fr-ca.js":"bXQP","./fr-ch":"VK9h","./fr-ch.js":"VK9h","./fr.js":"tzHd","./fy":"g7KF","./fy.js":"g7KF","./ga":"U5Iz","./ga.js":"U5Iz","./gd":"nLOz","./gd.js":"nLOz","./gl":"FuaP","./gl.js":"FuaP","./gom-latn":"+27R","./gom-latn.js":"+27R","./gu":"rtsW","./gu.js":"rtsW","./he":"Nzt2","./he.js":"Nzt2","./hi":"ETHv","./hi.js":"ETHv","./hr":"V4qH","./hr.js":"V4qH","./hu":"xne+","./hu.js":"xne+","./hy-am":"GrS7","./hy-am.js":"GrS7","./id":"yRTJ","./id.js":"yRTJ","./is":"upln","./is.js":"upln","./it":"FKXc","./it-ch":"/E8D","./it-ch.js":"/E8D","./it.js":"FKXc","./ja":"ORgI","./ja.js":"ORgI","./jv":"JwiF","./jv.js":"JwiF","./ka":"RnJI","./ka.js":"RnJI","./kk":"j+vx","./kk.js":"j+vx","./km":"5j66","./km.js":"5j66","./kn":"gEQe","./kn.js":"gEQe","./ko":"eBB/","./ko.js":"eBB/","./ku":"kI9l","./ku.js":"kI9l","./ky":"6cf8","./ky.js":"6cf8","./lb":"z3hR","./lb.js":"z3hR","./lo":"nE8X","./lo.js":"nE8X","./lt":"/6P1","./lt.js":"/6P1","./lv":"jxEH","./lv.js":"jxEH","./me":"svD2","./me.js":"svD2","./mi":"gEU3","./mi.js":"gEU3","./mk":"Ab7C","./mk.js":"Ab7C","./ml":"oo1B","./ml.js":"oo1B","./mn":"CqHt","./mn.js":"CqHt","./mr":"5vPg","./mr.js":"5vPg","./ms":"ooba","./ms-my":"G++c","./ms-my.js":"G++c","./ms.js":"ooba","./mt":"oCzW","./mt.js":"oCzW","./my":"F+2e","./my.js":"F+2e","./nb":"FlzV","./nb.js":"FlzV","./ne":"/mhn","./ne.js":"/mhn","./nl":"3K28","./nl-be":"Bp2f","./nl-be.js":"Bp2f","./nl.js":"3K28","./nn":"C7av","./nn.js":"C7av","./pa-in":"pfs9","./pa-in.js":"pfs9","./pl":"7LV+","./pl.js":"7LV+","./pt":"ZoSI","./pt-br":"AoDM","./pt-br.js":"AoDM","./pt.js":"ZoSI","./ro":"wT5f","./ro.js":"wT5f","./ru":"ulq9","./ru.js":"ulq9","./sd":"fW1y","./sd.js":"fW1y","./se":"5Omq","./se.js":"5Omq","./si":"Lgqo","./si.js":"Lgqo","./sk":"OUMt","./sk.js":"OUMt","./sl":"2s1U","./sl.js":"2s1U","./sq":"V0td","./sq.js":"V0td","./sr":"f4W3","./sr-cyrl":"c1x4","./sr-cyrl.js":"c1x4","./sr.js":"f4W3","./ss":"7Q8x","./ss.js":"7Q8x","./sv":"Fpqq","./sv.js":"Fpqq","./sw":"DSXN","./sw.js":"DSXN","./ta":"+7/x","./ta.js":"+7/x","./te":"Nlnz","./te.js":"Nlnz","./tet":"gUgh","./tet.js":"gUgh","./tg":"5SNd","./tg.js":"5SNd","./th":"XzD+","./th.js":"XzD+","./tl-ph":"3LKG","./tl-ph.js":"3LKG","./tlh":"m7yE","./tlh.js":"m7yE","./tr":"k+5o","./tr.js":"k+5o","./tzl":"iNtv","./tzl.js":"iNtv","./tzm":"FRPF","./tzm-latn":"krPU","./tzm-latn.js":"krPU","./tzm.js":"FRPF","./ug-cn":"To0v","./ug-cn.js":"To0v","./uk":"ntHu","./uk.js":"ntHu","./ur":"uSe8","./ur.js":"uSe8","./uz":"XU1s","./uz-latn":"/bsm","./uz-latn.js":"/bsm","./uz.js":"XU1s","./vi":"0X8Q","./vi.js":"0X8Q","./x-pseudo":"e/KL","./x-pseudo.js":"e/KL","./yo":"YXlc","./yo.js":"YXlc","./zh-cn":"Vz2w","./zh-cn.js":"Vz2w","./zh-hk":"ZUyn","./zh-hk.js":"ZUyn","./zh-tw":"BbgG","./zh-tw.js":"BbgG"};function n(t){return e(r(t))}function r(t){var s=a[t];if(!(s+1))throw new Error("Cannot find module '"+t+"'.");return s}n.keys=function(){return Object.keys(a)},n.resolve=r,t.exports=n,n.id="uslO"},yk0U:function(t,s){},zhec:function(t,s,e){t.exports=e.p+"static/img/icon_connection.54cedaf.png"}},["NHnr"]);
//# sourceMappingURL=app.52d0553655a1e15d27c8.js.map