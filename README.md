# Arch Linux PKGBUILD builder action

## Inputs

### `target`

**Required** Validation target. Can be one of: `pkgbuild`, `srcinfo`.

### `pkgname`

**Required** The `pkgname` of the package to be validated.

## Example usage

### pkguild

Verifies and builds the package.

```yml
uses: Azd325/arch-pkgbuild-builder@master
with:
  target: 'pkgbuild'
  builddir: 'gitkraken-aur'
  pkgname: 'gitkraken'
```

### srcinfo

Verifies if the `.SRCINFO` is up to date with the `PKGBUILD`.

```yml
uses: Azd325/arch-pkgbuild-builder@master
with:
  target: 'srcinfo'
  builddir: 'gitkraken-aur'
  pkgname: 'gitkraken'
```

## Used by

So far this action is used by the following packages:

* [gitkraken](https://github.com/Azd325/gitkraken)
* [ucm-bin](https://github.com/2m/ucm-bin-pkgbuild)
