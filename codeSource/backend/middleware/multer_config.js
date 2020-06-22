const multer   = require('multer'),
      util     = require('util');

const MIME_TYPES = {
  'image/jpg': 'jpg',
  'image/jpeg': 'jpg',
  'image/png': 'png'
};

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