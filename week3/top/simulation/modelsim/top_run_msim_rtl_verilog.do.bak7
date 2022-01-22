transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/b2cs/work/week3 {/home/b2cs/work/week3/top.v}
vlog -vlog01compat -work work +incdir+/home/b2cs/work/week3 {/home/b2cs/work/week3/rom.v}
vlog -vlog01compat -work work +incdir+/home/b2cs/work/week3 {/home/b2cs/work/week3/ram.v}
vlog -vlog01compat -work work +incdir+/home/b2cs/work/week3 {/home/b2cs/work/week3/mode_control.v}
vlog -vlog01compat -work work +incdir+/home/b2cs/work/week3 {/home/b2cs/work/week3/io_port.v}
vlog -vlog01compat -work work +incdir+/home/b2cs/work/week3 {/home/b2cs/work/week3/io_control.v}
vlog -vlog01compat -work work +incdir+/home/b2cs/work/week3 {/home/b2cs/work/week3/cpu.v}

vlog -vlog01compat -work work +incdir+/home/b2cs/work/week3/top/.. {/home/b2cs/work/week3/top/../sim.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  sim

add wave *
view structure
view signals
run 5000 us
