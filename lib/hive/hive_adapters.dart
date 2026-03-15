import 'dart:io';

import 'package:hive_ce/hive_ce.dart';
import '../models/reference_image.dart';

@GenerateAdapters([AdapterSpec<ReferenceImage>(), AdapterSpec<Directory>()])
part 'hive_adapters.g.dart';