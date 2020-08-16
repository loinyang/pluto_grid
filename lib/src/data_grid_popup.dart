part of pluto_grid;

class PlutoGridPopup {
  final BuildContext context;
  final List<PlutoColumn> columns;
  final List<PlutoRow> rows;
  final PlutoMode mode;
  final void Function(PlutoRow row) onSelectedRow;
  final double width;
  final double height;

  PlutoGridPopup({
    this.context,
    this.columns,
    this.rows,
    this.mode,
    this.onSelectedRow,
    this.width,
    this.height,
  }) {
    this.open();
  }

  Future<void> open() async {
    PlutoRow selectedRow = await showDialog<PlutoRow>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select'),
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  width: width ?? 500,
                  height: height ?? 600,
                  child: PlutoGrid.popup(
                    columns: columns,
                    rows: rows,
                    mode: mode,
                    onSelectedRow: (PlutoOnSelectedEvent event) {
                      Navigator.pop(context, event.row);
                    },
                  ),
                ),
              ),
            ],
          );
        });
    if (onSelectedRow != null) {
      onSelectedRow(selectedRow);
    }
  }
}
