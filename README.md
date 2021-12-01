# Narrow Width Array Multiplier
Verilog implementation of a generic nxn narrow width array multiplier to analyze variances in metrics concerning power, area, speed, and modularity when compared to a normal array multiplier of the same bit width. The narrow width multiplier is designed to simulate a wide multiplier by breaking a given multiplication unit in half and using multiple of those units in combination with addition units in order to properly simulate what the wide multiplier would be able to accomplish. This can be seen by examining an 8x8 multiplier being generated using the narrow width multiplier approach of breaking the multiplication unit into 4x4 multipliers and using multiple multiplication units as well as 4x4 addition units. An example of this can be seen below: 

![8x8 Narrow Width Array Multiplier](/8x8_narrow_width_array_multiplier.jpg?raw=true "Title")

As seen in the example above, for the correct product bits to be generated with this type of multiplication unit, the inputs must be split into two different sections, high and low. High in this case refers to the upper half of a given input’s bits and low refers to the lower half. For this design, the multiplication units can be split up into four categories: low-low, high-low, low-high, and high-high. This ensures complete generation of all partial products prior to the final addition step. Once all partial products are generated, five addition units are used to propagate the correct product bits for the final result. For this research assignment, a generic n-bit ripple carry adder was designed for the addition unit of the narrow width multiplier so that each multiplication unit of varying bit widths could easily be generated.

# Results
## Area
At lower bit widths,specifically 8x8 and under, the array multiplier is more efficient with area consumption, however, as both designs are scaled up, such as in 16x16, 32x32, and 64x64 the area consumption of the narrow width array multiplier becomes far less than the normal array multiplier. Both designs have the same IO constraint, however, the number of LUTs used in the narrow width array multiplier continually decreases as the circuit becomes larger. An example of this consumption decrease can be seen at 64x64 where the narrow width array multiplier uses only ~71.1% the number of LUTs that the normal array multiplier uses.

## Power
With the decrease in area of the narrow width array multiplier, lower power consumption was also observed in a similar pattern to the area consumption. As both circuits become larger the amount of power consumed widens between the designs with the narrow width array multiplier displaying lower and lower power consumption.

## Speed
In regards to speed, this calculation is highly dependent on the critical path determined by the number of adders needed to traverse for both circuits. The normal array multipliers critical path can be calculated with the following formula.
* *(n - 1) + (n - 1)*

Narrow width array multipliers critical path, however, is calculated with this formula.
* *(n/2 - 1) + (n/2 - 1) + (n/4 * 5)*

This results in the narrow width array multiplier always having a larger critical path, additionally the difference in the critical paths of both circuits increases as the bit width increases making the narrow width array multiplier increasingly slower at larger bit widths.

## Modularity
Both designs are essentially the same in terms of modularity as they are very similar in design, however, the additional overhead required to generate the addition units for the narrow width arrray multiplier makes it slightly less modular.
