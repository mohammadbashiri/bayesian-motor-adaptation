<h1 align="center"> Bayesian Motor Adaptation </h1>

### Disclaimer
This is a short report of a mini project which was done as part of a course
called ***Computational Mechanisms of Learning*** in Technical University of Munich.

Contributors to the project are:
- Abdallah Alashqar
- Pranshul Saini
- Raja Judeh, and
- Mohammad Bashiri

A common task in human motor adaptation experiments is the simple 2D trajectory movement. 
In such task, subject starts from an initial position and she/he is instructed to reach the 
target position, within reasonable time limit.
While performing the task the subject is either exposed to a null field (no force applied 
on the subject's hand) or to a force field (force applied on the hand). Given these two
fields, we can observe the trajectory of hand movement and characterize the details of 
adaptation, or washout, in the subject. Adaptation refers to regaining smooth trajectories
when the subject is exposed to a force field. Washout is a essentially adapting back to
null filed after having adapted to a force field.

Let's consider a task as explained above (Figure 1). During the trajectory, the subject 
is exploring the dynamics of a new environment. At every point of the trajectory, the 
subject exhibits a specific velocity to move towards the goal (or desired trajectory).
Hence, we can consider every point, along the trajectory, **a state** with the state 
variable **hand velocity**.

In every state (i.e., specific velocity in x and y direction), we expect a force (the prior) 
on our hand, and to counteract the force we would apply a force opposite to that, which 
leaves us a with net force that takes us towards the goal (f_goal).
 
<p align="center">
	<br>
	<img src="https://github.com/mohammadbashiri93/AttentionEEG/blob/master/Fig/stim2.png" alt="Fig1">
</p>

### Acknowledgment

We would like to thank Prof. David Franklin for his amazing teaching style, and 
kind supervision throughout this project. We also, deeply appreciate Justinas ...'s
help in 