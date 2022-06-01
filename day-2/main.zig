const std = @import("std");
const Input = @import("input.zig");

const Move = struct { direction: Direction, length: u16 };

const Direction = enum { forward, down, up };

pub fn main() void {
    partOne();
    partTwo();
}

fn partOne() void {
    var axe_horizontal: isize = 0;
    var axe_depth: isize = 0;

    for (Input.data) |entry| {
        const move: Move = parseMove(entry);

        switch (move.direction) {
            Direction.forward => axe_horizontal += move.length,
            Direction.down => axe_depth += move.length,
            Direction.up => axe_depth -= move.length,
        }
    }

    std.debug.print("Horizontal({}) * Depth({}) = {}\n", .{ axe_horizontal, axe_depth, axe_horizontal * axe_depth });
}

fn partTwo() void {
    var axe_horizontal: isize = 0;
    var axe_depth: isize = 0;
    var aim: isize = 0;

    for (Input.data) |entry| {
        const move: Move = parseMove(entry);

        switch (move.direction) {
            Direction.down => aim += move.length,
            Direction.up => aim -= move.length,
            Direction.forward => {
                axe_horizontal += move.length;
                axe_depth += aim * move.length;
            },
        }
    }

    std.debug.print("Horizontal({}) * Depth({}) = {}\n", .{ axe_horizontal, axe_depth, axe_horizontal * axe_depth });
}

fn parseMove(entry: []const u8) Move {
    return Move{ .direction = switch (entry[0]) {
        'f' => Direction.forward,
        'u' => Direction.up,
        'd' => Direction.down,
        else => unreachable,
    }, .length = @as(u16, entry[entry.len - 1] - '0') };
}
