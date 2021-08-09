# czi-to-ome-xslt

[![Build Status](https://github.com/AllenCellModeling/czi-to-ome-xslt/workflows/Test%20Main/badge.svg)](https://github.com/AllenCellModeling/czi-to-ome-xslt/actions/test-main.yml)

XSLT files to convert from CZI (Zeiss) microscopy image metadata
to OME image metadata schema.

---

## Usage

If you want to use this work in a standalone fashion we recommend submoduling
this repository into your own repo:

```bash
git submodule add https://github.com/AllenCellModeling/czi-to-ome-xslt.git
```

You can then run the transformation in any language of your choosing.

### Python

_**Requires `lxml`** (`pip install lxml`)_

```python
import lxml.etree as ET

# Parse template and generate transform function
template = ET.parse("czi-to-ome-xslt/xslt/czi-to-ome.xsl")
transformer = ET.XSLT(template)

# Parse CZI XML
czixml = ET.parse("your-czi-metadata.xml")

# Transform
omexml = transformer(czixml)

# Write to file
with open("your-converted-czi-metadata.ome.xml", "w") as open_f:
    open_f.write(str(omexml))
```

This work has already been incorporated into
[`aicsimageio`](https://github.com/AllenCellModeling/aicsimageio).

```python
from aicsimageio import AICSImage

img = AICSImage("your-file.czi")
img.save("your-converted-file.ome.tiff")
```

## Comparison with Bioformats

For full metadata comparison between XSLT and Bioformats, see
[comparison](./docs/comparison).


## Contributing

Contributions are welcome, and they are greatly appreciated! Every little bit
helps, and credit will always be given.

Please feel free to contribute documentation, new additions to the XSLT itself,
and/or tests!

**We especially encourage contributing examples of using this work in languages other
than Python**.

For instructions on how to contribute new additions to the XSLT and/or tests, see
[CONTRIBUTING](./docs/CONTRIBUTING.md).


---


***Free software: BSD license***
