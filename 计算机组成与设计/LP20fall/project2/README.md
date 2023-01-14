## Compile and run for Part 1

```
cd code
make sim
cd ..
bash runPublic.sh
```

After run ```runPublic.sh```, all outputs will be in directory *myOut_1*, while the standard outputs lies in directory *outputs*. To compare the results with the standard outputs, you should do the following:

```
bash compare.sh
```

**Note:** all files shoule be *.out. I have done some changes in the original *runPublic.sh*, thus it outputs *.out rather than the original *.log. Details are in ```runPublic.sh``` and ```compare.sh```.


## Compile and run for Part 2
Just run four bash scripts. All outputs are in in directory *myOut_2*. ```plot.py``` is used to output figs.
