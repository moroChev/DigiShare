const multer   = require('multer'),
      util     = require('util');

const MIME_TYPES = {
  'image/jpg': 'jpg',
  'image/jpeg': 'jpg',
  'image/png': 'png'
};

/* const storage = multer.diskStorage({
  destination: (req, file, callback) => {
    console.log("destination /images ok ! and "+req);
    callback(null, './images');
  },
  filename: (req, file, callback) => {
    const name = file.originalname.split(' ').join('_');
    const extension = MIME_TYPES[file.mimetype];
    const fullName = name + Date.now() + '.' + extension;
    console.log(util.inspect(file, false, null));
    callback(null, fullName);
  }
}
); */

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

//module.exports = multer({ storage: storage}).single('imageUrl');


exports.multerPosts = multer(
  {
    storage: multer.diskStorage({
      destination: (req, file, callback) => {
        console.log("destination /images ok ! and "+req);
        callback(null, './images/postsImages');
      },
      filename: (req, file, callback) => {
        const name = file.originalname.split(' ').join('_');
        const extension = MIME_TYPES[file.mimetype];
        const fullName = name + Date.now() + '.' + extension;
        console.log(util.inspect(file, false, null));
        callback(null, fullName);
      }
    }
    )
  }
).single("imageUrl");


exports.multerAgencies = multer(
  {
    storage: multer.diskStorage({
      destination: (req, file, callback) => {
        console.log("destination /images ok ! and "+req);
        callback(null, './images/agenciesLogos');
      },
      filename: (req, file, callback) => {
        const name = file.originalname.split(' ').join('_');
        const extension = MIME_TYPES[file.mimetype];
        const fullName = name + Date.now() + '.' + extension;
        console.log(util.inspect(file, false, null));
        callback(null, fullName);
      }
    }
    )
  }
).single("logo");

exports.multerEmployees = multer(
  {
    storage: multer.diskStorage({
      destination: (req, file, callback) => {
        console.log("destination /images ok ! and "+req);
        callback(null, './images/profilesImages');
      },
      filename: (req, file, callback) => {
        const name = file.originalname.split(' ').join('_');
        const extension = MIME_TYPES[file.mimetype];
        const fullName = name + Date.now() + '.' + extension;
        console.log(util.inspect(file, false, null));
        callback(null, fullName);
      }
    }
    )
  }
).single("imageUrl");