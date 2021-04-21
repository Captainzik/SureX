<template>
    <section id="Footer" class="mt-4 mb-3">
        <div class="container d-flex flex-column  align-content-center">
            <div class="footerSiteName text-center">
                hello@surex.io
            </div>
            <div class="socioIcons my-3">
                <span class="socio-Icon mx-3">
                    <svg id="Layer_1" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 850.39 658.83"><defs></defs><path class="cls-1" d="M112.78,47.65C192.53,164.25,366,220.43,437.52,210.07,412.26,41.15,584-41.85,705.93,67.53c21.53-1,69.47-17,96.1-36.46-13.45,38.73-46.86,72.05-66.28,82.87,18.63,6,47.28-3.06,86.16-23.2-12,23.58-47.57,59.72-76.21,79.55,17.49,225-219.19,613.44-679.31,401.08,119.41,6.71,181.42-36.1,225.33-69.61C205,496,149.44,423.9,149.23,399c20.61,2.2,45.85,0,66.27-3.31C121.61,358,84.71,293.17,92.9,239.9c15.3,11.62,43.25,16.5,69.58,13.26C93.84,205.24,68.92,120.22,112.78,47.65Z"/></svg>
                    <!-- <img class="img-fluid" src="../../assets/Icons/SocialLogos_Twitter.svg" alt="Twitter"> -->
                </span>
                <span class="socio-Icon mx-3">
                    <svg id="Layer_1" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 850.39 658.83"><defs>
                        </defs><path class="cls-1" d="M737,26.62c-20.72,8.94-667.64,249.85-687.42,256s-22.54,33-4.65,38.55,177.51,56.51,177.51,56.51S285,572.08,292.21,587.72s28,12.55,37.89,3.33,99.06-91.75,99.06-91.75,151.28,114,171.52,128.31,45,5.38,51.19-17.28S768.09,70.72,771.54,51.22,757.68,17.69,737,26.62Zm-97.06,115C630,151.18,325.45,427.5,325.45,427.5l-13.3,114.35L257,361s361.15-225.95,371-234S649.84,132.09,639.91,141.64Z"/></svg>
                </span>
                <span class="socio-Icon mx-3">
                    <svg id="Layer_1" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 850.39 658.83"><defs></defs><path class="cls-1" d="M720.33,107.54C625.85,37.27,538.08,34.62,538.08,34.62l-6.63,13.26s121.31,32.83,169,96.12C518.51,36.32,302.4,58.64,150.37,144c62.26-69,169-96.12,169-96.12L312.75,31.3s-114.53,15-182.26,76.24C93.25,148,16.2,376.38,21.14,508.62,110.63,616.15,259.73,618,259.73,618l26.51-36.46s-115.49-36-155.75-112.7c179.1,148.46,470.63,106.9,593.15,0-56.85,77.94-159,112.7-159,112.7l29.82,39.78S749.56,608,829.68,508.62C829.07,348.21,750.09,130.94,720.33,107.54Zm-424,385.54c-53.83,0-66.28-51.52-66.28-72.92s6.79-76.24,59.65-76.24c57.18,0,69.59,48.78,69.59,69.61S350.2,493.08,296.37,493.08Zm241.9,0c-51.43,0-69.59-48.54-69.59-76.24s20.5-76.23,63-76.23c46.4,0,66.27,41.48,66.27,69.61S589.69,493.08,538.27,493.08Z"/></svg>
                </span>
                <span class="socio-Icon mx-3">
                    <svg id="Layer_1" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 850.39 658.83"><defs></defs><path class="cls-1" d="M68.59,36.94H284l162.37,361.3L595.47,36.94H794.29V50.2l-63,59.66V547.4l63,63v13.26H506V610.38l66.27-63V202.67l-169,417.65H383.39l-195.5-421V501l89.47,109.39v13.26H58.65V610.38L148.12,501V143L68.59,53.51Z"/></svg>
                </span>
            </div>
        </div>
    </section>
</template>
<script>
export default {
    setup() {
        
    },
}
</script>
<style lang="scss" >
@import "/src/assets/variables.scss";
#Footer{
    .footerSiteName{
        color: $bluCol;
        font-family: "Gotham-Medium";
    }
    .socioIcons{
        text-align: center;
        .socio-Icon{
            svg{
                width: 24px;
                fill: aliceblue;
            }
            text-align: center !important;
            vertical-align: middle !important;
            display: inline-block;
            padding: .6em !important;
            
            border-radius: 50%;
            background-color: $bluCol;
            padding: 0.6em;
            color: white;
            // font-size: larger;
 
        }
    }
}
</style>