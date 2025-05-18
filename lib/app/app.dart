library;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_management/firebase/firebase_options_prod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../firebase/firebase_options_stg.dart';

// This file is the entry point for the app layer. It exports all the files in
// the app layer so that they can be imported using a single import statement.
part 'core/enum.dart';
part 'managers/color_manager.dart';
part 'managers/config_manager.dart';
part 'managers/style_manager.dart';
part 'managers/theme_manager.dart';
part 'managers/constant_manager.dart';
