import sys
import os

SKOOLDAZE_HOME = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SD_SKOOL = '{}/sources/sd.skool'.format(SKOOLDAZE_HOME)

SKOOLKIT_HOME = os.environ.get('SKOOLKIT_HOME')
if SKOOLKIT_HOME:
    if not os.path.isdir(SKOOLKIT_HOME):
        sys.stderr.write('SKOOLKIT_HOME={}: directory not found\n'.format(SKOOLKIT_HOME))
        sys.exit(1)
    sys.path.insert(0, SKOOLKIT_HOME)
    from skoolkit import skool2asm, skool2html
else:
    try:
        from skoolkit import skool2asm, skool2html
    except ImportError:
        sys.stderr.write('Error: SKOOLKIT_HOME is not set, and SkoolKit is not installed\n')
        sys.exit(1)

sys.stderr.write("Found SkoolKit in {}\n".format(skool2html.PACKAGE_DIR))

def run_skool2asm():
    skool2asm.main(sys.argv[1:] + [SD_SKOOL])

def run_skool2html():
    options = '-d {}/build/html'.format(SKOOLDAZE_HOME)
    skool2html.main(options.split() + sys.argv[1:] + [SD_SKOOL])
