restart

add_force {/top_tb/uut_top_module/\redundancy_generation(4)\/fir_creation/mac_out[2]} -radix unsigned {0 400ns}
add_force {/top_tb/uut_top_module/\redundancy_generation(4)\/fir_creation/mac_out[1]} -radix unsigned {0 800ns}

run 2000 ns