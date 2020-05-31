const multer = require('multer');

const MIME_TYPES = {
  'image/jpg': 'jpg',
  'image/jpeg': 'jpg',
  'image/png': 'png'
};

const storage = multer.diskStorage({
  destination: (req, file, callback) => {
    callback(null, './images');
  },
  filename: (req, file, callback) => {
    const name = file.originalname.split(' ').join('_');
    const extension = MIME_TYPES[file.mimetype];
    const fullName = name + Date.now() + '.' + extension;
    callback(null, fullName);
  }
});

const fileFilter = (req,file,callback) => {
  // in this method we want to filter the storage to store only the images files
  if( MIME_TYPES.hasOwnProperty(file.mimetype) )
  {
    callback(null, true);
  }else{
    callback(new Error({message: "this file format isn't accepted"}), false);
  }
}

module.exports = multer({ storage: storage, fileFilter: fileFilter}).single('imageUrl');