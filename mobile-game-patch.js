(() => {
  if (window.__dvmMobilePatchInstalled) return;
  window.__dvmMobilePatchInstalled = true;

  const mobileStyle = document.createElement('style');
  mobileStyle.id = 'dvmMobileGameStyle';
  mobileStyle.textContent = `
    @media (max-width: 1180px) and (pointer: coarse) and (orientation: landscape) {
      body.tutorial-running .bottom-tray:not(.shop-open) #shopDrawer {
        display: none !important;
      }

      .shop-row .card .dragon-img {
        top: 12px !important;
        right: 2px !important;
        bottom: 4px !important;
        left: auto !important;
        width: 60% !important;
        height: auto !important;
        max-width: 78px !important;
        max-height: calc(100% - 16px) !important;
        object-fit: contain !important;
        object-position: center !important;
        transform: scaleX(-1) !important;
      }
    }
  `;
  document.head.appendChild(mobileStyle);

  function isBenchTutorialStep() {
    const overlay = document.getElementById('tutorialOverlay');
    const progress = document.getElementById('tutorialProgress')?.textContent || '';
    return !overlay?.hidden && /^Tutorial 4\s*\//i.test(progress);
  }

  function completeTutorialBenchTap(event) {
    if (!isBenchTutorialStep()) return;

    const target = event.target instanceof Element ? event.target : null;
    const slot = target?.closest('.bench-slot.filled');
    if (!slot) return;

    event.preventDefault();
    event.stopImmediatePropagation();
    requestAnimationFrame(() => {
      if (isBenchTutorialStep()) slot.click();
    });
  }

  // iOS can omit the synthetic click after a touch/pointer sequence on a
  // transformed iframe. Complete the intended Bench tap with one controlled
  // click so Tutorial step 4 cannot become stuck.
  document.addEventListener('pointerup', event => {
    if (event.pointerType === 'mouse') return;
    completeTutorialBenchTap(event);
  }, { capture: true, passive: false });

  document.addEventListener('touchend', event => {
    completeTutorialBenchTap(event);
  }, { capture: true, passive: false });

  const tutorialNext = document.getElementById('tutorialNextBtn');
  const tutorialActionNote = document.getElementById('tutorialActionNote');

  function syncBenchTutorialFallback() {
    if (!tutorialNext) return;
    const isBenchStep = isBenchTutorialStep();
    if (isBenchStep) {
      if (tutorialNext.dataset.mobileBenchFallback !== 'true') tutorialNext.dataset.mobileBenchFallback = 'true';
      if (tutorialNext.hidden) tutorialNext.hidden = false;
      if (tutorialNext.textContent !== 'Select Dragon') tutorialNext.textContent = 'Select Dragon';
      if (tutorialActionNote && tutorialActionNote.textContent !== 'Tap the highlighted dragon or use Select Dragon') {
        tutorialActionNote.textContent = 'Tap the highlighted dragon or use Select Dragon';
      }
    } else if (tutorialNext.dataset.mobileBenchFallback === 'true') {
      delete tutorialNext.dataset.mobileBenchFallback;
      if (tutorialNext.textContent !== 'Continue') tutorialNext.textContent = 'Continue';
    }
  }

  tutorialNext?.addEventListener('click', event => {
    if (!isBenchTutorialStep()) return;
    event.preventDefault();
    event.stopImmediatePropagation();
    const slot = document.querySelector('.bench-slot.filled');
    if (slot) slot.click();
  }, { capture: true });

  const tutorialObserver = new MutationObserver(syncBenchTutorialFallback);
  const tutorialOverlay = document.getElementById('tutorialOverlay');
  if (tutorialOverlay) {
    tutorialObserver.observe(tutorialOverlay, { subtree: true, childList: true, attributes: true });
  }
  syncBenchTutorialFallback();
})();
