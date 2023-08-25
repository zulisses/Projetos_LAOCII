transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Faculdade/LAOC\ II/pratica1/atividade1 {D:/Faculdade/LAOC II/pratica1/atividade1/atividade1.v}
vlog -vlog01compat -work work +incdir+D:/Faculdade/LAOC\ II/pratica1/atividade1 {D:/Faculdade/LAOC II/pratica1/atividade1/decodificadorComportamental.v}
vlog -vlog01compat -work work +incdir+D:/Faculdade/LAOC\ II/pratica1/atividade1 {D:/Faculdade/LAOC II/pratica1/atividade1/memoram.v}

