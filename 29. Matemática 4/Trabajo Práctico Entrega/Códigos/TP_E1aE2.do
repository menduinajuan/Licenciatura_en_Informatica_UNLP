clear all
set more off

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Informática (FI)/Licenciatura en Informática/29. Matemática 4/Trabajo Práctico/Datos"


capture log close
log using "TP_E1aE2", replace
*log using "TP_E1aE2.log", replace


import delimited "players_21", clear
describe
keep if (value_eur!=.)


*##############################################################################*
******************* PARTE 1: PREDICCIÓN DEL VALOR DE MERCADO *******************
*##############################################################################*


*INCISOS (i)-(ii)*

local vars="age height_cm pace shooting passing dribbling defending physic attacking_crossing attacking_finishing attacking_heading_accuracy attacking_short_passing attacking_volleys skill_dribbling skill_curve skill_fk_accuracy skill_long_passing skill_ball_control movement_acceleration movement_sprint_speed movement_agility movement_reactions movement_balance power_shot_power power_jumping power_stamina power_strength power_long_shots mentality_aggression mentality_interceptions mentality_positioning mentality_vision mentality_penalties mentality_composure defending_marking_awareness defending_standing_tackle defending_sliding_tackle goalkeeping_diving goalkeeping_handling goalkeeping_kicking goalkeeping_positioning goalkeeping_reflexes"

local rows: word count `vars'

matrix define	regs = J(`rows',5,.)
matrix colnames regs = "coef" "se" "t" "p-value" "r2"

local i=1
local max_r2=-1
local max_index=0
local max_var=""

foreach var of local vars {
	regress value_eur `var', robust
	test `var'
	matrix regs[`i',1]=e(b)[1,1]
	matrix regs[`i',2]=sqrt(e(V)[1,1])
	matrix regs[`i',3]=e(b)[1,1]/e(V)[1,1]
	matrix regs[`i',4]=r(p)
	matrix regs[`i',5]=e(r2)
	if (e(r2)>`max_r2') {
        local max_r2=e(r2)
        local max_index=`i'
        local max_var="`var'"
    }
	local i=`i'+1
}

matrix list regs
display as text "El valor máximo de R^2 es " as result `max_r2'
display as text "Corresponde a la regresión número " as result `max_index'
display as text "Corresponde a la variable " as result "`max_var'"

regress value_eur `max_var', robust
display as text "Beta = " as result e(b)[1,1]
display as text "R^2 = " as result e(r2)
if (e(b)[1,1]>0) display as text "r = " as result sqrt(e(r2))
if (e(b)[1,1]<0) display as text "r = " as result -sqrt(e(r2))
pwcorr value_eur `max_var'

generate ln_value_eur=ln(value_eur)
generate ln_`max_var'=ln(`max_var')
regress ln_value_eur ln_`max_var', robust
display as text "Beta = " as result e(b)[1,1]
display as text "R^2 = " as result e(r2)
if (e(b)[1,1]>0) display as text "r = " as result sqrt(e(r2))
if (e(b)[1,1]<0) display as text "r = " as result -sqrt(e(r2))
pwcorr value_eur ln_`max_var'

*INCISO (iii)*

regress value_eur `max_var', robust
predict resid, residuals

local N=e(N)
local df=`N'-2
local conf=0.95
local alpha=1-`conf'
local t=invttail(`df',`alpha'/2)

summarize `max_var'
local x_mean=r(mean)
local Sxx=(`N'-1)*r(sd)^2
local b0=_b[_cons]
local b1=_b[`max_var']
local x=`x_mean'
local y=`b0'+`b1'*`x'

generate resid2=resid^2
summarize resid2
local sigma2_est=r(sum)/`df'

generate ip_inf=`y'-`t'*sqrt(`sigma2_est'*(1+1/`N'+(`x'-`x_mean')^2/`Sxx'))
generate ip_sup=`y'+`t'*sqrt(`sigma2_est'*(1+1/`N'+(`x'-`x_mean')^2/`Sxx'))

generate ic_inf=`y'-`t'*sqrt(`sigma2_est'*(1/`N'+(`x'-`x_mean')^2/`Sxx'))
generate ic_sup=`y'+`t'*sqrt(`sigma2_est'*(1/`N'+(`x'-`x_mean')^2/`Sxx'))

generate n_ip=0
replace n_ip=1 if (value_eur<ip_inf | value_eur>ip_sup)

generate n_ic=0
replace n_ic=1 if (value_eur<ic_inf | value_eur>ic_sup)

summarize n_ip
display as text "La proporción de veces que el valor de mercado supera la incertidumbre de predicción es " as result r(mean)

summarize n_ic
display as text "La proporción de veces que el valor de mercado supera la incertidumbre de estimación es " as result r(mean)


*##############################################################################*
************* PARTE 2: ECUACIÓN DE PREDICCIÓN DEL VALOR DE MERCADO *************
*##############################################################################*


*INCISO (i)*

regress value_eur `vars', robust

drop ln_`max_var'
foreach var of local vars {
	generate ln_`var'=ln(`var')
}

local ln_vars="ln_age ln_height_cm ln_pace ln_shooting ln_passing ln_dribbling ln_defending ln_physic ln_attacking_crossing ln_attacking_finishing ln_attacking_heading_accuracy ln_attacking_short_passing ln_attacking_volleys ln_skill_dribbling ln_skill_curve ln_skill_fk_accuracy ln_skill_long_passing ln_skill_ball_control ln_movement_acceleration ln_movement_sprint_speed ln_movement_agility ln_movement_reactions ln_movement_balance ln_power_shot_power ln_power_jumping ln_power_stamina ln_power_strength ln_power_long_shots ln_mentality_aggression ln_mentality_interceptions ln_mentality_positioning ln_mentality_vision ln_mentality_penalties ln_mentality_composure ln_defending_marking_awareness ln_defending_standing_tackle ln_defending_sliding_tackle ln_goalkeeping_diving ln_goalkeeping_handling ln_goalkeeping_kicking ln_goalkeeping_positioning ln_goalkeeping_reflexes"

local num_vars: word count `ln_vars'

regress ln_value_eur `ln_vars', robust
local N=e(N)
matrix define betas=e(b)

*INCISOS (ii)-(iii)*

keep if (e(sample))

local alpha=0.001
local max_iterations=1000
local tolerance=0.000000015
local crit=1
scalar costo_prev=0

scalar beta0=betas[1,`num_vars'+1]*1.25
forvalues i=1(1)`num_vars' {
	scalar beta`i'=betas[1,`i']*1.25
}

quietly forvalues i=1(1)`max_iterations' {

	noisily display in yellow "`i'", _continue

    generate pred=beta0
	forvalues j=1(1)`num_vars' {
		local var: word `j' of `ln_vars'
		replace pred=pred+beta`j'*`var'
    }

    generate error=ln_value_eur-pred
	scalar costo=(1/(2*`N'))*sum(error^2)

	scalar grad_b0=(1/`N')*sum(error)
	scalar beta0=beta0-`alpha'*grad_b0
	scalar grad_magnitude=sqrt(grad_b0^2)
	forvalues j=1(1)`num_vars' {
		local var: word `j' of `ln_vars'
		scalar grad_b`j'=(1/`N')*sum(error*`var')
		scalar beta`j'=beta`j'-`alpha'*grad_b`j'
        scalar grad_magnitude=grad_magnitude+grad_b`j'^2
	}
	scalar grad_magnitude=sqrt(grad_magnitude)

	if (mod(`i',100)==0) {
		noisily display, _newline
        noisily display as text "Iteración `i' - abs(costo-costo_prev) = " as result abs(costo-costo_prev)
        noisily display as text "Iteración `i' - grad_magnitude = " as result grad_magnitude, _newline
	}

	if (`crit'==1) {

		if (abs(costo-costo_prev)<`tolerance') {

			noisily display, _newline
			noisily display in red "Convergencia alcanzada en la iteración `i' " in yellow "(abs(costo-costo_prev) = " abs(costo-costo_prev) ")", _newline

			noisily display as text "Beta constante = " as result beta0
			noisily forvalues j=1(1)`num_vars' {
				local var: word `j' of `ln_vars'
				display as text "Beta `var' = " as result beta`j'
			}

			continue, break
		}

	}

	if (`crit'==2) {

		if (grad_magnitude<`tolerance') {

			noisily display, _newline
			noisily display in red "Convergencia alcanzada en la iteración `i' " in yellow "grad_magnitude = " grad_magnitude ")", _newline

			noisily display as text "Beta constante = " as result beta0
			noisily forvalues j=1(1)`num_vars' {
				local var: word `j' of `ln_vars'
				display as text "Beta `var' = " as result beta`j'
			}

			continue, break
		}

	}

	scalar costo_prev=costo

	drop pred error

	if (`i'==`max_iterations') {
        noisily display in red "No se alcanzó la convergencia dentro del número máximo de iteraciones (`max_iterations')"
	}

}


log close