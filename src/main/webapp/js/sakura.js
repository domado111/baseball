onload = function(){
    initSakura();
};

/* canvas object */
function initSakura(){
    window.SakuraCanvas = new CanvasController('sakura');
    window.fallenSakura = 0;
    addSpotLight(SakuraCanvas.width/1);
    var time = setInterval(anim, 30);
}
function anim(){
    if(Math.random()>0.25 && SakuraCanvas.children.length < 200)addSakura(1, 1, 1, SakuraCanvas.width, 1);
    if(fallenSakura > 50){
	var l = SakuraCanvas.children.length;
	for(var i = 0 ; i < l ; i++){
	    var child = SakuraCanvas.children[i];
	    if(child.floatSakura) child.floatSakura();
	}
        fallenSakura = 0;
    }
    SakuraCanvas.rendering();
}
function CanvasController(id) {
    var canvas = document.getElementById(id);
    canvas.width  = window.innerWidth;
    canvas.height = window.innerHeight;

    this.canvas = canvas;
    this.canvasCtx = canvas.getContext('2d');
    this.width = canvas.width;
    this.height = canvas.height;
    this.children = new Array();
    
    this.rendering = function(){
	this.clear();

	var limit = this.children.length;
	for(var i = limit-1 ; i >= 0 ; i--){
            this.canvasCtx.save();
	    var child = this.children[i];
	    if(child.draw(this.canvasCtx)){
		child.callback();
		this.removeChild(i);
	    }
	    this.canvasCtx.restore();
	}
    };
    this.clear = function(){
	this.canvasCtx.clearRect(0,0,this.width,this.height);
    };
    this.addChild = function(child){
	this.children.push(child);
    };
    this.removeChild = function(num){
	this.children.splice(num, 1);
    };
}
function random(n) {
    return Math.floor(Math.random()*n)+1;
}
/* sakura object */
function addSakura(num,x1,y1,x2,y2) {
    for(var i = 0 ; i < num ; i++){
	var x_pos = Math.floor(Math.random()*(x2-x1)) + x1;
	var y_pos = Math.floor(Math.random()*(y2-y1)) + y1;
	SakuraCanvas.addChild(new Sakura(
	    x_pos,
	    y_pos,
	    Math.random()+0.5,
	    {x:random(360), y:random(360), z:random(360)},
	    {x:random(10), y:random(10), z:random(10)},
	    random(5)
	));
    }
}
function Sakura(x, y, scale, direction, rotate, wind) {
    this.x_pos     = x;
    this.y_pos     = y;
    this.scale     = scale;
    this.direction = direction;
    this.rotate    = rotate;
    this.wind      = wind;
    this.gr        = 6;
    this.length    = 10;
    this.phase     = 0;

    this.draw = function(ctx) {
        ctx.beginPath();
        ctx.translate(this.x_pos, this.y_pos);

	ctx.rotate(this.direction.y / 180 * Math.PI);
	ctx.scale(this.scale, this.scale);

	var grad = ctx.createRadialGradient(0, 0, 0, 0, 0, this.length);
        grad.addColorStop(0, 'rgba(255,250,250,1)');
        grad.addColorStop(0.6, 'rgba(255,230,230,1)');
        grad.addColorStop(1, 'rgba(255,150,150,0.4)');
	ctx.fillStyle = grad;
	ctx.shadowColor = ('rgb(255,255,255)');
	ctx.shadowBlur = 15;

        // サクラの描画
	var x_rad = Math.cos(this.direction.x*Math.PI/180);
	var z_rad = Math.cos(this.direction.z*Math.PI/180);
	ctx.moveTo(-6*z_rad,-10*x_rad);
	ctx.bezierCurveTo( -10*z_rad,    0*x_rad,  -5*z_rad,   10*x_rad,   0*z_rad,   10*x_rad );
	ctx.bezierCurveTo(   5*z_rad,   10*x_rad,  10*z_rad,    0*x_rad,   6*z_rad,  -10*x_rad );
	ctx.bezierCurveTo(   0*z_rad,  -10*x_rad,   0*z_rad,   -7*x_rad,   0*z_rad,   -5*x_rad );
	ctx.bezierCurveTo(   0*z_rad,   -7*x_rad,   0*z_rad,  -10*x_rad,  -6*z_rad,  -10*x_rad );
	ctx.fill();

	return this.moveSakura();
    };
    this.moveSakura = function() {
	var move_y;
	if(this.phase === 0){
	    var ground = 0.8 + (this.scale/10);
	    if(this.y_pos > SakuraCanvas.height * ground){
	        this.gr = 0;
	        this.wind = 0;
	        this.rotate.x = 0;
	        this.rotate.y = 0;
	        this.rotate.z = 0;
		this.phase = 1;
		fallenSakura++;
            }
        }
	else if(this.phase === 2){
	    if(this.gr > -3 ) this.gr += this.gr/10;
	    move_y = (this.gr*this.scale);
	}

        this.y_pos = this.y_pos + (this.gr*this.scale);
        this.x_pos = this.x_pos + this.wind;
        this.direction.x += this.rotate.x;
        this.direction.y += this.rotate.y;
        this.direction.z += this.rotate.z;

	if(this.x_pos > SakuraCanvas.width) return true;
	return this.y_pos > SakuraCanvas.height ? true : false;
    };
    this.floatSakura = function() {
	if(this.phase === 1){
            this.gr = - Math.random();
            this.wind = random(15)+5;
            this.rotate.x = random(10)+15;
            this.rotate.y = random(10)+15;
            this.rotate.z = random(10)+15;
            this.phase = 2;
	}
    };
    this.callback = function() {
    };
}
function addSpotLight(radius) {
    var num = Math.floor(SakuraCanvas.width / (radius*2));
    for(var i = 0 ; i < num ; i++){
        SakuraCanvas.addChild(new SpotLight(
            ((SakuraCanvas.width/num)*Math.random())+((SakuraCanvas.width/num)*i),
            SakuraCanvas.height * (0.85 + Math.random()/10),
            radius
        ));
    }
}
function SpotLight(x, y, radius) {
    this.x_pos  = x;
    this.y_pos  = y;
    this.radius = radius;
    
    this.draw = function(ctx) {
        ctx.beginPath();

        ctx.translate(this.x_pos, this.y_pos);
	ctx.scale(1, 0.15);
	var grad = ctx.createRadialGradient(0, 0, 0, 0, 0, this.radius);
        grad.addColorStop(0, 'rgba(255,220,220,0.3)');
        grad.addColorStop(1, 'rgba(255,220,220,0)');
	ctx.fillStyle = grad;
	ctx.arc(0, 0, this.radius, 0, Math.PI*2, false);
	ctx.fill();
    };
    this.callback = function() {
    };
}