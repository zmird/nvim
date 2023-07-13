local icons = {
  abc                 = "",
  array               = "",
  arrowFile           = "",
  arrowLeftCircle     = "",
  arrowRight          = "",
  arrowRight2         = "➜",
  arrowRightCircle    = "",
  arrowReturn         = "",
  bomb                = "",
  box                 = "",
  boxOpen             = "",
  boxInBraces         = "",
  braces              = "",
  buffer              = "﬘",
  calculator          = "",
  calendar            = "",
  check               = "",
  checkSmall          = "✔",
  checkSquare         = "",
  checkCircle         = "﫠",
  circle              = "◌",
  classes             = "",
  cog                 = "",
  constant            = "",
  cubeOutline         = "",
  container           = "",
  cross               = "",
  crossBold           = "✖",
  cubeTree            = "",
  curlies             = "",
  database            = "﬘",
  dot                 = "",
  dotBig              = "●",
  dotOutline          = "○",
  emptyBox            = "",
  error               = "",
  errorOutline        = "",
  errorSlash          = "ﰸ",
  f                   = "",
  f2                  = "",
  fileBg              = "",
  fileCopy            = "",
  fileCutCorner       = "",
  fileNoBg            = "",
  fileNoLines         = "",
  fileNoLinesBg       = "",
  fileImport          = "",
  fileTree            = "פּ",
  folder              = "",
  folderNoBg          = "",
  folderOpen          = "",
  folderOpen2         = "ﱮ",
  folderOpenNoBg      = "",
  gears               = "",
  git                 = "",
  gitAdd              = "",
  gitChange           = "柳",
  gitRemove           = "",
  happyFace           = "ﲃ",
  hash                = "",
  hexCutOut           = "",
  ignored             = "",
  info                = "",
  infoOutline         = "",
  interface           = "",
  key                 = "",
  key2                = "",
  keys                = "",
  keyword             = "",
  lightbulb           = "",
  lightbulbOutline    = "",
  lightning           = "",
  lightningOutline    = "",
  m                   = "m",
  merge               = "",
  minus               = "",
  minusSmall          = "‒",
  null                = "ﳠ",
  numbers             = "",
  operators           = "",
  operators2          = "",
  paint               = "",
  paint2              = "",
  paragraph           = "",
  pencil              = "",
  pie                 = "",
  play                = "",
  plus                = "✚",
  questionMark        = "",
  quit                = "",
  rectangleIntersect  = "練",
  reference           = "",
  reload              = "",
  ribbon              = "",
  ribbonNoBg          = "",
  ruler               = "塞",
  ruler2              = "",
  scissors            = "",
  scope               = "",
  search              = "",
  settings            = "",
  sleep               = "鈴",
  sort                = "",
  spell               = "暈",
  snippet             = "",
  snippet2            = "",
  snippet3            = "",
  square              = "",
  star                = "★",
  structure           = "",
  t                   = "",
  t2                  = "𝙏",
  type                = "",
  terminal            = "",
  text                = "",
  textFile            = "󰈚",
  textFileNoBg        = "",
  threeCircles        = "",
  threeDots           = "",
  threeDotsBoxed      = "",
  timer               = "",
  toggleBig           = "",
  toggleBigSelected   = "",
  toggleSelected      = "蘒",
  tree                = "",
  treeDiagram         = "",
  treeStructure       = "",
  values              = "",
  vim                 = "",
  warningCircle       = "",
  warningTriangle     = "",
  warningTriangleNoBg = "",
  wrench              = "",
}

icons.symbols = {
  error         = icons.error,
  warning       = icons.warningTriangle,
  hint          = icons.lightbulb,
  info          = icons.info,
  check         = icons.checkCircle,
}

icons.code = {
  array         = icons.array,
  boolean       = icons.toggleSelected,
  class         = icons.classes,
  color         = icons.paint2,
  component     = icons.cubeTree,
  constant      = icons.constant,
  constructor   = icons.cubeOutline,
  enum          = icons.values,
  enumMember    = icons.values,
  event         = icons.lightning,
  field         = icons.container,
  file          = icons.fileBg,
  folder        = icons.folder,
  fragment      = icons.fileTree,
  func          = icons.cubeOutline,
  interface     = icons.interface, -- treeStructure
  key           = icons.key,
  keyword       = icons.keyword,
  method        = icons.cubeOutline,
  module        = icons.braces,
  namespace     = icons.braces,
  null          = icons.null,
  number        = icons.hash,
  object        = icons.hexCutOut,
  operator      = icons.operators2,
  package       = icons.braces,
  property      = icons.wrench,
  reference     = icons.reference,
  snippet       = icons.scissors,
  string        = icons.abc,
  struct        = icons.structure, -- cubeTree
  text          = icons.textFile,
  typeParameter = icons.type,
  unit          = icons.ruler2,
  value         = icons.values,
  variable      = icons.container,
}

return icons
