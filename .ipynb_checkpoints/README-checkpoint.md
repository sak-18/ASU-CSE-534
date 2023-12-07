# README

This project explores an implementation of packet tracing using a P4 implementation. Current packet tracing
algorithms have limitations in terms of readability, protocol-dependence, and flexibility which network programmability can
address. A P4-based working implementation on FABRIC is pro-vided in this project, which is tested on two different topologies.
Some challenges in scaling this implementation are discussed with possible future extensions. Code snippets for the implementation
are provided for reproducibility.

Final Report: https://www.overleaf.com/read/tsnwnfmnhxpf#3f4893

Instructions:
The experiment consists of two topologies - small and large.

The `small_topo` directory contains the necessary code for running the tracing experiment on a smaller topology. It has been adapted from UofSC tutorials. The main P4 ingress, egress, parser and header structures can be looked in the `small_topo/p4_implementation` directory.

The `large_topo` directory contains three notebooks. The first notebook walks through creating a large topology slice on the FABRIC testbed. The second notebook is used to create subnets and assign IPs on the larger topology. The final notebook is for helping with traceroute measurments.

Each of the notebook has detailed instructions which can be followed to reproduce the experiments on FABRIC.

## Acknowledgements
A special thanks to Dr. Violet Syrotiuk for providing the students with a great oppurtunity to run experiments on the FABRIC testbed and facilitating continous feedback over the course of project development.