# Approach SMT

* Replace constants with variables (may need to initialize)
* Add clause indicating that the variable must be one of the original constant values
* Add that no two of these introduced variables can be the same (?)
* (?) add constraints that some of the other variables are equal to the constants
