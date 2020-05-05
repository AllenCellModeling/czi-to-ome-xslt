# aicsxslt

[![Build Status](https://github.com/AllenCellModeling/czi-to-ome-xslt/workflows/Test%20and%20Lint/badge.svg)](https://github.com/AllenCellModeling/czi-to-ome-xslt/actions)

This repo contains our XSLT transform sheets to go from CZI to OME metadata.
The intent is to enable use of this as a git submodule and then apply the XSL transforms
within their project using their language of choice. We also hope that users will extend and
improve the XSL transforms with their own contributions.

---

# CZI to OME-TIFF Metadata Mapping

Using [XSLT](https://en.wikipedia.org/wiki/XSLT) to map CZI metadata schemas to OME-TIFF metadata specifications.

### Index
1. [Basics of XSLT](#basics)
2. [General Notes](#notes)
3. [Open Questions](#questions)

## Basics
In short: XSLT is used to transform XML to other formats, primarily, other XML formats or HTML.

_I would recommend watching the videos on 1.5x speed._

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
pip install lxml
cd czi-to-ome-tiff
python transform.py
```

## Questions
* How will we handle schema version to schema version? CZI metadata schemas change over time and so does OME. On first
thought we could have templates for the most common CZI versions to the most recent OME. But, there also exist's `if`,
`choose`, `when`, and `otherwise` template tags in the `xslt` reference so we could just keep everything in one big
template file? Not my favourite option though.


---

## Features
* Store values and retain the prior value in memory
* ... some other functionality

## Quick Start
```python
python transform.py
```

## Installation
**Stable Release:** `git clone https://github.com/AllenCellModeling/czi-to-ome-xslt.git`<br>


## Development
See [CONTRIBUTING.md](CONTRIBUTING.md) for information related to developing the code.


#### Suggested Git Branch Strategy
1. `master` is for the most up-to-date development, very rarely should you directly commit to this branch. GitHub
Actions will run on every push and on a CRON to this branch but still recommended to commit to your development
branches and make pull requests to master.
2. `stable` is for releases only. When you want to release your project on PyPI, simply make a PR from `master` to
`stable`, this template will handle the rest as long as you have added your PyPI information described in the above
**Optional Steps** section.
3. Your day-to-day work should exist on branches separate from `master`. Even if it is just yourself working on the
repository, make a PR from your working branch to `master` so that you can ensure your commits don't break the
development head. GitHub Actions will run on every push to any branch or any pull request from any branch to any other
branch.
4. It is recommended to use "Squash and Merge" commits when committing PR's. It makes each set of changes to `master`
atomic and as a side effect naturally encourages small well defined PR's.
5. GitHub's UI is bad for rebasing `master` onto `stable`, as it simply adds the commits to the other branch instead of
properly rebasing from what I can tell. You should always rebase locally on the CLI until they fix it.


***Free software: BSD license***

