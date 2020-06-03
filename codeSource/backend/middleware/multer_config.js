const multer   = require('multer'),
      util     = require('util');

const MIME_TYPES = {
  'image/jpg': 'jpg',
  'image/jpeg': 'jpg',
  'image/png': 'png'
};

const storage = multer.diskStorage({
  destination: (req, file, callback) => {
    console.log("destination /images ok ! and "+req);
    callback(null, './images');
  },
  filename: (req, file, callback) => {
    const name = file.originalname.split(' ').join('_');
    const extension = MIME_TYPES[file.mimetype];
    const fullName = name + Date.now() + '.' + extension;
    console.log(util.inspect(file, false, null));
    console.log("filename that will be sotred is"+fullName+" and the file is file :"+file);
    
    callback(null, fullName);
  }
}
);

/* const fileFilter = (req,file,callback) => {
  // in this method we want to filter the storage to store only the images files
  console.log("file extension is "+file.mime);
  if( MIME_TYPES.hasOwnProperty(file.mimetype) )
  {
    console.log("file extension is supported");
    callback(null, true);
  }else{
    console.log("file extenstion isn't supported ...");
    callback(new Error({message: "this file format isn't accepted"}), false);
  }
} */

module.exports = multer({ storage: storage}).single('imageUrl');