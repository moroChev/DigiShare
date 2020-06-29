const fs   = require('fs');

exports.removePostImage = (imageUrl)=>{
if(imageUrl!=null){
    const fileName =  imageUrl.split('/postsImages/')[1];
    fs.unlink(`images/postsImages/${fileName}`,(err)=>{console.log('error in deleting the image'+err);});
}
}


exports.publicationObjectFromRequest = (req)=>{
    let pub = req.file ?  {
        imageUrl: `${req.protocol}://${req.get('host')}/api/publications/postsImages/${req.file.filename}`,
        ...req.body
    }
:
    {
        ...req.body
    };
   return pub
}