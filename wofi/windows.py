#!/bin/python3

# source: https://github.com/EndeavourOS-Community-Editions/sway/blob/e6a672223206ceeb86123bb14eead7b774d685b1/.config/wofi/windows.py
# license: GNU General Public License v3.0
# changes: made code harder to read; functionally unchanged.

import json
import subprocess
from argparse import ArgumentParser


def get_windows():
    data = json.loads(
        subprocess.Popen("swaymsg -t get_tree",
                         shell=True,
                         stdout=subprocess.PIPE,
                         stderr=subprocess.PIPE).communicate()[0])

    # Select outputs that are active
    windows = []
    for output in data["nodes"]:

        # The scratchpad (under __i3) is not supported
        if output.get("name") != "__i3" and output.get("type") == "output":
            for ws in output.get("nodes", []):
                if ws.get("type") == "workspace":
                    windows.extend(extract_nodes_iterative(ws))

    return windows


# Extracts all windows from a sway workspace json object
def extract_nodes_iterative(workspace):
    all_nodes = workspace.get("floating_nodes", [])

    nodes = workspace.get("nodes", [])
    for node in nodes:
        if not node.get("nodes"):  # Leaf node
            all_nodes.append(node)
        else:  #Nested node, handled iterative
            for inner_node in node.get("nodes"):
                nodes.append(inner_node)

    return all_nodes


# Returns an array of all windows
def parse_windows(windows):
    return [window.get("name") for window in windows]


# Returns a newline seperated UFT-8 encoded string of all windows for wofi
def build_wofi_string(windows):
    return "\n".join(windows).encode("UTF-8")


# Executes wofi with the given input string
def show_wofi(windows):
    command = 'wofi -c ~/.config/wofi/menu -s ~/.config/wofi/style.css -p "" -d -i --hide-scroll'
    return subprocess.Popen(
        command, shell=True, stdin=subprocess.PIPE,
        stdout=subprocess.PIPE).communicate(input=windows)[0]


# Returns the sway window id of the window that was selected by the user inside wofi
def parse_id(windows, parsed_windows, selected):
    if not selected:
        return None

    selected = selected.decode("UTF-8").rstrip()
    window_index = parsed_windows.index(selected)
    return str(windows[window_index].get("id"))


# Switches the focus to the given id
def switch_window(window_id):
    command = f"swaymsg [con_id={window_id}] focus"
    return subprocess.Popen(command, shell=True,
                            stdout=subprocess.PIPE).communicate()[0]


# Entry point
if __name__ == "__main__":
    parser = ArgumentParser(description="Wofi based window switcher")

    windows = get_windows()
    parsed_windows = parse_windows(windows)
    wofi_string = build_wofi_string(parsed_windows)
    selected = show_wofi(wofi_string)

    # Otherwise no point in running
    if selected:
        selected_id = parse_id(windows, parsed_windows, selected)
        switch_window(selected_id)
