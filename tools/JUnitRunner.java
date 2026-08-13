import org.junit.platform.engine.discovery.DiscoverySelectors;
import org.junit.platform.launcher.Launcher;
import org.junit.platform.launcher.LauncherDiscoveryRequest;
import org.junit.platform.launcher.core.LauncherDiscoveryRequestBuilder;
import org.junit.platform.launcher.core.LauncherFactory;
import org.junit.platform.launcher.listeners.SummaryGeneratingListener;
import org.junit.platform.launcher.listeners.TestExecutionSummary;

import java.io.PrintWriter;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Set;

import static org.junit.platform.engine.discovery.ClassNameFilter.includeClassNamePatterns;

/**
 * Minimal JUnit Platform launcher for the CS 61B library set.
 *
 * library-sp26 ships junit-platform-launcher but not junit-platform-console-standalone,
 * so there is no ready-made CLI entry point. This supplies one. Both the Jupiter
 * and Vintage engines are on the classpath, so JUnit 5 and JUnit 4 style tests
 * (hw06, hw08, proj0 still use org.junit.Test) both run.
 *
 * Args: <classes-dir> [class-name-regex]
 */
public class JUnitRunner {

    public static void main(String[] args) {
        if (args.length < 1) {
            System.err.println("usage: JUnitRunner <classes-dir> [class-name-regex]");
            System.exit(2);
        }

        Path classesDir = Paths.get(args[0]).toAbsolutePath();
        String pattern = args.length > 1 ? args[1] : ".*";

        LauncherDiscoveryRequest request = LauncherDiscoveryRequestBuilder.request()
                .selectors(DiscoverySelectors.selectClasspathRoots(Set.of(classesDir)))
                .filters(includeClassNamePatterns(pattern))
                .build();

        Launcher launcher = LauncherFactory.create();
        SummaryGeneratingListener listener = new SummaryGeneratingListener();
        launcher.execute(request, listener);

        PrintWriter out = new PrintWriter(System.out);
        TestExecutionSummary summary = listener.getSummary();
        summary.printFailuresTo(out, 8);

        long found = summary.getTestsFoundCount();
        long passed = summary.getTestsSucceededCount();
        long failed = summary.getTestsFailedCount();
        long skipped = summary.getTestsSkippedCount();

        out.printf("%n%d tests: %d passed, %d failed, %d skipped (%d ms)%n",
                found, passed, failed, skipped,
                summary.getTimeFinished() - summary.getTimeStarted());
        out.flush();

        if (found == 0) {
            System.err.println("No tests matched " + pattern + " under " + classesDir);
            System.exit(3);
        }
        System.exit(failed > 0 ? 1 : 0);
    }
}
