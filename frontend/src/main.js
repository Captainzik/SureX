import { createApp } from 'vue'
import App from './App.vue'
import './registerServiceWorker'
import router from './router'
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { library } from "@fortawesome/fontawesome-svg-core";
import { fas } from "@fortawesome/free-solid-svg-icons";
import { fab } from '@fortawesome/free-brands-svg-icons'

import "@/assets/SB2/sb-admin-2.scss";



library.add( fas, fab )

// window.$ = window.jQuery = require("jquery");

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap'


createApp(App)
    .component("font-awesome-icon", FontAwesomeIcon)
    .use(router)
    .mount('#app')
