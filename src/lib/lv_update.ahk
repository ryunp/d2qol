/**
 * Update the list items in listview controls
 * @param {int} hwnd_gui The parent window handle of the ListView control
 * @param {int} hwnd_lv  Control handle for the ListView
 * @param {array} items     Double dimensions array representing tabular data
 */
LV_Update(hwnd_gui, hwnd_lv, items) {
    Gui, % hwnd_gui ":Default"
    Gui, ListView, % hwnd_lv

    ; Remove current items
    LV_Delete()

    ; Repopulate with new items
    for i, params in items {
        LV_Add(params*)
    }
}