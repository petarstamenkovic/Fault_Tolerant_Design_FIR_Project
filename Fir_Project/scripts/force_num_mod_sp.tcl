restart
add_force {/top_tb/uut_top_module/\redundancy_generation(4)\/fir_creation/switch_in_original[0]} -radix unsigned {0 300ns}
add_force {/top_tb/uut_top_module/\redundancy_generation(4)\/fir_creation/switch_in_spares[0]} -radix unsigned {0 600ns}
add_force {/top_tb/uut_top_module/\redundancy_generation(4)\/fir_creation/switch_in_original[1]} -radix unsigned {0 900ns}
add_force {/top_tb/uut_top_module/\redundancy_generation(4)\/fir_creation/switch_in_spares[1]} -radix unsigned {0 1200ns}
run 2000 ns