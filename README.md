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

<p align="center">
	<br>
	<img src="https://github.com/mohammadbashiri93/BayesianMotorAdaptation/blob/master/Figures/workspace.jpg" alt="Fig1">
    <figcaption>Fig1. - A view of a workspace. black dot is the starting point, and the red dots are the possible targets.</figcaption>
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

==================== here gous the formula for the normal distribution ============================

After esitmating the applied force, we would then update our prior, resulting in a posterior distribution,
which is then used as the prior in the next trial for the same state.

==================== bayes formula for updating the prior about applied force =====================

Moreover, due to generalization, this posterior, which is an update for the prior of this specific state,
would change the priors for other states, including the onses within the same trial.

### An example

in the very first trial, our prior is according to the null field. In other words, we have gotten some
experience over the years to move ourselves (i.e., our hand) within the dynamics of the air around us,
and we can somewhat automatically apply a force which takes our hand to the target (f_goal). Null field 
prior, is assumed to be a Gaussian centered around zero. As soon as we are exposed to a force field, we 
feel an extra force on our hand, driving us far from the target, and we start estimating that force, and
updating our belief about the environment dynamics we are interacting with. Figure 2a shows an example of
a desired trajectory and observed trajectory (influenced by the force field) in position space. Figure 2b
shows the observed trajectory in velocity space.


<div class="image123">
    <div style="float" width="50%" height="50%">
        <img src="https://github.com/mohammadbashiri93/BayesianMotorAdaptation/blob/master/Figures/trajectories.jpg" />
        <p style="text-align:center;">This is image 1</p>
    </div>
    <div style="float" width="50%" height="50%">
        <img src="https://github.com/mohammadbashiri93/BayesianMotorAdaptation/blob/master/Figures/state_variable(while).jpg" />
        <p style="text-align:center;">This is image 2</p>
    </div>
</div>

### Acknowledgment

We would like to thank Prof. David Franklin for his amazing teaching style, and 
kind supervision throughout this project. We also, deeply appreciate Justinas ...'s
help in 