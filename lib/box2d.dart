/*******************************************************************************
 * Copyright (c) 2015, Daniel Murphy, Google
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *  * Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *  * Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 ******************************************************************************/

library box2d;

import 'dart:collection';
import 'dart:math' as Math;
import 'dart:typed_data';

import 'src/buffer_utils.dart' as BufferUtils;
import 'src/common.dart';
import 'src/math_utils.dart' as MathUtils;
import 'src/settings.dart' as Settings;
import 'src/vector_math.dart';

export 'src/common.dart';
export 'src/vector_math.dart';

part 'src/callbacks/contact_filter.dart';
part 'src/callbacks/contact_impulse.dart';
part 'src/callbacks/contact_listener.dart';
part 'src/callbacks/debug_draw.dart';
part 'src/callbacks/destruction_listener.dart';
part 'src/callbacks/pair_callback.dart';
part 'src/callbacks/particle_destruction_listener.dart';
part 'src/callbacks/particle_query_callback.dart';
part 'src/callbacks/particle_raycast_callback.dart';
part 'src/callbacks/query_callback.dart';
part 'src/callbacks/raycast_callback.dart';
part 'src/callbacks/tree_callback.dart';
part 'src/callbacks/tree_raycast_callback.dart';

part 'src/collision/aabb.dart';
part 'src/collision/collision.dart';
part 'src/collision/contactid.dart';
part 'src/collision/distance.dart';
part 'src/collision/distance_input.dart';
part 'src/collision/distance_output.dart';
part 'src/collision/manifold.dart';
part 'src/collision/manifold_point.dart';
part 'src/collision/raycast_input.dart';
part 'src/collision/raycast_output.dart';
part 'src/collision/time_of_impact.dart';
part 'src/collision/world_manifold.dart';

part 'src/collision/broadphase/broadphase.dart';
part 'src/collision/broadphase/broadphase_strategy.dart';
part 'src/collision/broadphase/default_broadphase_buffer.dart';
part 'src/collision/broadphase/dynamic_tree.dart';
part 'src/collision/broadphase/dynamic_tree_flatnodes.dart';
part 'src/collision/broadphase/dynamic_tree_node.dart';
part 'src/collision/broadphase/pair.dart';

part 'src/collision/shapes/chain_shape.dart';
part 'src/collision/shapes/circle_shape.dart';
part 'src/collision/shapes/edge_shape.dart';
part 'src/collision/shapes/mass_data.dart';
part 'src/collision/shapes/polygon_shape.dart';
part 'src/collision/shapes/shape.dart';
part 'src/collision/shapes/shape_type.dart';

part 'src/dynamics/body.dart';
part 'src/dynamics/body_def.dart';
part 'src/dynamics/body_type.dart';
part 'src/dynamics/contact_manager.dart';
part 'src/dynamics/filter.dart';
part 'src/dynamics/fixture.dart';
part 'src/dynamics/fixture_def.dart';
part 'src/dynamics/fixture_proxy.dart';
part 'src/dynamics/island.dart';
part 'src/dynamics/profile.dart';
part 'src/dynamics/solver_data.dart';
part 'src/dynamics/time_step.dart';
part 'src/dynamics/world.dart';

part 'src/dynamics/contacts/chain_and_circle_contact.dart';
part 'src/dynamics/contacts/chain_and_polygon_contact.dart';
part 'src/dynamics/contacts/circle_contact.dart';
part 'src/dynamics/contacts/contact.dart';
part 'src/dynamics/contacts/contact_creator.dart';
part 'src/dynamics/contacts/contact_edge.dart';
part 'src/dynamics/contacts/contact_position_and_constraint.dart';
part 'src/dynamics/contacts/contact_register.dart';
part 'src/dynamics/contacts/contact_solver.dart';
part 'src/dynamics/contacts/contact_velocity_constraint.dart';
part 'src/dynamics/contacts/edge_and_circle_contact.dart';
part 'src/dynamics/contacts/edge_and_polygon_contact.dart';
part 'src/dynamics/contacts/polygon_and_circle_contact.dart';
part 'src/dynamics/contacts/polygon_contact.dart';
part 'src/dynamics/contacts/position.dart';
part 'src/dynamics/contacts/velocity.dart';

part 'src/dynamics/joints/constant_volume_joints.dart';
part 'src/dynamics/joints/constant_volume_joints_def.dart';
part 'src/dynamics/joints/distance_joint.dart';
part 'src/dynamics/joints/distance_joint_def.dart';
part 'src/dynamics/joints/friction_joint.dart';
part 'src/dynamics/joints/friction_joint_def.dart';
part 'src/dynamics/joints/gear_joint_def.dart';
part 'src/dynamics/joints/gear_joint.dart';
part 'src/dynamics/joints/jacobian.dart';
part 'src/dynamics/joints/joint.dart';
part 'src/dynamics/joints/joint_def.dart';
part 'src/dynamics/joints/joint_edge.dart';
part 'src/dynamics/joints/joint_type.dart';
part 'src/dynamics/joints/limit_state.dart';
part 'src/dynamics/joints/motor_joint.dart';
part 'src/dynamics/joints/motor_joint_def.dart';
part 'src/dynamics/joints/mouse_joint.dart';
part 'src/dynamics/joints/mouse_joint_def.dart';
part 'src/dynamics/joints/prismatic_joint.dart';
part 'src/dynamics/joints/prismatic_joint_def.dart';
part 'src/dynamics/joints/pulley_joint.dart';
part 'src/dynamics/joints/pulley_joint_def.dart';
part 'src/dynamics/joints/revolute_joint.dart';
part 'src/dynamics/joints/revolute_joint_def.dart';
part 'src/dynamics/joints/rope_joint.dart';
part 'src/dynamics/joints/rope_joint_def.dart';
part 'src/dynamics/joints/weld_joint.dart';
part 'src/dynamics/joints/weld_joint_def.dart';
part 'src/dynamics/joints/wheel_joint.dart';
part 'src/dynamics/joints/wheel_joint_def.dart';

part 'src/particle/particle_body_contact.dart';
part 'src/particle/particle_color.dart';
part 'src/particle/particle_contact.dart';
part 'src/particle/particle_def.dart';
part 'src/particle/particle_group.dart';
part 'src/particle/particle_group_def.dart';
part 'src/particle/particle_group_type.dart';
part 'src/particle/particle_system.dart';
part 'src/particle/particle_type.dart';
part 'src/particle/stack_queue.dart';
part 'src/particle/voronoi_diagram.dart';

part 'src/pooling/idynamic_stack.dart';
part 'src/pooling/iordered_stack.dart';
part 'src/pooling/iworld_pool.dart';

part 'src/pooling/arrays/float_array.dart';
part 'src/pooling/arrays/generator_array.dart';
part 'src/pooling/arrays/int_array.dart';
part 'src/pooling/arrays/vec2_array.dart';

part 'src/pooling/normal/circle_stack.dart';
part 'src/pooling/normal/default_world_pool.dart';
part 'src/pooling/normal/mutable_stack.dart';
part 'src/pooling/normal/ordered_stack.dart';

part 'src/pooling/stacks/dynamic_int_stack.dart';
