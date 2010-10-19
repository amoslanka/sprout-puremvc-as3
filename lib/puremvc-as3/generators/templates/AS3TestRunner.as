package {
    import asunit.core.TextCore;
    import flash.display.MovieClip;

    public class <%= test_runner_name %> extends MovieClip {
        
        private var core:TextCore;

        public function <%= test_runner_name %>() {
            core = new TextCore();
            core.start(AllTests, null, this);
        }
    }
}

