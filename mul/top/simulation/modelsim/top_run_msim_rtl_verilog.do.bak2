transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/b2cs/work/mul {/home/b2cs/work/mul/usr_dev.v}
vlog -vlog01compat -work work +incdir+/home/b2cs/work/mul {/home/b2cs/work/mul/top.v}
vlog -vlog01compat -work work +incdir+/home/b2cs/work/mul {/home/b2cs/work/mul/io_dev.v}

vlog -vlog01compat -work work +incdir+/home/b2cs/work/mul/top/.. {/home/b2cs/work/mul/top/../sim.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  sim

add wave *
view structure
view signals
run 240 ps
