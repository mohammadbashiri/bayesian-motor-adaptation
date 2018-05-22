<h1 align="center"> Bayesian Motor Adaptation </h1>

#### Disclaimer
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

<p align="center">
	<br>
	<img src="https://github.com/mohammadbashiri93/BayesianMotorAdaptation/blob/master/Figures/workspace.jpg" alt="Fig1" height="250" width="250">
    <figcaption align="center"> Fig1. - A view of a workspace. black dot is the starting point, and the red dots are the possible targets.</figcaption>
</p>

In every state (i.e., specific velocity in x and y direction), we expect a force (the prior) 
on our hand, and to counteract the force we would apply a force opposite to that, which 
leaves us with a net force that takes the hand towards the goal (f_goal). However, before adaptation
to the force field, the net force guides us to a new position which is most likely not on the
desired trajectory. Hence, we would biologically compute the most likely force that could have given 
rise to the observed trajectory (i.e., likelihood). Assuming that our sensory system is functioning
well, we should be able to, roughly, estimate the force that is applied by force field on out hand.
Since the force field is a function of the hand velocity (i.e., the state variable), we can construct
the likelihood as a Gaussian that has a mean around appleid force by the force field, and a variance 
that expresses the uncertainty in our sensory input. Hence the likelihood would be:

<p align="center">
	<br>
	<img src="https://github.com/mohammadbashiri93/BayesianMotorAdaptation/blob/master/Figures/likelihood.JPG" alt="formula1">
</p>

After esitmating the applied force, we would then update our prior, resulting in a posterior distribution,
which is then used as the prior in the next trial for the same state.

<p align="center">
	<br>
	<img src="https://github.com/mohammadbashiri93/BayesianMotorAdaptation/blob/master/Figures/bayes.JPG" alt="formula2">
</p>

Moreover, due to generalization, this posterior, which is an update for the prior of this specific state,
would change the priors for other states, including the onses within the same trial.

#### An example

in the very first trial, our prior is according to the null field. In other words, we have gotten some
experience over the years to move ourselves (i.e., our hand) within the dynamics of the air around us,
and we can somewhat automatically apply a force which takes our hand to the target (f_goal). Null field 
prior, is assumed to be a Gaussian centered around zero. As soon as we are exposed to a force field, we 
feel an extra force on our hand, driving us far from the target, and we start estimating that force, and
updating our belief about the environment dynamics we are interacting with. Figure 2a shows an example of
a desired trajectory and observed trajectory (influenced by the force field) in position space. Figure 2b
shows the observed trajectory in velocity space.


<p align="center">
	<br>
	<img src="https://github.com/mohammadbashiri93/BayesianMotorAdaptation/blob/master/Figures/state_variable_trajectory.png" alt="Fig1">
    <figcaption align="center"> 
        Fig1. (left) trajectory in velocity space while exposed. (right) trajectory in position space in null field (green)
        versus force field (red)
    </figcaption>
</p>



============== here goes the firgure for the expansion of each state variable force distribution ============
============== and update of prior distribution for several trials ==========================================

Now, after interacting with the force field, we have a posterior of the force distribution given a specific velocity 
state, and we need to update out belief about the force that is expected, given this state.

Note that in Figure 4 which illustrates the update of prior force distribution given a specific state, the generalization
is ignored - not only we use the posterior of state 1 to update the prior for future states, but also future states would 
influence the prior of state 1.

### Generalization

The experience gained in one state could be generalized to another state. This behavior is also observed in human
behavior [reference]. 

### The need for a model that considers within-trial adaptation
An obvious example of within-trials adaptation (or correction) is the first force-field trial. In the very first trial, we
are still new to the force field dynamics – no experience. However, the influence of the experience gained from the
first few states would help us to form a rough estimation about the states to come, and at the end, even within the
first trial, we would end up in target.

### The role of the goal
Up to this point, one important factor, which is ignored in this description, is the goal. The goals defines a
default force that is always applied to achieve it. Moreover, to reach the goal, or to be on the desired
trajectory, we would try to cancel out all other forces applied, so that the net force is the force that would
direct us to the goal. During the trajectory, the position of our hand changes, hence the direction (and
amplitude) of the force that we need to apply to reach to the target. Therefore, I think the force that we
apply is actually not opposite to prior, but the addition of opposite of prior and a force towards the goal.
To sum this up: the objective is to estimate the force that is applied on our hand correctly so we could
apply a force on manipulandum that result in a net force which takes the hand towards the target. In fact,
the equation(s) above need a little bit of modification:

### A possible explanation for contextual learning


### Results


### Acknowledgment

We would like to thank Prof. David Franklin for his amazing teaching style, and 
kind supervision throughout this project. We also, deeply appreciate Justinas ...'s
help in 