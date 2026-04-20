# ML Pipeline

Placeholder for the Shyama machine learning training pipeline.

## Planned Contents

- Dataset curation and augmentation scripts
- Model training notebooks (PyTorch / TensorFlow)
- Evaluation scripts — including bias audits across Fitzpatrick skin tone scale Types I–VI
- Model export pipeline (Core ML conversion for on-device inference via `coremltools`)
- Model cards documenting training data, known limitations, and per-stratum performance

## Current Status

**Not yet started.** The iOS app uses `MockPredictionService` for all development work.

The ML pipeline will move to a separate repository when training begins. This directory will be updated with a link at that point.

## Skin Tone Representation — Non-Negotiable Requirement

All training datasets and evaluations **must** include balanced representation across Fitzpatrick scale Types I–VI. Any published model card must report per-stratum performance metrics (sensitivity, specificity, positive predictive value) broken out by Fitzpatrick type. Aggregate metrics alone are insufficient and can mask disparities that disproportionately affect the communities Shyama serves.
