const util        = require('util'),
      digiUtil    = require('../utility/globalUtil');


class CommentController{
    constructor(commentSrv){
        this.commentSerivce = commentSrv;
    }


     getAllComments = async  (req,res,next)=>{   
        try {
            let comments = await this.commentSerivce.getAllComments(req.params.id);
            res.status(200).json(comments);
        } catch (error) {
            console.log(error);
            res.status(500).json(error);
        }
    }

    addComment = async (req,res,next)=>{
        try {
            let com = {...req.body};
            let postId = req.params.id;
            let comment = await this.commentSerivce.addComment(postId,com);
            res.status(201).json(comment);
        } catch (error) {
            res.status(500).json(error);
        }
    } 

    editComment = async (req,res,next)=>{
        try {
            let com = {...req.body};
            let commentId = req.params.commentId;
            let comment = await this.commentSerivce.editComment(commentId, com);
            res.status(200).json(comment);
        } catch (error) {
            res.status(500).json(error);
        }
    }

    deleteComment = async (req,res,next)=>{
        try {
            let commentId = req.params.commentId;
            let comment = await this.commentSerivce.deleteComment(commentId);
            res.status(200).json(comment);
        } catch (error) {
            res.status(500).json(error);
        }
    }
}

module.exports = CommentController;