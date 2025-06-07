package funkin.objects;

enum NavControls
{
	Horizontal;
	Vertical;
	Both;
	Columns(num:Int);
	Rows(num:Int);
}