const nodemailer = require('nodemailer')

const sendMail = ({ subject, text, html }) => {
    var transporter = nodemailer.createTransport({
            service: 'gmail',prot : 587,
            host :'smtp.gmlail.com',
            secure : false,
            requireTLS : true,
            auth: {
                user: 'dkelaboffice@gmail.com',
                pass: 'dkelab@520'
            }
    });
    // 메일 옵션
    var mailOptions = {
            from: 'dkelaboffice@gmail.com',
            to: 'dkelaboffice@gmail.com', // 수신할 이메일
            subject: subject, // 메일 제목
            text: text, // 메일 내용
            html: html,
        };
    // 메일 발송    
    transporter.sendMail(mailOptions, function(error, info){
        if (error) {
            console.log(error);
        } else {
            console.log('Email sent: ' + info.response);
        }
    });
}
// 메일객체 exports
module.exports = sendMail;