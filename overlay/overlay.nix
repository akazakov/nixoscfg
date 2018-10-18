self: super:

{
  minikube = super.callPackage ./minikube {
    inherit (self.darwin.apple_sdk.frameworks) vmnet;
  };
}
