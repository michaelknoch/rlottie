// Stand-in for the CMake-generated config.h when building via SwiftPM.
// All optional rlottie features OFF:
//   LOTTIE_MODULE -> dynamic image loader plugin (we link stb_image directly)
//   LOTTIE_THREAD -> async render thread (synchronous-only)
//   LOTTIE_CACHE  -> animation parse cache
