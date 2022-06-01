const std = @import("std");
const Input = @import("input.zig");

pub fn main() void {
    partOne();
    partTwo();
}

fn partOne() void {
    var increases_number: u16 = 0;
    var previous_depth: u16 = Input.data[0];

    for (Input.data) |depth| {
        if (depth > previous_depth) {
            increases_number += 1;
        }

        previous_depth = depth;
    }

    std.debug.print("{}\n", .{increases_number});
}

fn partTwo() void {
    var increases_number: u16 = 0;
    var previous_window_sum: ?u16 = null;

    var i: u16 = 1;
    var window_sum: u16 = undefined;
    while (i < Input.data.len - 1) : ({
        i += 1;
        previous_window_sum = window_sum;
    }) {
        window_sum = Input.data[i - 1] + Input.data[i] + Input.data[i + 1];

        if (previous_window_sum == null) continue;

        if (window_sum > previous_window_sum.?) {
            increases_number += 1;
        }
    }

    std.debug.print("{}\n", .{increases_number});
}