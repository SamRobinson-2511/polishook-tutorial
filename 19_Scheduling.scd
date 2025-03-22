//Routines

r = Routine.({ "hello world".yield.postln});
r.next;
r.next;

r.next;
r.reset;
r.next;

(
r = Routine({
	"hello, world".yield;
	"what a world".yield;
	"i am a world".yield;
})
)
r.next;
r.next;
r.next;
r.next;

r.reset;

r.next;
r.next;
r.next;
r.next;

(
r = Routine({
	var array;
	array = ["hello world", "what a world", "i am a world"];
	3.do({array.choose.yield});
});
)

4.do({r.next.postln});











)