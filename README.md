# czi-to-ome-xslt

[![Build Status](https://github.com/AllenCellModeling/czi-to-ome-xslt/workflows/Test%20Transform/badge.svg)](https://github.com/AllenCellModeling/czi-to-ome-xslt/actions)

This repo contains our XSLT sheets to go from CZI to OME metadata.
The intent is to enable use of this as a git submodule and then apply the XSL transforms
within their project using their language of choice. We also hope that users will
extend and improve the XSL transforms with their own contributions.

---

# CZI to OME-TIFF Metadata Mapping

Using [XSLT](https://en.wikipedia.org/wiki/XSLT) to map CZI metadata schemas to
OME-TIFF metadata specifications.

The resulting OME metadata conforms to the OME extension laid out by the
[4D Nucleome Initiative](https://github.com/WU-BIMAC/MicroscopyMetadata4DNGuidelines).

## Basics
In short: XSLT is used to transform XML to other formats, primarily, other XML formats
or HTML.

* [Simple XSLT Tutorial](https://www.youtube.com/watch?v=BujLy71JY1k)
_an eight minute video detailing how to convert xml to html_
* [XSLT Reference](https://developer.mozilla.org/en-US/docs/Web/XSLT)
_mozilla reference for all possible templating elements_
* [XSLT Deep Reference](https://developer.mozilla.org/en-US/docs/Web/XSLT/Transforming_XML_with_XSLT)
_mozilla reference for all possible attributes, elements, and functions_
* [A Bit More In Depth XSLT Tutorial](https://www.youtube.com/watch?v=Rn1bvTYYsCY)
_a thirty minute video with more details on nested for-each, etc_

## Testing
To test template changes run:

```bash
pip install lxml ome-types
python transform.py
```

---

## Development
See [CONTRIBUTING.md](CONTRIBUTING.md) for information related to developing the code.


***Free software: BSD license***
