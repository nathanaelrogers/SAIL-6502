runs=(bcd_valid_only functional_no_bcd functional_with_bcd)
srcfiles=(addressing.sail decimal-mode.sail decode.sail instruction-ast.sail interrupts.sail prelude.sail registers.sail types.sail instructions/\*.sail instructions/arithmetic/\*.sail instructions/comparison/\*.sail instructions/interrupt/\*.sail instructions/misc/\*.sail instructions/shift/\*.sail instructions/stack/\*.sail instructions/subroutine/\*.sail)

for run in ${runs[@]}; do
    for src in ${srcfiles[@]}; do
        ./sailcov -a coverage_data/all_branches -t coverage_data/$run sail_src/$src
        mv *.html coverage_results/$run
    done
done

for src in ${srcfiles[@]}; do
    ./sailcov -a coverage_data/all_branches -t coverage_data/bcd_valid_only -t coverage_data/functional_no_bcd sail_src/$src
    mv *.html coverage_results/bcd_combined_functional_no_bcd
done