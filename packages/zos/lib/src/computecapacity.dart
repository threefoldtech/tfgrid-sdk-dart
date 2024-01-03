class ComputeCapacity {
  int cpu;
  int memory; // in bytes

  ComputeCapacity({
    required this.cpu,
    required this.memory,
  });

  String challenge() {
    String out = "";
    out += this.cpu as String;
    out += this.memory as String;
    return out;
  }
}
