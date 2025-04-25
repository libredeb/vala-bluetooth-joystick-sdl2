using SDL;
// SDL Reference: https://valadoc.org/sdl2/SDL.html

public static int main(string[] args) {

    if (SDL.init(SDL.InitFlag.JOYSTICK) != 0) {
        warning("SDL init Error: %s", SDL.get_error());
        return 1;
    }

    if (SDL.Input.Joystick.count() < 1) {
        warning("No joysticks connected.");
        SDL.quit();
        return 1;
    }

    var joystick = new SDL.Input.Joystick(0); // Index 0
    if (joystick == null) {
        warning("Unable to open joystick: %s", SDL.get_error());
        SDL.quit();
        return 1;
    }

    message("Joystick connected: %s", joystick.get_name());

    SDL.Event event;
    while (true) {
        while (SDL.Event.poll(out event) != 0) {
            if (event.type == SDL.EventType.QUIT) {
                break;
            }

            if (event.type == SDL.EventType.JOYHATMOTION) {
                if (event.jhat.value == SDL.HatValue.CENTERED) {
                    print("D-pad released\n");
                }
                if (event.jhat.value == SDL.HatValue.UP) {
                    print("D-pad UP\n");
                }
                if (event.jhat.value == SDL.HatValue.DOWN) {
                    print("D-pad DOWN\n");
                }
                if (event.jhat.value == SDL.HatValue.LEFT) {
                    print("D-pad LEFT\n");
                }
                if (event.jhat.value == SDL.HatValue.RIGHT) {
                    print("D-pad RIGHT\n");
                }
            }            

            if (event.type == SDL.EventType.JOYBUTTONDOWN) {
                print("Button pressed: %d\n", event.jbutton.button);
            }

            if (event.type == SDL.EventType.JOYBUTTONUP) {
                print("Button released: %d\n", event.jbutton.button);
            }
        }

        SDL.Timer.delay(10); // Avoid 100% CPU usage
    }
}