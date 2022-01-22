transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {top.vo}

vlog -vlog01compat -work work +incdir+/home/b2cs/work/gate/top/.. {/home/b2cs/work/gate/top/../sim.v}

vsim -t 1ps -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  sim

add wave *
view structure
view signals
run 5000 us
