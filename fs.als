one sig FileSystem{
	children: some File
}

sig File{
	name: one FileName,
	tags: some Tag,
	metaData: some Meta
}

sig Tag{}{
	this in File.tags
}

sig Meta{}{
	this in File.metaData
}

sig FileName{}{
	this in File.name
}

fact FileAlwaysConntectedToFileSystem{
	all f:File, fs:FileSystem | f in (fs.children)
}

fact fileNameCantBeShared{
	all disj f1,f2 : File | f1.name not in f2.name
}

fact metaCantBeShared{
	all disj f1,f2 : File |
		all f1meta: f1.metaData, f2meta: f2.metaData | f1meta not in f2meta
}

run {} for 3 but 5 Tag, 3 File
