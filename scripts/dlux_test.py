# Basic imports
import jax
from jax import config
config.update("jax_enable_x64", True)

import jax.numpy as np
import jax.random as jr
import jax.scipy as jsp

# Optimisation imports
import zodiax as zdx
import optax

# dLux imports
import dLux as dl
import dLux.utils as dlu

# Visualisation imports
from tqdm.notebook import tqdm
import matplotlib.pyplot as plt

# Extremely minimal profiling
from time import time as clock

plt.rcParams['image.cmap'] = 'inferno'
plt.rcParams["font.family"] = "serif"
plt.rcParams["image.origin"] = 'lower'
plt.rcParams['figure.dpi'] = 72

'''-----------------------------------------------------------
-----------------------------------------------------------'''

# Explore the environment
print('Jax devices:',jax.device_count())


tic = clock()
# Define our wavefront properties
wf_npix = 1024  # Number of pixels in the wavefront
diameter = 1.0  # Diameter of the wavefront, meters

# Construct a simple circular aperture
coords = dlu.pixel_coords(wf_npix, diameter)
aperture = dlu.circle(coords, 0.5 * diameter)

# Define our detector properties
psf_npix = 1024  # Number of pixels in the PSF
psf_pixel_scale = 25e-3  # 50 mili-arcseconds
oversample = 4  # Oversampling factor for the PSF

# Define the optical layers
# Note here we can pass in a tuple of (key, layer) paris to be able to 
# access the layer from the optics object with the key!
layers = [
    (
        "aperture",
        dl.layers.TransmissiveLayer(transmission=aperture, normalise=True),
    )
]

# Construct the optics object
optics = dl.AngularOpticalSystem(
    wf_npix, diameter, layers, psf_npix, psf_pixel_scale, oversample
)

toc = clock()
print('Initialization time: %.3f s' % (toc-tic))


tic = clock()
# Models some wavelengths through the system
wavels = 1e-6 * np.linspace(1, 1.2, 10)
propagate = jax.jit(optics.propagate)
psf = propagate(wavels)
toc = clock()

print('First Propagation time: %.3f s' % (toc-tic))

tic = clock()

ts = []
for j in range(10):
    tic = clock()
    psf = propagate(wavels)
    toc = clock()
    t = toc-tic
    ts.append(t)

ts = np.array(ts)

print(f'Average jitted propagation time: {ts.mean():.2f} +- {ts.std():.2f} s')

# Get out aperture transmission for plotting
# Note we can use the 'aperture' key we supplied in the layers to access 
# that layer directly from the optics object!
transmission = optics.aperture.transmission

# Let examine the optics object! The dLux framework has in-built 
# pretty-printing, so we can just print the object to see what it contains.
print(optics)

# Plot the results
plt.figure(figsize=(10, 4))
plt.suptitle("A Simple Optical System")
plt.subplot(1, 2, 1)
plt.title("Aperture Transmission")
plt.imshow(transmission)
plt.colorbar(label="Transmission")

plt.subplot(1, 2, 2)
plt.title("Sqrt PSF")
plt.imshow(psf**0.5)
plt.colorbar(label="Sqrt Intensity")
plt.tight_layout()

plt.savefig('test_psf.png',bbox_inches='tight')

toc = clock()

print('Plotting time: %.3s' % (toc-tic))