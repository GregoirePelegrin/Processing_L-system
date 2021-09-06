int depth;
float len;
ArrayList<Rule> rules;
String root;
String sentence;

void setup(){
    size(600, 600);
    frameRate(30);

    depth = 0;
    len = 150;
    rules = new ArrayList<Rule>();
    root = "F";
    sentence = root;

    rules.add(new Rule("F", "FF+[+F-F-F]-[-F+F+F]"));
}

void draw(){
    translate(width/2, height);
    display();
}

void display(){
    background(51);
    stroke(255, 50);
    for(int i=0; i<sentence.length(); i++){
        if(str(sentence.charAt(i)).equals("F")){
            line(0, 0, 0, -len);
            translate(0, -len);
        } else if(str(sentence.charAt(i)).equals("+")){
            rotate(radians(25));
        } else if(str(sentence.charAt(i)).equals("-")){
            rotate(-radians(25));
        } else if(str(sentence.charAt(i)).equals("[")){
            pushMatrix();
        } else if(str(sentence.charAt(i)).equals("]")){
            popMatrix();
        }
    }
}

void keyPressed() {
    if(key == '+'){
        depth++;
        len *= 0.5;
    } else if(key == '-'){
        depth--;
        len *= 2;
    }
    sentence = root;
    for(int i=0; i<depth; i++){
        update();
    }
}

void update(){
    String new_sentence = "";
    boolean switched;
    for(int i=0; i<sentence.length(); i++){
        switched = false;
        for(Rule rule : rules){
            if(rule.input.equals(str(sentence.charAt(i)))){
                new_sentence += rule.output;
                switched = true;
                break;
            }
        }
        if(!switched){
            new_sentence += sentence.charAt(i);
        }
    }
    sentence = new_sentence;
}