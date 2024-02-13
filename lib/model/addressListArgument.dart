class addressListArgument {
  bool IsSelectionEnable;
  String selectedAddressid;
  dynamic param;

  addressListArgument({this.IsSelectionEnable, this.selectedAddressid, this.param});

  @override
  String toString() {
    return '{id: $IsSelectionEnable, heroTag:${selectedAddressid.toString()}}';
  }
}
