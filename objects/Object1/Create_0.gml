// parse Catspeak code
var _t = get_timer();
catspeak = new CatspeakEnvironment();
show_debug_message((get_timer() - _t) / 1000);

var _t = get_timer();
gmlspeak = new GMLspeakEnvironment();
show_debug_message((get_timer() - _t) / 1000);

gmlspeak.interface.exposeFunction("string", string);
gmlspeak.interface.exposeFunction("real", real);
gmlspeak.interface.exposeFunction("get_timer", get_timer);
gmlspeak.interface.exposeFunction("show_debug_message", show_debug_message);
catspeak.interface.exposeFunction("string", string);
catspeak.interface.exposeFunction("show_debug_message", show_debug_message);
gmlspeak.interface.exposeFunction(
	"variable_struct_get_names", 
	variable_struct_get_names, 
	"struct_get_names", 
	variable_struct_get_names,
	"variable_struct_names_count",
	variable_struct_names_count,
	"struct_names_count"
	,variable_struct_names_count,
	"variable_struct_get", 
	variable_struct_get, 
	"variable_struct_set", 
	variable_struct_set, 
	"struct_get", 
	variable_struct_get, 
	"struct_set", 
	variable_struct_set,
	"variable_struct_exists",
	variable_struct_exists,
	"struct_exists",
	variable_struct_exists,
	"variable_struct_remove",
	variable_struct_remove,
	"struct_remove",
	variable_struct_remove
);

var ir = gmlspeak.parseString(@'
	foo = "bar";
	printMe = function(str) {
		show_debug_message(string(str) + " " + string(foo));
	};
	
	test();
');

var ir2 = catspeak.parseString(@'
	foo = "bar";
	printMe = fun(str) {
		show_debug_message(string(str) + " " + string(foo));
	};
');
var program = gmlspeak.compileGML(ir);

test = function() {
	show_debug_message("AAAAAAAAAAAAA " + string(id));	
}

program(id);

show_debug_message("---------");
var _t = get_timer();

printMe("Hello world from");
show_debug_message((get_timer() - _t) / 1000);

var program2 = catspeak.compileGML(ir2);
var globals = program2.getGlobals();
program2()

var _t = get_timer();
globals.printMe("Hello world from");
show_debug_message((get_timer() - _t) / 1000);

var struct = {toString: function() {
		return variable_struct_get_names(self);
	},
	test: function() {show_debug_message(string(self))}
}

program(struct);
struct.foo = "No way";
struct.printMe("Weee");
//show_debug_message(variable_struct_get_names(struct));

var ir = gmlspeak.parseString(@'
	var struct = {};
	var c = "hmm"
	with(struct) {
		struct2 = {}
		with(struct2) {
			var a = "b";
			other.foo = "rawr";
			show_debug_message(c);
		}
		bar = "huh";
	}
	show_debug_message(a);
	return struct;
');

var program = gmlspeak.compileGML(ir);
var result = program(id);
show_debug_message(string_concat(result.foo, " ", result.bar," ", foo));

var struct = {};
with(struct) {
	struct2 = {};
	with(struct2) {
		other.foo = "rawr";	
	}
	bar = "huh";
}
show_debug_message(string_concat(struct.foo, " ", struct.bar," ", foo));





var ir = gmlspeak.parseString(@'
	var t = get_timer();
	repeat(10000) {
		var foo = 32;
	}
	
	return get_timer()-t;
');

var getMessage = gmlspeak.compileGML(ir);


var ir = gmlspeak.parseString(@'
	var t = get_timer();
	for(var i = 0; i < 10000; i += 1) {
		var foo = 32;
	}
	
	return get_timer()-t;
');

var getMessage2 = gmlspeak.compileGML(ir);
var time = getMessage() / 1000;
var time2 = getMessage2() / 1000;

show_debug_message("Repeat loop: " + string(time) + "ms");
show_debug_message("For loop: " + string(time2) + "ms");