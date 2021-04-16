import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import MainApp from '../views/MainApp.vue'
import Overview from '../views/SB2/Overview.vue'
import Covers from '../views/SB2/Covers.vue'
import Stake from '../views/SB2/Stake.vue'
import Swap from '../views/SB2/Swap.vue'
import Claim from '../views/SB2/Claim.vue'
import Assess from '../views/SB2/Assess.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/mainapp',
    name: 'MainApp',
    component: MainApp,
      children:[  
        {
          path: '',
          name: "overview",
          component: Overview
        },
        {
            path: 'covers',
            name: "covers",
            component: Covers
        },
        {
          path: 'stake',
          name: "stake",
          component: Stake
        },
        {
          path: 'swap',
          name: "swap",
          component: Swap
        },
        {
          path: 'claim',
          name: "claim",
          component: Claim
        },
        {
          path: 'assess',
          name: "assess",
          component: Assess
        },
      ]
  },
  {
    path: '/about',
    name: 'About',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
