<template>
<div class="navbar navbar-expand-lg navbar-light bg-light shadow">
    <div class="container">
        <a class="navbar-brand"> <img src="../assets/Icons/SureX_Logo.png"/> </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarWrapper" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <nav class="collapse navbar-collapse mainNav" id="navbarWrapper">
            <ul class="navbar-nav ml-auto">
                <li class="navItem">
                    <router-link to="/">About</router-link> 
                </li>
                <li class="navItem">
                    <router-link to="/">Advantages</router-link> 
                </li>
                <li class="navItem">
                    <router-link to="/">Documents</router-link> 
                </li>
                <li class="navItem">
                    <router-link to="/">Faq</router-link> 
                </li>
                <li class="navItem">
                    <router-link to="/">Claim</router-link> 
                </li>            
            </ul>
            <a class="btn btn-primary mx-2 px-4" href="#">Sign up</a>
            <div class="socioIcons">
                <span class="socio-Icon">
                    <img class="img-fluid" src="../assets/Icons/SocialLogos_Twitter.svg" alt="Twitter">
                </span>
                <span class="socio-Icon">
                    <img class="img-fluid" src="../assets/Icons/SocialLogos_Telegram.svg" alt="Telegram">
                </span>
                <span class="socio-Icon">
                    <img class="img-fluid" src="../assets/Icons/SocialLogos_Discord.svg" alt="Discord">
                </span>
                <span class="socio-Icon">
                    <img class="img-fluid" src="../assets/Icons/SocialLogos_Medium.svg" alt="Medium">
                </span>
            </div>
        </nav>
    </div>
</div>
</template>

<style lang="scss" >
@import "../assets/variables.scss";
    $bluCol: #3056e2;
    $hovbluCol: #2b4abb;
    .mainNav{
        ul{
            a{
                padding:  .7em;
                text-transform: uppercase;
                color: $bluCol;
                font-family: "Gotham-Medium";
            }
            a:hover{
                text-decoration: none;
                color: $greenCol;
            }

        }
        .socioIcons{
            .socio-Icon{
                padding: 0.6em;
                color: $bluCol;
                font-size: larger;
                img{
                    width: 32px;
                }
            }
        }
        .btn-primary{ background-color: $bluCol; }
        @media only screen and (max-width: 992px) {
            ul{
                li{
                    margin: .5em auto;                    
                    width: 100%;
                    a{
                        padding: .8em;
                        width: 100% !important;
                        height: 100%;
                        
                    }
                    &:hover{
                    
                        a{ 
                            color: $greenCol; 
                        }
                    }
                }
            }   
            .btn{ width: 100%; }
            .socioIcons{
                margin: .8em auto;
                text-align: center;
            }
        }
    }
</style>