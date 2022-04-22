# Peskin Solutions

By [*Jinchen He*](https://github.com/Greyyy-HJC)

??? note "Download PDF"
    - [Chapter 2](ch2.pdf)
    - [Chapter 3](ch3.pdf)
    - [Chapter 4](ch4.pdf)
    - [Chapter 9](ch9.pdf)

## Chapter 2

### Problem 2.1

#### 2.1.a

We know the Euler-Lagrange eq. as below,

\[
    \mathcal{L} = - \frac{1}{4} \mathit{F}_{\rho \sigma} \mathit{F}^{\rho \sigma}
\]

\[
    \frac{\partial \mathcal{L}}{\partial A_{\nu}} = \partial_{\mu}( \frac{\partial \mathcal{L}}{\partial (\partial_{\mu} A_{\nu})} )
\]

And obviously,

\[
    \frac{\partial \mathcal{L}}{\partial A_{\nu}} = 0
\]

\[
    \frac{\partial \mathit{F}*{\rho \sigma}}{\partial (\partial*{\mu} A_{\nu})} = \delta^{\mu}*{\rho} \delta^{\nu}*{\sigma} - \delta^{\mu}*{\sigma} \delta^{\nu}*{\rho}
\]

So,

\[
    \partial_{\mu}( \frac{\partial \mathcal{L}}{\partial (\partial_{\mu} A_{\nu})} ) = -\frac{1}{4} \partial_{\mu}( 2 \mathit{F}^{\mu \nu} - 2 \mathit{F}^{\nu \mu} ) = - \partial_{\mu} \mathit{F}^{\mu \nu} = 0
\]

The above eq. are Maxwell's equations, when $\mu = 0$, we got $\nabla \cdot \vec{E} = 0$, when $\mu = i$, we got $\partial_t \vec{E} = \nabla \times \vec{B}$.

#### 2.1.b

We know the energy-momentum tensor can be calculated as,

\[
    T^{\mu}{ }*{\nu} \equiv \frac{\partial \mathcal{L}}{\partial\left(\partial*{\mu} \phi\right)} \partial_{\nu} \phi-\mathcal{L} \delta^{\mu}{ }_{\nu}
\]

Here we use $A_{\lambda}$ as $\phi$ and from [(a)](#21a) we know $\frac{\partial \mathcal{L}}{\partial(\partial_{\mu} \phi)} = - \mathit{F}^{\mu \lambda}$.

So,

\[
    T^{\mu \nu} = \frac{1}{4}\mathit{F}*{\rho \sigma} \mathit{F}^{\rho \sigma} g^{\mu \nu} - \mathit{F}^{\mu \lambda} \partial^{\nu} A*{\lambda}
\]

This expression is not symmetric under the exchange of $\mu$ and $\nu$, so we add another term.

\[
    \hat{T}^{\mu \nu} = \frac{1}{4}\mathit{F}*{\rho \sigma} \mathit{F}^{\rho \sigma} g^{\mu \nu} - \mathit{F}^{\mu \lambda} \partial^{\nu} A*{\lambda} + \partial_{\lambda} (\mathit{F}^{\mu \lambda} A^{\nu})
\]

From [(a)](#21a) we know $\partial_{\lambda} \mathit{F}^{\mu \lambda} = 0$, so we got,

\[
    \hat{T}^{\mu \nu} = \frac{1}{4}\mathit{F}*{\rho \sigma} \mathit{F}^{\rho \sigma} g^{\mu \nu} + \mathit{F}^{\mu \lambda} \mathit{F}*{\lambda}{ }^{\nu}
\]

Now it is symmetric under the exchange of $\mu$ and $\nu$.

\[
    \hat{T}^{00} = \left(-\frac{1}{2} F^{0 i} F^{0 i}+\frac{1}{4} F^{i j} F^{i j}\right)+F^{0 i} F^{0 i}
\]

\[
    \mathit{F}_{\rho \sigma} \mathit{F}^{\rho \sigma} = 2(\vec{B}^2 - \vec{E}^2)  
\]

\[
    \hat{T}^{00} = \frac{1}{2}(\vec{B}^2 + \vec{E}^2)
\]

And,

\[
    \hat{T}^{0i} = \mathit{F}^{0 \lambda} \mathit{F}_{\lambda}{ }^{i} = - \mathit{F}^{0 j} \mathit{F}^{ji}
\]

### Problem 2.2

#### 2.2.a

From the expression of action, we know that $\mathcal{L} = \partial_{\mu} \phi^* \partial^{\mu} \phi - m^2 \phi^* \phi$.

So,

\[
    \pi = \frac{\partial \mathcal{L}}{\partial(\partial_t \phi)} = \partial_t \phi^*
\]

\[
    \pi^*= \frac{\partial \mathcal{L}}{\partial(\partial_t \phi^*)} = \partial_t \phi
\]

And the canonical commutation relations are as below,

\[
    [\phi(\vec{x}), \pi(\vec{y})] = [\phi(t, \vec{x}), \pi(t, \vec{y})] = i \delta^{(3)} (\vec{x}-\vec{y})
\]

Heisenberg equation of motion is,

\[
    i \frac{\partial}{\partial t} \mathcal{O} = [\mathcal{O}, H]
\]

So,

\[
    i \frac{\partial}{\partial t} \phi(x) = [\phi(t, \vec{x}), H(t, \vec{x}')] = \int d^3 x' [\phi(t, \vec{x}), \pi^*(t, \vec{x}')\pi(t, \vec{x}')] = i \pi^*(x)
\]

\[
    i \frac{\partial}{\partial t} \pi^*(x) = \int d^3 x' ([\pi^*, \nabla' \phi^* \cdot \nabla' \phi] + m^2 [\pi^*, \phi^* \phi])
\]

And we noticed that $[\pi^*, \nabla' \phi^* \cdot \nabla' \phi] = [\pi^*, \nabla' \phi^*] \cdot \nabla' \phi = \nabla' [\pi^*, \phi^*] \cdot \nabla' \phi$,

\[
    i \frac{\partial}{\partial t} \pi^*(x) = (-i) \int d^3 x' \{ \nabla' \delta^{(3)}(\vec{x} - \vec{x}') \cdot \nabla' \phi(t, \vec{x}') \} - i m^2 \phi(x)
\]

\[
    \nabla' \delta^{(3)}(\vec{x} - \vec{x}') \cdot \nabla' \phi(t, \vec{x}') = \nabla' \{ \delta^{(3)}(\vec{x} - \vec{x}') \cdot \nabla' \phi(t, \vec{x}') \} - \delta^{(3)}(\vec{x} - \vec{x}') \nabla'^2 \phi(t, \vec{x}')
\]

Because $\delta^{(3)}(\vec{x} - \vec{x}') = 0$ when $\vec{x}'$ goes to the boundary at infinity, after integral the first term was cancelled, then we got,

\[
    i \frac{\partial}{\partial t} \pi^*(x) = i (\nabla^2 - m^2) \phi(x)
\]

So we got,

\[
    \frac{\partial^2}{\partial^2 t} \phi(x) = (\nabla^2 - m^2) \phi(x)
\]

\[
    (\partial^2 + m^2) \phi(x) = 0  
\]

This is the K-G equation.

#### 2.2.b

From [(a)](#22a) we know that $\phi(x)$ is a solution of K-G equation, and noticed that,

\[
    \partial^2 e^{\pm i p \cdot x} = (\partial_t^2 - \nabla^2) e^{\pm (iEt - i \vec{p}\cdot \vec{x})} = (-E^2 + |\vec{p}|^2) e^{\pm i p \cdot x}
\]

So $\phi(x)$ is the linear combination of $e^{\pm i p \cdot x}$.

On the other hand,

\[
    \phi(\vec{x})=\int \frac{d^{3} p}{(2 \pi)^{3}} \frac{1}{\sqrt{2 E_{\vec{p}}}} (a_{\vec{p}} e^{i \vec{p} \cdot \vec{x}}+a_{\vec{p}}^{\dagger} e^{-i \vec{p} \cdot \vec{x}})
\]

\[
    e^{i H t} a_{\vec{p}} e^{-i H t}=a_{\vec{p}} e^{-i E_{\vec{p}} t}
\]

\[
    e^{i H t} a^{\dagger}*{\vec{p}} e^{-i H t}=a^{\dagger}*{\vec{p}} e^{-i E_{\vec{p}} t}
\]

Here the operators for positive and negative frequence are no need to be conjugate with each other, so we have,

\[
    \phi(\vec{x}, t) = e^{i H t} \phi(\vec{x}) e^{-i H t} = \left.\int \frac{d^{3} p}{(2 \pi)^{3}} \frac{1}{\sqrt{2 E_{\vec{p}}}}\left(a_{\vec{p}} e^{-i p \cdot x}+b_{\vec{p}}^{\dagger} e^{i p \cdot x}\right)\right|*{p^{0}=E*{\vec{p}}}
\]

\[
    \pi^*(x) = \frac{\partial}{\partial t} \phi(x) = i \left.\int \frac{d^{3} p}{(2 \pi)^{3}} \frac{\sqrt{E_{\vec{p}}}}{\sqrt{2}}\left( - a_{\vec{p}} e^{-i p \cdot x}+b_{\vec{p}}^{\dagger} e^{i p \cdot x}\right)\right|*{p^{0}=E*{\vec{p}}}
\]

\[
    \phi^* = \phi^{\dagger}
\]

So, we can use $a_{\vec{p}}$ and $b_{\vec{p}}$ to express $H$.

\[
    H = \int \frac{d^3 p}{(2\pi)^3} \frac{E_{\vec{p}}}{2} ( a_{\vec{p}} a^{\dagger}_{\vec{p}} + b^{\dagger}*{\vec{p}} b*{\vec{p}} + a^{\dagger}*{\vec{p}} a*{\vec{p}} + b_{\vec{p}} b^{\dagger}*{\vec{p}} ) = \int \frac{d^3 p}{(2\pi)^3} E*{\vec{p}} (b^{\dagger}_{\vec{p}} b_{\vec{p}} + a^{\dagger}_{\vec{p}} a_{\vec{p}}) + \int d^3 p E_{\vec{p}} \delta^{(3)}(0)
\]

#### 2.2.c

\[
    Q = \frac{1}{2} \int \frac{d^3 p}{(2\pi)^3} (a^{\dagger}*{\vec{p}}a*{\vec{p}} - b_{\vec{p}}b^{\dagger}*{\vec{p}}) = \frac{1}{2} \int \frac{d^3 p}{(2\pi)^3} (a^{\dagger}*{\vec{p}}a_{\vec{p}} - b^{\dagger}*{\vec{p}}b*{\vec{p}}) - \frac{1}{2} \int d^3 p \delta^{(3)}(0)
\]

#### 2.2.d

Waiting for more thinking...

### Problem 2.3

We know that the form of $D(x-y)$ is invarient under the Lorentz transformations, so we can assume $(x-y)^\mu = (0, 0, 0, r)$.

\[
    D(x-y) = \int \frac{p^2 Sin(\theta) dp d\theta d\phi }{(2\pi)^3} \frac{1}{2 \sqrt{m^2 + p^2}} e^{i p r Cos(\theta)} = \frac{1}{8 \pi^2} \int^{\infty}*{0} dp \frac{p^2}{\sqrt{m^2 + p^2}} \int^{\pi}*{0} d\theta\ Sin(\theta)\ e^{i p r Cos(\theta)}
\]

\[
    D(x-y) = \frac{1}{4\pi^2 r} \int^{\infty}_{0} dp \frac{p}{\sqrt{m^2 + p^2}}\ Sin(pr)
\]

## Chapter 3

### Problem 3.1

#### 3.1.a

\[
    [L^i, L^j] = \frac{1}{4} \epsilon^{i l m} \epsilon^{j s t} [J^{l m}, J^{s t}] = \frac{i}{4} \epsilon^{i l m} \epsilon^{j s t} (g^{m s} J^{l t} - g^{l s} J^{m t} - g^{m t} J^{l s} + g^{l t} J^{m s})
\]

The four terms in the braket are equal after switching the indexes, and $g^{ms} = -1$ when $m = s \in \{1, 2, 3\}$ so we got

\[
    [L^i, L^j] = i \epsilon^{i l m} \epsilon^{j s t} g^{m s} J^{l t} = -i \epsilon^{m i l} \epsilon^{m t j} J^{l t} = -i (\delta_{i}^{t} \delta_{l}^{j} - \delta_{i}^{j} \delta_{l}^{t}) J^{lt} = -i J^{j i}
\]

\[
    i \epsilon^{ijk} L^k = \frac{i}{2} \epsilon^{i j k} \epsilon^{k l m} J^{lm} = \frac{i}{2} (J^{ij} - J^{ji}) = -i J^{j i}
\]

\[
    [L^i, L^j] = i \epsilon^{ijk} L^k  
\]

\[
    [K^i, K^j] = [J^{0 i}, J^{0, j}] = i (g^{i 0} J^{0 j} - g^{0 0} J^{i j} - g^{i j} J^{0 0} + g^{0 j} J^{i 0}) = -i J^{i j} = -i \epsilon^{ijk} L^{k}
\]

\[
    [L^i, K^j] = \frac{1}{2} \epsilon_{i m n} [J^{m n}, J^{0 j}] = \frac{1}{2} \epsilon_{i m n} (g^{n j} K^m - g^{m j} K^n) = i \epsilon_{i j k} K^{k}
\]

\[
    [J_+^i, J_-^j] = \frac{1}{4} ([L^i, L^j] - i [L^i, K^j] + i [K^i, L^j] + [K^i, K^j]) = 0
\]

\[
    [J_+^i, J_+^j] = \frac{1}{4} ([L^i, L^j] + i [L^i, K^j] + i [K^i, L^j] - [K^i, K^j]) = \frac{1}{2} (i \epsilon^{i j k} L^k - \epsilon^{i j k} K^k) = i \epsilon^{i j k} J_+^k
\]

\[
    [J_+^i, J_+^j] = i \epsilon^{i j k} J_-^k
\]

#### 3.1.b

Once we get the expression of $\hat{\vec{L}}$ and $\hat{\vec{K}}$, we get a set of generators $J^{\mu \nu}$ of Lorentz group, also we get $\hat{\vec{J}_+}$ and $\hat{\vec{J}_-}$, each of them is a set of generators of rotation group.

when $(j_+, j_-) = (\frac{1}{2}, 0)$, $\hat{J_+^i} = \frac{\sigma^i}{2}$ and $\hat{J_-^i} = 0$

\[
    L^{i}=\left(J_{+}^{i}+J_{-}^{i}\right)=\frac{1}{2} \sigma^{i}
\]

\[
    K^{i}=-\mathrm{i}\left(J_{+}^{i}-J_{-}^{i}\right)=-\frac{\mathrm{i}}{2} \sigma^{i}
\]

\[
    \phi \to (1 - i \theta^i \frac{\sigma^i}{2} - \beta^i \frac{\sigma^i}{2})
\]

This is the transformation of $\psi_L$, eq.(3.37).

#### 3.1.c

Need more thinking ...

### Problem 3.2

We know that $\sigma^{\mu \nu} = \frac{i}{2}[\gamma^{\mu}, \gamma^{\nu}]$, so,

\[
    i \sigma^{\mu \nu} q_{\nu} = (g^{\mu \nu} - \gamma^{\mu} \gamma^{\nu}) (p' - p)*{\nu} = (p' - p)^{\mu} - (2 g^{\mu \nu} - \gamma^{\nu} \gamma^{\mu}) p'*{\nu} + \gamma^{\mu} \gamma^{\nu} p_{\nu} = -(p' + p)^{\mu} + \cancel{p'} \gamma^{\mu} + \gamma^{\mu} \cancel{p}
\]

According to the Dirac equation,

\[
    \bar{u}(p') [\cancel{p'} \gamma^{\mu} + \gamma^{\mu} \cancel{p}] u(p) = \bar{u}(p') [2m \gamma^{\mu}] u(p)
\]

### Problem 3.3

#### 3.3.a

\[
    \cancel{k_0} u_{R0} = \cancel{k_0} \cancel{k_1} u_{L0} = \gamma^\mu k_{0 \mu} \gamma^{\nu} k_{1 \nu} u_{L0} = \frac{1}{2} \{\gamma^\mu, \gamma^\nu\} k_{0 \mu} k_{1 \nu} u_{L0} = g^{\mu \nu} k_{0 \mu} k_{1 \nu} u_{L0} = 0
\]

\[
    \cancel{p} u_{L}(p)=\frac{1}{\sqrt{2 p \cdot k_{0}}} \cancel{p} \cancel{p} u_{R 0}=\frac{1}{\sqrt{2 p \cdot k_{0}}} p^{2} u_{R 0}=0
\]

for the same reason,

\[
    \cancel{p} u_{R}(p) = 0
\]

#### 3.3.b

We know that $u_{L0}$ is the left-handed spinor for a fermion with momentum $k_0$, so $m=0$ and $\cancel{k_0}u_{L0} = 0$.

\[
    k_{0} u_{L 0}=0 \quad \Rightarrow \quad\left(\begin{array}{cccc}
        0 & 0 & 0 & 0 \\
        0 & 0 & 0 & 2 E \\
        2 E & 0 & 0 & 0 \\
        0 & 0 & 0 & 0
        \end{array}\right) u_{L 0}=0
\]

\[
    u_{L 0} = (0, \sqrt{2E}, 0, 0)^{T}
\]

\[
    u_{R 0} = (0, 0, -\sqrt{2E}, 0)^{T}
\]

We have $u_{L}(p) = \frac{1}{\sqrt{2 p cdot k_0}} \cancel{p} u_{R0}$ and $u_{R}(p) = \frac{1}{\sqrt{2 p cdot k_0}} \cancel{p} u_{L0}$

\[
    u_{L}(p) = \frac{1}{\sqrt{p_{0}+p_{3}}}\left(\begin{array}{c}
        -\left(p_{0}+p_{3}\right) \\
        -\left(p_{1}+i p_{2}\right) \\
        0 \\
        0
        \end{array}\right)
\]

\[
    u_{R}(p)=\frac{1}{\sqrt{p_{0}+p_{3}}}\left(\begin{array}{c}
        0 \\
        0 \\
        -p_{1}+i p_{2} \\
        p_{0}+p_{3}
        \end{array}\right)
\]

#### 3.3.c

\[
    s(p, q)=\bar{u}*{R}(p) u*{L}(q)=\frac{\left(p_{1}+i p_{2}\right)\left(q_{0}+q_{3}\right)-\left(q_{1}+i q_{2}\right)\left(p_{0}+p_{3}\right)}{\sqrt{\left(p_{0}+p_{3}\right)\left(q_{0}+q_{3}\right)}}
\]

\[
    t(p, q)=\bar{u}*{L}(p) u*{R}(q)=\frac{\left(q_{1}-i q_{2}\right)\left(p_{0}+p_{3}\right)-\left(p_{1}-i p_{2}\right)\left(q_{0}+q_{3}\right)}{\sqrt{\left(p_{0}+p_{3}\right)\left(q_{0}+q_{3}\right)}}
\]

So $s(p, q) = -s(q, p)$ and $t(p, q) = (s(q, p))^*$

### Problem 3.4

#### 3.4.a

### Problem 3.5

#### 3.5.a

\[
    \delta\left(\partial_{\mu} \phi^{*} \partial^{\mu} \phi\right) = - \mathrm{i}\left(\partial_{\mu} \chi^{*} \sigma^{2} \epsilon^{\dagger}\right) \partial^{\mu} \phi+\left(\partial_{\mu} \phi^{*}\right)\left(-\mathrm{i} \epsilon^{T} \sigma^{2} \partial^{\mu} \chi\right)
\]

\[
    \delta\left(F^{*} F\right)=\mathrm{i}\left(\partial_{\mu} \chi^{\dagger}\right) \bar{\sigma}^{\mu} \epsilon F-\mathrm{i} F^{*} \epsilon^{\dagger} \bar{\sigma}^{\mu} \partial_{\mu} \chi
\]

#### 3.5.b

\[
    \delta(\Delta \mathcal{L})=-\mathrm{i} m \epsilon^{T} \sigma^{2} \chi F-\mathrm{i} m \phi \epsilon^{\dagger} \bar{\sigma}^{\mu} \partial_{\mu} \chi+\frac{1}{2} \mathrm{i} m\left[\epsilon^{T} F+\epsilon^{\dagger}\left(\sigma^{2}\right)^{T}\left(\sigma^{\mu}\right)^{T} \partial_{\mu} \phi\right] \sigma^{2} \chi
\]

\[
    +\frac{1}{2} \mathrm{i} m \chi^{T} \sigma^{2}\left[\epsilon F+\sigma^{\mu}\left(\partial_{\mu} \phi\right) \sigma^{2} \epsilon^{*}\right]+\mathrm{c.c}
\]

### Problem 3.6

#### 3.6.a

We need to find the normalization coefficients of all 16 elements.

\[
    tr[\gamma^0 \gamma^0] = 4
\]

\[
    tr[\gamma^i \gamma^i] = -4
\]

So, there are $\gamma^0$ and $i \gamma^i$ in the $\Gamma^A$

#### 3.6.b

Multiply equation at left by $(\bar{u}_2 \Gamma^F u_3)(\bar{u}_4 \Gamma^E u_1)$.

Also, notice that $\bar{u}_i \Gamma u_j$ is a $1\times 1$ number, so the order can be changed as you want; and $(\bar{u}_i \Gamma u_i) = {tr} (\bar{u}_i \Gamma u_i) = {tr} (\Gamma)$. With these equations, we can derive the equation we need.

#### 3.6.c

Use the results of [(b)](#36b), we can get it easily.

### Problem 3.7

#### 3.7.a

\[
    P \bar{\psi}(t, \mathbf{x}) \sigma^{\mu \nu} \psi(t, \mathbf{x}) P=\frac{\mathrm{i}}{2} \bar{\psi}(t,-\mathbf{x}) \gamma^{0}\left[\gamma^{\mu}, \gamma^{\nu}\right] \gamma^{0} \psi(t,-\mathbf{x})
\]

\[
    \gamma^0 [\gamma^0, \gamma^i] \gamma^0 = - [\gamma^0, \gamma^i]
\]

\[
    \gamma^0 [\gamma^i, \gamma^j] \gamma^0 = [\gamma^i, \gamma^j]
\]

Notice that $\hat{T} \gamma^{\mu} \hat{T} = (\gamma^{\mu})^*$.

#### 3.7.b

\[
    \phi(\vec{x}, t) = e^{i H t} \phi(\vec{x}) e^{-i H t} = \left.\int \frac{d^{3} p}{(2 \pi)^{3}} \frac{1}{\sqrt{2 E_{\vec{p}}}}\left(a_{\vec{p}} e^{-i p \cdot x}+b_{\vec{p}}^{\dagger} e^{i p \cdot x}\right)\right|*{p^{0}=E*{\vec{p}}}
\]

\[
    P a_{\vec{p}} P = a_{\vec{-p}}
\]

So,

\[
    P \phi(\vec{x}, t) P = \int \frac{d^{3} p}{(2 \pi)^{3}} \frac{1}{\sqrt{2 E_{\vec{p}}}}\left(a_{-\vec{p}} e^{-i p \cdot x}+b_{-\vec{p}}^{\dagger} e^{i p \cdot x}\right) |*{p^{0}=E*{\vec{p}}}
\]

Replace the variable $-\vec{p}$ with $\vec{p}$,

\[
    P \phi(\vec{x}, t) P = \int \frac{d^{3} p}{(2 \pi)^{3}} \frac{1}{\sqrt{2 E_{\vec{p}}}}\left(a_{\vec{p}} e^{-i (p_0 t + \vec{p} \cdot \vec{x})}+b_{\vec{p}}^{\dagger} e^{i (p_0 t + \vec{p} \cdot \vec{x})}\right) |*{p^{0}=E*{\vec{p}}} = \phi(-\vec{x}, t)
\]

\[
    C \phi(x) C = \int \frac{d^{3} p}{(2 \pi)^{3}} \frac{1}{\sqrt{2 E_{\vec{p}}}} (a^{\dagger}*{\vec{p}} e^{i p \cdot x} + b*{\vec{p}} e^{-i p \cdot x}) = \phi^{*}(x)
\]

## Chapter 4

### Problem 4.1

#### 4.1.a

\[
    M =  *{in}<0|0>*{out} = \lim_{T \to \infty(1-i\epsilon)} <0|e^{-i H (2T)}|0>
\]

\[
    \lim_{T \to \infty(1-i\epsilon)} e^{-i H (2T)}|0> = \lim_{T \to \infty(1-i\epsilon)} \Sigma_{n} e^{-i E_n (2T)} |n><n|0> \approx \lim_{T \to \infty(1-i\epsilon)} e^{-i E_0 (2T)} |\Omega><\Omega|0>
\]

\[
    M = \lim_{T \to \infty(1-i\epsilon)} e^{-i E_0 (2T)} |<\Omega|0>|^2
\]

From P.87, we have

\[
    1=\langle\Omega \mid \Omega\rangle=\left(|\langle 0 \mid \Omega\rangle|^{2} e^{-i E_{0}(2 T)}\right)^{-1}\left\langle 0\left|U\left(T, t_{0}\right) U\left(t_{0},-T\right)\right| 0\right\rangle
\]

So,

\[
    M = \lim_{T \to \infty(1-i\epsilon)} \left\langle 0\left|U\left(T, t_{0}\right) U\left(t_{0},-T\right)\right| 0\right\rangle
\]

\[
    P(0) = |M|^2 = \lim_{T \to \infty(1-i\epsilon)} \left|\left\langle 0\left|T \exp \left\{-i \int \mathrm{d}^{4} x \mathcal{H}_{\mathrm{int}}\right\}\right| 0\right\rangle\right|^{2}
\]

#### 4.1.b

In the expansion of the exponential, those terms propotional to $j$, $j^3$ ... will vanish because they cannot contract completely, so the expansion is

\[
    1 - \frac{1}{2} \int d^4 x j(x) \phi(x) \int d^4 y j(y) \phi(y) + O(j^4)
\]

\[
    M = 1 - \frac{1}{2} \int d^4 x \int d^4 y j(x) j(y) <0|T{\phi(x) \phi(y)}|0> + O(j^4)
\]

Assume $x^0 > y^0$,

\[
    <0|T{\phi(x) \phi(y)}|0> = \int \frac{d^3 p}{(2\pi)^3} \frac{1}{2 E_p} e^{-ip\cdot(x-y)}
\]

\[
    M = 1 - \frac{1}{2} \int \frac{d^3 p}{(2\pi)^3} \frac{1}{2 E_p} \tilde{j}(p) \tilde{j}(-p) + O(j^4)
\]

If $\tilde{j}(p) \tilde{j}(-p) = |\tilde{j}(p)|^2$

\[
    P(0) = |M|^2 = 1 - \int \frac{d^3 p}{(2\pi)^3} \frac{1}{2 E_p} |\tilde{j}(p)|^2 + O(j^4)
\]

So, $\lambda = <N>$.

#### 4.1.c

Feynman diagrams are some line segments.

#### 4.1.d

\[
    P = | *{out}<\vec{k}|0>*{in}|^2
\]

\[
    M = 1 + i \int d^4 x j(x) <\vec{k}|\phi(x)|0> = i \int d^4 x j(x) e^{ip \cdot x} = i \tilde{j}(p)
\]

So, for one particle, the first term is

\[
    P = |M|^2 = |\tilde{j}(p)|^2
\]

The n-th term is

\[
    \frac{(-1)^n i}{(2n+1)!} \int d^4 x_1 ... d^4 x_{2n+1} j(x_1)... j(x_{2n+1}) <\vec{k}|T\phi(x_1)\phi(x_2)...\phi(x_{2n+1})|0>
\]

\[
    = \frac{(-1)^n i}{(2n+1)!} (2n+1)(2n-1)...1 \int d^4 x_1 e^{ik\cdot x_1} j(x_1) (\int \frac{d^3 p}{(2\pi)^3} \frac{1}{2 E_{\vec{p}}} |\tilde{j}(p)|^2)^n
\]

\[
    = \frac{(-1)^n i}{2^n n!} \tilde{j}(k) \lambda^n
\]

\[
    P = \left|\sum_{n=0}^{\infty} \frac{(-\lambda / 2)^{n}}{n !} i \tilde{j}(k) \right|^{2} = |\tilde{j}(k)|^2 e^{-\lambda}
\]

#### 4.1.e

In the final state, different momentum distribution should be summed over the probabilities.

\[
    P = \frac{1}{n!} \int \frac{\mathrm{d}^{3} k_{1} \cdots \mathrm{d}^{3} k_{n}}{(2 \pi)^{3 n} 2^{n} E_{\mathbf{k}*{1}} \cdots E*{\mathbf{k}*{n}}} |\left\langle\mathbf{k}*{1} \cdots \mathbf{k}_{n}\left|T \exp \left\{i \int \mathrm{d}^{4} x j(x) \phi_{I}(x)\right\}\right| 0\right\rangle |^2
\]

the $\frac{1}{n!}$ represents the symmetry of exchanging $\vec{k_i}$ and $\vec{k_j}$.

The first term of M is

\[
    \frac{i^n}{n!} \int d^4 x_1 ... d^4 x_n j(x_1) ... j(x_n) <\vec{k_1}...\vec{k_n}|T\phi(x_1)...\phi(x_n)|0> = \frac{i^n}{n!} \tilde{j}(k_1) ... \tilde{j}(k_n)
\]

the (m+1)-th term of M is

\[
    \frac{i^{n+2m}}{(n+2m)!} \frac{(n+2m)!}{2^m m!} \tilde{j}(k_1) ... \tilde{j}(k_n) \int \frac{d^3 p_1 ... d^3 p_m}{(2\pi)^{3m} 2^m E_{p_1} ... E_{p_m}} |\tilde{j}(p_1)|^2 ... |\tilde{j}(p_m)|^2
\]

\[
    = i^n\tilde{j}(k_1) ... \tilde{j}(k_n) (\frac{- \lambda}{2})^m \frac{1}{m!}
\]

\[
    P = \frac{1}{n!} \int \frac{\mathrm{d}^{3} k_{1} \cdots \mathrm{d}^{3} k_{n}}{(2 \pi)^{3 n} 2^{n} E_{\mathbf{k}*{1}} \cdots E*{\mathbf{k}_{n}}} |i^n \tilde{j}(k_1) ... \tilde{j}(k_n) e^{-\frac{\lambda}{2}}|^2 = \frac{\lambda^n}{n!} e^{-\lambda}
\]

#### 4.1.f

\[
    \Sigma_{n=0}^{\infty} P(n) = \Sigma_{n=0}^{\infty} \frac{\lambda^n}{n!} \cdot \exp(-\lambda) = 1
\]

\[
    \Sigma_{n=0}^{\infty} n P(n) = \Sigma_{n=1}^{\infty} n P(n) = \lambda \exp(-\lambda) \Sigma_{n=1}^{\infty} \frac{\lambda^{n-1}}{(n-1)!} = \lambda
\]

from the above equation,

\[
    \Sigma_{n=1}^{\infty} \frac{n \lambda^n}{n!} = \lambda \cdot e^{\lambda}
\]

apply $\lambda \frac{d}{d \lambda}$ to both sides, then we get

\[
    \Sigma_{n=1}^{\infty} \frac{n^2 \lambda^n}{n!} = (\lambda^2 + \lambda) \cdot e^{\lambda}
\]

\[
    <(N - <N>)^2> = (\lambda^2 + \lambda) - \lambda^2 = \lambda
\]

### Problem 4.2

The decay process is $\Phi \to \phi + \phi$, lifetime of $\Phi$ is $\tau = \frac{1}{\Gamma}$, $\Gamma = \int d\Gamma$.

From (4.86), we know the decay rate formula,

\[
    \int \mathrm{d} \Gamma=\frac{1}{2 M} \int \frac{\mathrm{d}^{3} p_{1} \mathrm{~d}^{3} p_{2}}{(2 \pi)^{6}} \frac{1}{4 E_{\mathbf{p}*{1}} E*{\mathbf{p}*{2}}}\left|\mathcal{M}\left(\Phi(0) \rightarrow \phi\left(p*{1}\right) \phi\left(p_{2}\right)\right)\right|^{2}(2 \pi)^{4} \delta^{(4)}\left(p_{\Phi}-p_{1}-p_{2}\right)
\]

\[
    \left\langle\mathbf{p}*{1} \mathbf{p}*{2} \cdots|S| \mathbf{k}*{\mathcal{A}} \mathbf{k}*{\mathcal{B}}\right\rangle=\lim *{T \rightarrow \infty}\left\langle\mathbf{p}*{1} \mathbf{p}*{2} \cdots\left|e^{-i H(2 T)}\right| \mathbf{k}*{\mathcal{A}} \mathbf{k}_{\mathcal{B}}\right\rangle
\]

\[
        \lim *{T \rightarrow \infty(1-i \epsilon)} \left(\mathbf{p}*{1} \cdots \mathbf{p}*{n}\left|e^{-i H(2 T)}\right| \mathbf{p}*{\mathcal{A}} \mathbf{p}*{\mathcal{B}}\right\rangle*{0}
\]

\[
\propto \lim _{T \rightarrow \infty(1-i \epsilon)} \ *{0}\left\langle\mathbf{p}*{1} \cdots \mathbf{p}_{n}\left|T\left(\exp \left[-i \int_{-T}^{T} d t H_{I}(t)\right]\right)\right| \mathbf{p}*{\mathcal{A}} \mathbf{p}*{\mathcal{B}}\right\rangle_{0}
\]

We know $S = i + iT$, and

\[
    \left\langle\mathbf{p}*{1} \mathbf{p}*{2} \cdots|i T| \mathbf{k}*{\mathcal{A}} \mathbf{k}*{\mathcal{B}}\right\rangle=(2 \pi)^{4} \delta^{(4)}\left(k_{\mathcal{A}}+k_{\mathcal{B}}-\sum p_{f}\right) \cdot i \mathcal{M}\left(k_{\mathcal{A}}, k_{\mathcal{B}} \rightarrow p_{f}\right)
\]

$\Phi$ and $\phi$ are real scalar fields, so they satisfy K-G eq., with Feynman rules in P.115, we can calculate $\mathcal{M}$ by

\[
    i \mathcal{M} = ( *{0}<\phi \phi|T{ \exp(-i \int d^4 x \mu \Phi \phi \phi) }|\Phi>*{0})_{connected, amputated}
\]

$\mathcal{H}_{I} = \mu \Phi \phi \phi$, the lowest order in $\mu$ is

\[
    i \mathcal{M} = - i \mu ( *{0}<\phi \phi|\int d^4 x (T{  \Phi \phi \phi })|\Phi>*{0})_{connected, amputated}
\]

After contraction,

\[
    i \mathcal{M} = - i \mu * 2 \delta(p_{\Phi}-p_{1}-p_{2})
\]

the factor 2 is because $\phi$s have two ways of contraction, also we can calculate with Feynman rules in P.115, the diagram is one vertex with three external solid lines, here $\int d^4 x$ will also be included in the Feynman rules.

the vertex is $-i \mu$, the external solid line is $1$, and because two ways of contraction refer to same diagram, there will be an extra factor $2$.

With the expression of $\mathcal{M}$, we get

\[
    \Gamma=\frac{1}{2} \cdot \frac{2 \mu^{2}}{M} \int \frac{\mathrm{d}^{3} p_{1} \mathrm{~d}^{3} p_{2}}{(2 \pi)^{6}} \frac{1}{4 E_{\mathbf{p}*{1}} E*{\mathbf{p}*{2}}}(2 \pi)^{4} \delta\left(M-E*{\mathbf{p}*{1}}-E*{\mathbf{p}*{2}}\right) \delta^{(3)}\left(\mathbf{p}*{1}+\mathbf{p}_{2}\right)
\]

the factor $\frac{1}{2}$ is accounted for the exchange of two $\phi$ in the final state.
<span style="color:red">
Notice that when calculating $\mathcal{M}$/Feynman diagrams, we treat each $\phi$ operator differently.
</span>

\[
    \Gamma=\frac{\mu^{2}}{M} \int \frac{\mathrm{d}^{3} p_{1}}{(2 \pi)^{2}} \frac{1}{4 E_{\mathbf{p}*{1}}^{2}} \delta\left(M-2 E*{\mathbf{p}_{1}}\right)=\frac{\mu^{2}}{8 \pi M}\left(1-\frac{4 m^{2}}{M^{2}}\right)^{1 / 2}
\]

<span style="color:red">
Notice here $\delta(M - 2 E_{\mathbf{p}_1}) = \frac{1}{2} \delta(E_{\mathbf{p}_1} - \frac{M}{2})$.
</span>

### Problem 4.3

#### 4.3.a

Firstly, here the propagator is the contraction of two fields in the interaction picture, and when $\lambda = 0$, $H = \Sigma H_i$, so each field $\Phi^i$ satisfies K-G equation separately, the contraction is the standard K-G propagator.

We have $\mathcal{H}_I = \frac{\lambda}{4} (\Sigma_i (\Phi^i)^2 )^2 = \frac{\lambda}{4} ( \Sigma_i (\Phi^i)^4 + 2 \Sigma_{i > j} (\Phi^i)^2 (\Phi^j)^2 )$, if the vertex has four same fields, then one diagram represents $4!$ contraction terms, if the vertex has two kinds of fields, then one diagram represents $2*2$ different contractions, adding the extra factor $2$ in $\mathcal{H}_I$, totally $2^3$ terms.

Therefore, vertex of 4 $\Phi^i$ has value $-i \frac{\lambda}{4} *4! = -6 i \lambda$, and vertex of 2 kinds $\Phi^i$ and $\Phi^j$ has value $-i \frac{\lambda}{4}* 2*2* 2 = -2 i \lambda$.

For $\Phi^1 \Phi^2 \to \Phi^1 \Phi^2$, to the leading order of $\lambda$,

\[
    i \mathcal{M} = \frac{-i \lambda}{4} ( _0<\Phi^1 \Phi^2|\int d^4 x ( (\Phi^1)^2 + (\Phi^2)^2 )^2|\Phi^1 \Phi^2>*0 )*{connected, amputated}
\]

\[
    ( (\Phi^1)^2 + (\Phi^2)^2 )^2 = \Phi^1 \Phi^1 \Phi^1 \Phi^1 + 2*\Phi^1 \Phi^1 \Phi^2 \Phi^2 + \Phi^2 \Phi^2 \Phi^2 \Phi^2
\]

here only the mixed term survived, so $\mathcal{M} = -6 i \lambda$, the diagram is a vertex with 4 external solid lines. With Eq.(4.84)

\[
    \left(\frac{d \sigma}{d \Omega}\right)*{\mathrm{CM}}=\frac{1}{2 E*{\mathcal{A}} 2 E_{\mathcal{B}}\left|v_{\mathcal{A}}-v_{\mathcal{B}}\right|} \frac{\left|\mathbf{p}*{1}\right|}{(2 \pi)^{2} 4 E*{\mathrm{cm}}}\left|\mathcal{M}\left(p_{\mathcal{A}}, p_{\mathcal{B}} \rightarrow p_{1}, p_{2}\right)\right|^{2}
\]

we know that $\Phi^1$ and $\Phi^2$ have same mass, if the mass is ignorable compared to $E_{c.m.}$, we have

\[
    \left(\frac{\mathrm{d} \sigma}{\mathrm{d} \Omega}\right)*{\mathrm{CM}}=\frac{|\mathcal{M}|^{2}}{64 \pi^{2} E*{c.m.}} = \frac{9 \lambda^2}{16 \pi^2 E_{c.m.}}
\]

Same thing for other two decay channels.

#### 4.3.b

Because of the rotation symmetry of $\vec{\Phi}$, we can assume when $\vec{\Phi} = (\Phi^i = 0, \Phi^N = v)$, the potential energy $V = V_{min} = -\frac{1}{2} \mu^2 \nu^2 + \frac{\lambda}{4} \nu^4$, the derivative $\frac{\partial V}{\partial \nu} = \nu (\lambda \nu^2 - \mu^2) = 0$, so we get $\nu = \frac{\mu}{\sqrt{\lambda}}$.

Apply the new coordinates $\Phi^i = \pi^i$ and $\Phi^N = \nu + \sigma$, plus $\Pi^i = \dot{\Phi}^i $, we can get the Lagrangian density,

\[
    \mathcal{L}=\frac{1}{2}\left(\partial_{\mu} \pi^{k}\right)^{2}+\frac{1}{2}\left(\partial_{\mu} \sigma\right)^{2}-\frac{1}{2}\left(2 \mu^{2}\right) \sigma^{2}-\sqrt{\lambda} \mu \sigma^{3}-\sqrt{\lambda} \mu \sigma \pi^{k} \pi^{k} -\frac{\lambda}{4} \sigma^{4}-\frac{\lambda}{2} \sigma^{2}\left(\pi^{k} \pi^{k}\right)-\frac{\lambda}{4}\left(\pi^{k} \pi^{k}\right)^{2}
\]

from the above equation, we can find that $\pi^k$ are $N-1$ massless K-G fields, $\sigma$ is a K-G field with mass $\sqrt{2} \nu$, their propagators have the same form as the K-G propagator.

$\sigma$ field propagator:

\[
    \frac{i}{k^2 - 2\mu^2 +i \epsilon}
\]

$\pi^k$ field propagator:

\[
    \frac{i \delta_{ij}}{k^2 + i \epsilon}
\]

vertex of $3$ $\sigma$ fields:

\[
    - 6 i \sqrt{\lambda} \mu = - 6 i \lambda \nu
\]

factor $6$ is because the exchange of $3$ $\sigma$.

vertex of $\sigma$, $\pi^i$ and $\pi^j$:

\[
    - 2 i \sqrt{\lambda} \mu \delta_{ij} = - 2 i \lambda \nu \delta_{ij}
\]

factor $2$ is accounted for the exchange of two $\pi$, and $\delta_{ij}$ is accounted for
$\pi^k \pi^k = \Sigma_{i = 1}^{N-1} (\pi^i)^2$.

Other Feynman rules are same things.

#### 4.3.c

Because the vertex of $\sigma$, $\pi^i$ and $\pi^j$ has $\delta_{ij}$, so for $\pi^i \pi^1 \to \pi^2 \pi^2$, only the first and the fourth diagram are not vanished.

All fields here are K-G fields, so the first diagram is:

\[
    (-2 i \lambda \nu \delta_{ij}) \cdot \frac{i}{(p_1 + p_2)^2 - 2 \mu^2 + i \epsilon} \cdot (-2 i \lambda \nu \delta_{kl})
\]

The fourth diagram is:

\[
    -2 i \lambda
\]

## Chapter 9

\section{How to use the functional method to get propogator.}
<span style="color:red">
According to (9.34), generating functional $Z[J] = \int \mathcal{D}\phi [\exp(i\int d^4 x \mathcal{L}) \cdot \exp(i\int d^4 x J(x) \phi(x))]$. Then change the variable to get $Z[J] = \int \mathcal{D}\phi' [\exp(i\int d^4 x \mathcal{L'}) \cdot \exp(-\frac{i}{2} \int d^4 x J \hat{O}^{-1} J )]$.
Here the current term is irrelavant to $\phi'$, so $Z[J] = Z_0 \cdot \exp(-\frac{i}{2} \int d^4 x J \hat{O}^{-1} J )$, and the functional derivatives will be applied on the current term.
</span>

### Problem 9.1

#### 9.1.a

\[
    \mathcal{L} = - \frac{1}{4} F^2_{\mu \nu} + (\partial_{\mu} \phi^*- i e A_{\mu} \phi^*)(\partial^{\mu} \phi + i e A^{\mu} \phi) - m^2 \phi^* \phi = \mathcal{L}*{A} + \mathcal{L}*{\phi} + \mathcal{L}_{I}
\]

The $\mathcal{L}_{A}$ is just free E-M field, so the propogator is the propogator of photon.

The $\mathcal{L}_{\phi} = \partial_{\mu} \phi^*\partial^{\mu} \phi - m^2 \phi^* \phi = \partial_{\mu} (\phi^* \partial^{\mu} \phi) - \phi^* \partial_{\mu} (\partial^{\mu} \phi) - m^2 \phi^*\phi$, because the differential term in the Lagrangian density makes no difference, we got $\mathcal{L}_{\phi} = - \phi^* \partial_{\mu} (\partial^{\mu} \phi) - m^2 \phi^* \phi = \phi^* (- \partial^2 - m^2) \phi = \phi^* \hat{T} \phi$.

With generating functional method, we have $\mathcal{L}_{\phi} + \eta^* \phi + \phi^* \eta$ in the $Z[J]$, then do a shift $\phi \to \phi' = \phi + \hat{T}^{-1} \eta$, we got $\mathcal{L}_{\phi} + \eta^*\phi + \phi^* \eta = \mathcal{L}_{\phi'} - \eta^* \hat{T}^{-1} \eta$. If $G$ is the Green function of $\hat{T}$, then $\mathcal{L}_{\phi'} - \eta^*\hat{T}^{-1} \eta = \mathcal{L}_{\phi'} - \eta^* (iG * \eta)$,

\[ Z[\eta, \eta^*] = Z_0 \cdot \exp[-i\int d^4 x d^4 y \ \eta^*(x) i G(x-y) \eta(y) ] \]

\[ \text{prop} = -\frac{\delta}{\delta \eta^*}\frac{\delta}{\delta \eta} \exp[-i\int d^4 x d^4 y \ \eta^*(x) i G(x-y) \eta(y) ] = -G \]

After two functional derivatives, we will find the propogator is exactly the $-G$.

So the propogator of $\phi$ and $\phi^*$ is $\frac{i}{p^2 - m^2 + i \epsilon}$. (How to calculate the Green function of $\hat{T}$ - <span style="color:blue">Check Eq.(2.57) in Peskin</span>)

\[ \hat{T}^{-1} \eta(x) = i \int d^4 y \ G(x-y) \eta(y) \]

\[ \hat{T} G(x-y)  = (-\partial^2-m^2) G(x-y) = -i \delta(x-y) \]

FT to get,

\[ (p^2 - m^2) \tilde{G}(p) = -i \]

\[ -\tilde{G}(p) = \frac{i}{p^2 - m^2} \]

Then comes to vertices, $\mathcal{H}_{I} = - \mathcal{L}_I$ (<span style="color:blue">P. 289 in Peskin</span>), theoretically we should check <span style="color:blue">Eq.(4.31)</span> and do the contraction to get Feynman rules, but here we can just look at $\exp[i \int \mathcal{L}_I]$, here $\mathcal{L}_I = i e g^{\mu \nu} (\partial_{\mu} \phi^*A_{\nu} \phi - A_{\mu} \phi^* \partial_{\nu} \phi) + e^2 g^{\mu \nu} A_{\mu} \phi^*A_{\nu} \phi$, then $i \mathcal{L}_I = -i e g^{\mu \nu} (-i \partial_{\mu} \phi^* A_{\nu} \phi + A_{\mu} \phi^*i \partial_{\nu} \phi) + i e^2 g^{\mu \nu} A_{\mu} \phi^* A_{\nu} \phi$.

There are three terms, let's throw those fields away and turn $i \partial \phi$ to $p_{\phi} \phi$, $-i \partial \phi^*$ to $p_{\phi^*} \phi^*$, here $p$'s are along particle/anti-particle lines, besides, the third term has two $A$ fields, which are commutative, so there should be a factor $2$ for the $AA\phi^*\phi$ vertex.

So,

\[For\ \phi^* A \phi: -i e (p + p')^{\mu}\]

\[For\ AA\phi^* \phi: 2 i e^2 g^{\mu \nu}\]

Theoretically,

\[ <\phi \phi^* | S | \gamma> = <\phi \phi^* | T \int d^4 x i \mathcal{L}*I | \gamma> = <\phi \phi^* | T \int d^4 x (-i e) g^{\mu \nu} (-i \partial*{\mu} \phi^* A_{\nu} \phi + A_{\mu} \phi^* i \partial_{\nu} \phi) | \gamma> \]

and

\[ <\phi \phi^* | S | \gamma \gamma> = <\phi \phi^* | T \int d^4 x i \mathcal{L}*I | \gamma \gamma> = <\phi \phi^* | T \int d^4 x (i e^2) g^{\mu \nu} A*{\mu} \phi^* A_{\nu} \phi | \gamma \gamma> \]

give the Feynman rules of two kinds of vertex with contractions.

#### 9.1.b

With <span style="color:blue">Eq.(4.84)</span>, $m_e$ is ignored, then,

\[(\frac{d \sigma}{d \Omega})*{c.m.} = \frac{|\vec{p}*{\phi}|}{32 (2\pi)^2 E_{e}^2 \cdot 2 E_e } \frac{1}{4} \Sigma |\mathcal{M}(ee \to \phi^*\phi)|^2\]

The outlines of $\phi$ and $\phi^*$ are $1$, the Feynman diagram looks similar to the diagram in <span style="color:blue">P.131</span>.

\[ i \mathcal{M} = (-i e)^2 \bar{v}(k_2) \gamma^{\mu} u(k_1) \frac{-i g_{\mu \nu}}{s + i \epsilon} (p_1 - p_2)^{\nu} = i e^2 \bar{v}(k_2) (\cancel{p_1} - \cancel{p_2}) u(k_1) \frac{1}{s + i \epsilon}\]

\[\frac{1}{4} \sum_{\text{spin}} |\mathcal{M}|^2 = \sum_{\text{spin}} \frac{e^4}{4 s^2} \bar{v}(k_2) (\cancel{p_1} - \cancel{p_2}) u(k_1) \bar{u}(k_1) (\cancel{p_1} - \cancel{p_2}) v(k_2) \]

\[ = \sum_{\text{spin}} \frac{e^4}{4 s^2} \text{tr}( v(k_2) \bar{v}(k_2) (\cancel{p_1} - \cancel{p_2}) u(k_1) \bar{u}(k_1) (\cancel{p_1} - \cancel{p_2}) ) \]

\[ = \frac{e^4}{4 s^2} \text{tr}( \cancel{k_2} (\cancel{p_1} - \cancel{p_2}) \cancel{k_1} (\cancel{p_1} - \cancel{p_2}) ) \]

\[ = \frac{e^{4}}{4 s^{2}}\left[8\left(k_{1} \cdot p_{1}-k_{1} \cdot p_{2}\right)\left(k_{2} \cdot p_{1}-k_{2} \cdot p_{2}\right)-4\left(k_{1} \cdot k_{2}\right)\left(p_{1}-p_{2}\right)^{2}\right] \]

Choose a specific frame,

\[ k_{1}=(E, 0,0, E), \ \  p_{1}=(E, p \sin \theta, 0, p \cos \theta) \]

\[k_{2}=(E, 0,0,-E), \ \  p_{2}=(E,-p \sin \theta, 0,-p \cos \theta)\]

\[ \frac{1}{4} \sum_{\text{spin}} |\mathcal{M}|^2 = \frac{e^{4} p^{2}}{2 E^{2}} \sin ^{2} \theta \]

$ee \to \mu \mu$ is <span style="color:blue">Eq.(5.11)</span>

So,

\[
    \left(\frac{\mathrm{d} \sigma}{\mathrm{d} \Omega}\right)_{\mathrm{c.m.}}=\frac{1}{2(2 E)^{2}} \frac{p}{8(2 \pi)^{2} E}\left(\frac{1}{4} \sum|\mathcal{M}|^{2}\right)=\frac{\alpha^{2}}{8 s}\left(1-\frac{m^{2}}{E^{2}}\right)^{3 / 2} \sin ^{2} \theta
\]

#### 9.1.c

Two diagrams because there are two kinds of vertex which are listed in [(a)](#91a). Because the minus signs in the $\mathcal{L}_I$ are all absorbed in vertex, and there is no Fermion field, the sign between two vertices is $+$. That's why the two diagrams should be added.

\[ i \Pi^{\mu \nu}_1 = e^2 \int \frac{d^4 k}{(2\pi)^4} (2k + q)^{\mu} \frac{1}{k^2 - m^2 + i \epsilon} (2k+q)^{\nu} \frac{1}{(k+q)^2 - m^2 + i \epsilon} \]

\[ i \Pi^{\mu \nu}_2 = - 2 e^2 g^{\mu \nu} \int \frac{d^4 k}{(2 \pi)^4} \frac{1}{(k+q)^2 - m^2 + i \epsilon} \]

add togeter, get

\[ i \Pi^{\mu \nu} = - e^2 \int \frac{d^4 k}{(2\pi)^4} \frac{2 g^{\mu \nu} (k^2 - m^2) - (2k + q)^{\mu} (2k+q)^{\nu}}{(k^2 - m^2)((k+q)^2 - m^2)} \]

\[ \frac{1}{(k^2 - m^2)((k+q)^2 - m^2)} = \int^1_0 dx \frac{1}{[(k + (1-x)q)^2 + xq^2 -x^2 q^2 - m^2]^2} \]

change the variable, $l = k + (1-x)q$, with <span style="color:blue">Eq.(6.45)</span>,

\[ \text{numerator} = g^{\mu \nu} l^2 + 2 g^{\mu \nu} (1-x)^2 q^2 - 2 g^{\mu \nu} m^2 - (2x-1)^2 q^\mu q^\nu \]

do the Wick rotation, $l^0 = i l^0_E$ and $l^i = l^i_E$, so we have $d^4 l = i d^4 l_E$ and $l^2 = - l^2_E$,

\[ i \Pi^{\mu \nu} = -i e^2 \int^1_0 dx \int \frac{d^4 l_E}{(2\pi)^4} \frac{-g^{\mu \nu} l_E^2 + 2 g^{\mu \nu} (1-x)^2 q^2 - 2 g^{\mu \nu} m^2 - (2x-1)^2 q^\mu q^\nu}{[l_E^2 + m^2 + x^2q^2 - xq^2]^2 } \]

\[= -i e^2 \int^1_0 dx \int \frac{d^4 l_E}{(2\pi)^4} [\frac{-g^{\mu \nu} l_E^2}{(l_E^2 + \Delta)^2} + \frac{2 g^{\mu \nu} (1-x)^2 q^2 - 2 g^{\mu \nu} m^2 - (2x-1)^2 q^\mu q^\nu}{(l_E^2 + \Delta)^2}] \]

use dimensional regularization, with <span style="color:blue">Eq.(7.85) and Eq.(7.86)</span>,

\[ i \Pi^{\mu \nu} = -i e^2 \int^1_0 dx [ (2 g^{\mu \nu} (1-x)^2 q^2 - 2 g^{\mu \nu} m^2 - (2x-1)^2 q^\mu q^\nu) \frac{1}{(4 \pi)^{d / 2}} \frac{\Gamma\left(2-\frac{d}{2}\right)}{\Gamma(2)}\left(\frac{1}{\Delta}\right)^{2-\frac{d}{2}} \]

\[ - g^{\mu \nu} \frac{1}{(4 \pi)^{d / 2}} \frac{d}{2} \frac{\Gamma\left(2-\frac{d}{2}-1\right)}{\Gamma(2)}\left(\frac{1}{\Delta}\right)^{2-\frac{d}{2}-1} ] \]

\[ = -i e^2 \int_0^1 dx \frac{1}{(4\pi)^{d/2}} (\frac{1}{\Delta})^{2-d/2} \Gamma(2-d/2) [ (2 g^{\mu \nu} (1-x)^2 q^2 - (2x-1)^2 q^\mu q^\nu) - g^{\mu \nu} \frac{d}{2-d} (x^2 q^2 - x q^2) ] \]

set $d = 4-\epsilon$ with $\epsilon \to 0$,

\[ i \Pi^{\mu \nu} = \frac{-i e^2}{(4\pi)^{2}} \int_0^1 dx  (\frac{\epsilon}{2} -\log\Delta - \gamma + \log(4\pi)) [ (g^{\mu \nu} (2x-2)(2x-1) q^2 - (2x-1)^2 q^\mu q^\nu) ] \]

Because $\int_0^1 dx  (\frac{2}{\epsilon} -\log\Delta - \gamma + \log(4\pi)) (2x-1) = \int_0^1 dx  \frac{2}{\epsilon} (2x-1) = 0$, we have

\[ i \Pi^{\mu \nu} = \frac{-i e^2}{(4\pi)^{2}} \int_0^1 dx  (\frac{\epsilon}{2} -\log\Delta - \gamma + \log(4\pi)) (2x-1)^2 [ (g^{\mu \nu} q^2 - q^\mu q^\nu) ] \]

with MS-bar scheme,

\[ \Pi(q^2) = \frac{-\alpha}{4\pi} \int_0^1 dx  (-\log\Delta ) (2x-1)^2 \]

If we adopt $-q^2 >> m^2$,

\[ \Pi(q^2) = \frac{-\alpha}{4\pi} \int_0^1 dx  (-\log(x - x^2) - \log(-q^2) ) (2x-1)^2  \to \frac{-\alpha}{12 \pi} \log(-q^2)\]

while looking at Eq.(7.90), $\int_0^1 dx x(1-x) = \frac{1}{6}$, we know for $e+e-$ pair,

\[ \Pi(q^2) \to \frac{-\alpha}{3 \pi} \log(-q^2) \]

which is four times as our results.

### Problem 9.2

#### 9.2.a

In [Ch.9.1](#Problem-91), because of superposition principle, the  we have

\[ U\left(x_{a}, x_{b} ; T\right)=\sum_{\text {all paths }} e^{i \cdot(\text { phase })}=\int \mathcal{D} x(t) e^{i \cdot(\text { phase })} \]

\[ \left\langle x_{b}\left|e^{-i H T / \hbar}\right| x_{a}\right\rangle=U\left(x_{a}, x_{b} ; T\right)=\int \mathcal{D} x(t) e^{i S[x(t)] / \hbar} \]

Here if we treat $H$ as a matrix in the linear space constructed by eigenstates $\left. | q \right\rangle$, the trace can be rewritten as $Z = \int d^d q \left\langle q | e^{-\beta H} | q \right\rangle$. \red{However, we do not know how to write it as a functional integral yet because we do not know what is the "action" here.}

It is true that you can use eigenstates $| p \rangle$ to write $Z = \int \frac{d^d p}{(2\pi)^d} \left\langle p | e^{-\beta H} | p \right\rangle$, but you will meet $\langle p_2 | \hat{x} | p_1 \rangle = \int d^d q \ e^{-i (p_2 - p_1)q} \cdot q$

Recall the equations about location and momentum eigenstates,

\[ 1=\int \mathrm{d}^{d} q|q\rangle\langle q|=\int \frac{\mathrm{d}^{d} p}{(2 \pi)^{d}}|p\rangle\langle p| \]

\[ |q\rangle = \int \frac{\mathrm{d}^{d} p}{(2 \pi)^{d}} e^{-i p \cdot q} |p\rangle \]

\[ \langle p|q\rangle = e^{-i p \cdot q} \]

Then we suppose that $H = \frac{p^2}{2m} + V(q)$, and separate $Z$ as

\[ e^{- \beta H} = e^{-\epsilon H} \cdot e^{-\epsilon H} \dots \]

\[ Z = \int d^d q (\prod_{j=1}^{N-1} \int d^d q_j )  \langle q | e^{-\epsilon H} | q_{N-1} \rangle \dots \langle q_{i+1} | e^{-\epsilon H} | q_{i} \rangle \dots \langle q_{1} | e^{-\epsilon H} | q \rangle \]

\[ \langle q_{i+1} | e^{-\epsilon H} | q_{i} \rangle = e^{-\epsilon V(q_i)} \langle q_{i+1} | e^{-\epsilon \frac{p^2}{2m}} | q_{i} \rangle = e^{-\epsilon V(q_i)} \int \frac{\mathrm{d}^{d} p_i}{(2 \pi)^{d}} \frac{\mathrm{d}^{d} p_{i+1}}{(2 \pi)^{d}}  \langle q_{i+1} | p_{i+1} \rangle \langle p_{i+1} | e^{-\epsilon \frac{p^2}{2m}} | p_i \rangle \langle p_i | q_{i} \rangle  \]

\[ = e^{-\epsilon V(q_i)} \int \frac{\mathrm{d}^{d} p_i}{(2 \pi)^{d}} \langle q_{i+1} | p_{i} \rangle e^{-\epsilon \frac{p_i^2}{2m}} \langle p_i | q_{i} \rangle = e^{-\epsilon V(q_i)} \int \frac{\mathrm{d}^{d} p_i}{(2 \pi)^{d}} e^{i p_i \cdot (q_{i+1} - q_i)} \cdot e^{-\epsilon \frac{p_i^2}{2m}} \]

\[ = \left[\frac{m}{2 \pi \epsilon}\right]^{d / 2} e^{-m\left(q_{i+1}-q_{i}\right)^{2} / 2 \epsilon} \cdot e^{-\epsilon V(q_i)} \]

here we can find that $q \to q_1 \to \dots \to q_{N-1} \to q$ is a loop route, so we set $q_0 = q_N = q$ and we multiply all terms together to get

\[ Z=\left[\frac{m}{2 \pi \epsilon}\right]^{N d / 2} \prod_{i=0}^{N-1} \int \mathrm{d}^{d} q_{i} \exp \left[-\frac{m\left(q_{i+1}-q_{i}\right)^{2}}{2 \epsilon}-\epsilon V\left(q_{i}\right)\right] \]

\[=\left[\frac{m}{2 \pi \epsilon}\right]^{N d / 2} (\prod_{i=0}^{N-1} \int \mathrm{d}^{d} q_{i}) \exp \left[-\beta \sum_{i=0}^{N-1} \frac{1}{N} ( \frac{m\left(q_{i+1}-q_{i}\right)^{2}}{2 \epsilon^2} + V\left(q_{i}\right))\right]\]

When $N \to \infty$, define $\int \mathcal{D} q = \lim_{N\to \infty} ( \left[\frac{m}{2 \pi \epsilon}\right]^{N d / 2} (\prod_{i=0}^{N-1} \int \mathrm{d}^{d} q_{i}) )$, so we get

\[ Z = \int \mathcal{D} q \exp[-\beta \oint dt L_E[q(t)]] \]

\[ L_E[q(t)] = \frac{m}{2} (\frac{dq}{dt})^2 + V(q(t)) \]
