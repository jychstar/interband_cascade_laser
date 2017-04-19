[TOC]

# 2017-2-21

## Yuchao to Meyer

Dear Dr. Meyer, 

I am writing to share my insights on ICL with you. Though I have not involved in active research for a while due to insufficient funding, yet I am still care about what can be done to accelerate the scientific progress. 

I actually documented these ideas in my dissertation: https://shareok.org/handle/11244/34604 I have done some preliminary calculations on these ideas. In the following question, I will refer to the "pdf page number" in my dissertation to help illustrate my thinking.

1.  The heuristic approach of heavily doping the election injection region to reduce the threshold current density by half is pretty amazing. But the fundamental reason of the improvement is not clear to me. The seminal paper (Nat. Commun., 2, 585 (2011)) explained it as a way to achieve a roughly equal value between the electron carrier density and hole carrier density in the active region. But the SVM test by University of Waterloo showed the carrier densities in active region are always balanced, no matter heavily doping or not. My thinking is, the doping helps achieve Bernard-Duraffourg inversion by elevating the quasi-Fermi level. Thus, the transparency condition is readily satisfied.  Detailed discussion is in section 5.2.1 (pdf 102-107).

2.  There’s no systematical study on carrier leakage in the cascade stage. The paper ("Gain and loss as a function of current density and temperature in interband cascade lasers", Appl. Opt., 54, F1 (2015).) raised a question why internal efficiency is not 100% after lasing. My explanation is that even stimulation recombination is the dominant recombination mechanism in the active region after lasing, carrier may already leak into elsewhere, e.g., the satellite valley of AlSb (see pdf 169). In literature on other lasers, I see researchers use "injection efficiency" to account for this effect. 

3.  The above paper also raised the issue of "efficiency droop" and "carrier non-pining". My understanding is, the internal loss still increase slowly after lasing (as shown in Figure 2-1 on pdf 34), because a stable lasing is actually a dynamic balance between gain and loss. As shown in Figure 2-3 on pdf 40, carriers accumulate slightly faster than gain. Because loss is carrier-dependent, this means loss increases slightly faster than gain. So the required gain also increases to balance out the slight difference. As a result, this tiny time lag becomes the culprit of non-pining and efficiency droop. 

4.  Another note is that pulsed mode can't completely eliminate the thermal effect, even for very short pulse and very small duty cycle. Although such thermal effect can't be readily measured, the carriers in the active region can immediately "feel" very hot when so many of them are crowded in such a tiny space. The heat can dissipate very soon without reaching the substrate once the current pulse is removed. But at the moment of lasing, the active region is much hotter than substrate. This localized heat also add to the aforementioned time lag in building a stable lasing behavior.  As a result, the non-pining and efficiency droop is more severe. 


In the foreseeable future, I don't have any resources to test my ideas.   I appreciate any feedback or suggestion. Please correct me if I am conceptually wrong or naively wrong. 

Best regards, 

Yuchao Jiang

Website: [https://github.com/jychstar](https://github.com/jychstar)

# 2017-2-23

## Igor to Jerry, Yuchao

Jerry,

Here are my preliminary thoughts:

It is certainly possible that we are off somewhat in estimating the balance between electrons and holes in the active region. However, I think that the ratio of the electron to hole density there definitely increases when the electron injector is doped more heavily. If all the electrons remained in the injector, I don't see any way to explain the decrease in the threshold **because the active densities and the internal fields are unchanged**. By the way, when we talk about the carrier densities in the active region, we make no distinction with respect to where the carriers originate.

Because of the higher density of states in the valence band, it is sometimes beneficial to have more holes than electrons even when the multielectron and multihole Auger rates are the same. Generally, it is difficult to obtain a higher gain at the same current density by having many more electrons than holes (unless multihole Auger very strongly dominates). The key is that the **comparison of the gain for a varying electron/hole ratio** should be performed at a fixed current density to determine if there is any benefit.

Regarding non-unity internal efficiency, our last results were much closer to 100% than before (~90%). It may be due to some combination of leakage and carrier heating, or it is possible that our measurements still underestimate the internal efficiency, and it is even closer to 100% than we think.

Regarding the efficiency droop, it is of course not very surprising that complete pinning at threshold does not occur. The pinning is an approximate concept in the absence of **carrier heating** and free-carrier absorption in the active region. What is surprising to us is how much of the efficiency droop we observe. Its extent cannot be easily explained by these two effects.

Feel free to forward this or I can respond to Yuchao myself.

## Yuchao reply

Thank you for the reply. It seems that I didn't explain my ideas well enough.

For the "carrier rebalancing" approach,my new way of thinking it is from the perspective of Fermi-level. Because of electrical neutrality, the electrons and holes are always balanced. The fundamental issue for diode laser is the huge difference of effective density of states between conduction and valence band. What doping changes the picture is the lift of Fermi-level, as shown in this graph.

![Fermi](https://github.com/jychstar/interband_cascade_laser/blob/master/fig%205-3,%20Fermi%20probability%20vs%20injection.jpg?raw=true)

As a result,  less carriers are used for maintaining the transparency condition. This also explain why high doping works better at higher temperature when transparency carrier density is larger. 

I don't know whether it is possible to measure the Fermi-level. 

Regarding the efficiency droop, I think the carrier-heating is the major cause. The pulse-mode testing assume an infinitely fast of heat transport, which is impossible. Heat transport is electronic, much slower than light speed. I estimate the "instant" heating of laser core will raise the temperature by ~ 40K. This should be enough to cause droop. I also saw your early paper ("High-power/low-threshold type-II interband cascade mid-IR laser-design and modeling", IEEE Photonics Technol. Lett., 9, 170 (1997).) metioned a ~60K rise by heating. 

​			
For me, I am now open and busy with some interview for industry job. My interest is more on the algorithm and software than experiment. I hesitated to ask whether NRL was hiring because I don't have a US citizenship yet. Thanks for asking. 		

## Igor reply	

Yuchao,

Not sure that I fully follow what you are saying, but some of it may be just semantic differences. The doping of the injectors increases the electron density in the active region, which is equivalent to raising the Fermi level with respect to the CB edge in the active wells. However, if only the position of the Fermi levels matters, it is preferable to have a higher hole density because of the larger density of states in the VB.

Overall charge neutrality is respected, and the densities of electrons and holes generated at the semi-metallic interface are obviously the same. However, the densities in the active wells don't necessarily have to be equal.

My estimates of the carrier heating at current densities of 2 kA/cm^2 are closer to 10 K, although the thermalization time is somewhat uncertain. In any case, we see a large increase in the efficiency droop for ICLs emitting at shorter wavelengths, for which the carrier heating should not be much different.

Igor

## Yuchao reply

Igor,

Fermi level is difficult to change by holes because density of states in VB is an order larger than that in CB. The perspective from Fermi-level is important in that it provides a more quantitative way to optimize the doping concentration for different active designs. 

At shorter wavelengths, the droop is more likely due to insufficent band offset to confine the carriers. AlSb in indirect bandgap material, its Gamma valley is shallow. 

# 2017-2-24

## Igor reply

Yuchao,

As a matter of fact, we are currently writing a book where these issues are discussed in greater detail than I can do via email. It is difficult to use the Fermi levels directly for quantitative estimates, This is because we would like to determine **if we can obtain higher gain at the same current density**, which is more straightforwardly expressed in terms of the electron and hole densities.

I doubt that the leakage via the X valley in the AlSb layers plays a significant role even in the 3.0 um ICLs, since it lies 0.7-0.8 eV above the bottom of the active conduction subband.

## Yuchao reply

Igor,

I understand it is impossible to measure Fermi levels. And it is  difficult to directly measure differential material gain. We can only directly measure slope efficiencies, which can be used to infer the differential modal gain. However, the big problem is that the modal gain is **highly dependent on carrier density**. The math to decompose the differential modal gain is:

$\Gamma \frac{dg}{dJ}=\frac{ \Gamma \tau}{q} \frac{dg}{dn_{2D}} =\frac{ \Gamma \tau g_0}{qN_c^{2D}} \frac{d(f_c-f_v)}{dN} $

So the fundamental reason that leads to the rapid diminishing of modal gain is the conduction band edge is almost fully occupied at high injection. The differential term is exponetially decreased, 

![](https://github.com/jychstar/interband_cascade_laser/blob/master/fig%205-4,%20differential%20probability%20vs%20injection.jpg?raw=true)

My model may be oversimplified. But I believe the Fermi-level is the vital key to open the black box. I understand your empirical approach. I just want to know why it has to be like this.  

# 2017-2-28

## Yuchao to Ganpath

Hello Ganpath,

Your recent paper on Transient thermal analysis(AIP ADVANCES 7, 025208 (2017)) is very interesting. This is a problem I thought hard during my writing of disseration. 

I am not sure I fully undertand your paper. Could you explain a little more about how you deal with the speed of heat transfer? In Fig.3, the temperature increase vs the pulse width is impressive. But I am not quite convinced how much temperature rise is caused by tp=0.2 us.

Because heat transfer is electronic, it is much slower than light speed. I tend to think the heat accumulation is always there even for a short pulse. And it is dificult to measure that. 

Thank you.

# 2017-3-1

## Ganpath to Yuchao

Hello Yuchao,

Thank you for your feedback.

If I understand your question right, you’re asking how much the laser heats up within the first 0.2 µs which was chosen as the reference in the measurement? Am I correct? 

There is definitely heating before tp = 0.2 µs and it is not negligible by any means. I couldn’t measure for tp < 0.2 µs because the electrical pulse had oscillations before this point due to the connection of two current sources. But, this is where the analytical solution helps. Since it fits to the experimental data for tp > 0.2 µs, we can believe and hence use it to calculate the heating for tp < 0.2 µs. You can see this in Fig. 5 & 6 where you see the heating for the whole time range before and after tp = 0.2 µs.

Please let me know if I answer your question. 

Best,

Ganpath

## Yuchao to Ganpath 

Hi Ganpath,

Thank you for the reply. Yes, I am interested in how much heat is built up during the first 0.2 us. Let me use an example to better illustrate my idea.

I did some calculation for an IC laser. This laser is actually from my paper that you cited as Ref.3. For example, at 377 K, the threshold current is about 6A and threshold voltage on the device is about 4V. Assuming 200-ns-pulse power is entirely absorbed by the cascade region with a size of 0.4 μm×100 μm× 2 mm and the specific heat of 0.25 J/K/g, the temperature increase is 42 K (compare with 3.6 K at room temperature). The actual temperature increase will be smaller than this value because the temperature gradient will drive the heat to the heatsink until a steady-state is achieved. 

A drawback of Fourier's Law of thermal conduction is that it doesn’t include the speed of heat transport. In other words, it assumes an infinite speed of propagation of heat signal, which is against the theory of relativity.  This is my first question: how you deal with this difficulty?

In my understanding, the base pulse IB generate much more heat than Ip. But in Fig.2, there is no concrete number showing Delta T by IB. You use an unit step function to describe the current injection. I guess there is a similar step function for the temperature rise. It is like a "big bang" moment that is extremely fast. If you ask me how fast is that, regarding the fact that heat accumulation still takes time.  I would say this temperature rise is slightly faster than light is generated. Below shows a dynamic process for a laser before it reach the steady state.

![](https://github.com/jychstar/interband_cascade_laser/blob/master/fig%202-3%20rate%20equation.jpg?raw=true) 	

So I guess there is a "base" temperature rise during the first 10 ns. This builds up a large temperature gradient for subsequent heat dissipation. If this temperature gradient is not large enough to disspipate the new generated heat, the tempeature will continue to increase until a balance is reach. This new balance is the Delta T by tp. Do you have any comment for this perspective?  				​

# 2017-3-2

## Ganpath to Yuchao	


Hi Yuchao,

This is a very interesting question. I must confess I haven’t considered relativistic conduction in the model, but rather used the classical Fourier’s law. So I assumed the speed of heat transport to be high enough that it need not be considered. I am not certain how much of an influence this has in reality.

The base pulse IB is the heat source in the experiment. Although the probe pulse Ip will also cause some heating, the influence of this is sort of cancelled out in the measurement, because we find the relative temperature increase with respect to the reference probe pulse position at tp = 0.2 µs. Since the probe pulse is the same for all the measurements at different tp, its influence can be removed by simply subtraction. Fig. 2 is only a schematic of the measurement method. The result of the measurement is shown in Fig.3.

Since temperature rise is exponential even if you assume an infinite speed of propagation of the heat signal, it seems to me that **you are right in saying that the temperature rise must be extremely fast until the point where dissipation starts to actually occur**. However, I have no idea how much or how fast this would be. 

Best regards,

Ganpath			