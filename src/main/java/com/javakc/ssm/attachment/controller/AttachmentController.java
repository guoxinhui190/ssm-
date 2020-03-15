package com.javakc.ssm.attachment.controller;

import com.javakc.ssm.attachment.entity.Attachment;
import com.javakc.ssm.attachment.service.AttachmentService;
import com.javakc.ssm.component.Page;
import com.javakc.ssm.user.entity.User;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * @ClassName AttachmentController
 * @Description TODO
 * @Author Administrator
 * @Date 2020/1/14 16:57
 * @Version 1.0
 **/
@Controller
@RequestMapping("attachment")
public class AttachmentController {

    @Value("#{configProperties.path}")
    private String path;

   @Autowired
    private AttachmentService attachmentService;


   @RequestMapping(value = "query/{nickname}")
   public String query( Attachment entity,@PathVariable String nickname,Page<Attachment> page,ModelMap model)
   {
       User user = new User();
       if(!"null".equals(nickname)){
           user.setNickname(nickname);
       }
       entity.setUser(user);
       page.setList(attachmentService.queryByPage(entity,page.getStart(),page.getSize()));
       page.setCount(attachmentService.queryByCount(entity));
       page.setRealnamed2(entity.getRealnamed().substring(0,entity.getRealnamed().length() - 1));
       SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
       page.setSdate((entity.getSdate() == null ? "":simpleDateFormat.format(entity.getSdate())));
       page.setLdate((entity.getLdate() == null ? "":simpleDateFormat.format(entity.getLdate())));
       model.put("page",page);
       return "attachment/list";
   }
   /**
    * 文件上传
    * @Date 10:23 2020/1/15
    * @Param [loadFile]
    * @return java.lang.String
    **/
   @RequestMapping(value = "insert/{rolepath}",method = RequestMethod.POST)
   public String insert(@PathVariable String rolepath ,@RequestParam CommonsMultipartFile loadFile)
   {
       try {
           //把文件写入到服务器中
           String name = UUID.randomUUID().toString();
           String path = getcurrentPath() + File.separator + name;
           loadFile.transferTo(new File(path));
           //准备写入数据到数据库
           String realname = loadFile.getOriginalFilename();

           Attachment attachment = new Attachment();
           attachment.setName(name);
           attachment.setRealname(realname);
           attachment.setPath(path);
           attachment.setFilesize(loadFile.getSize());
           attachment.setSuffix(realname.substring(realname.lastIndexOf(".") + 1));
//           attachment.setUser(user);

           attachmentService.insert(attachment);
       } catch (IOException e) {
           e.printStackTrace();
       }
       String insertpath = "redirect:/attachment/query/"+ rolepath +".do";
       return insertpath;
   }
   public String getcurrentPath(){
       //获取当前日期目录
       Date date = new Date();
       SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
       String datepath = format.format(date);
//         E:\\upload\\2020\\01\\15
       //验证当前路径是否存在
       String path = this.path + File.separator + datepath;
       File file = new File(path);
       if (!file.exists()){
         file.mkdirs();
       }
       return path;
   }
   @RequestMapping("delete/{id}/{rolepath}")
   public String delete(@PathVariable int id,@PathVariable  String rolepath){
       attachmentService.delete(id);
       String delepath = "redirect:/attachment/query/"+ rolepath + ".do";
       return delepath;
   }
   @RequestMapping("update")
   @ResponseBody
   public Map<String, Object> update(Attachment attachment){
       Map<String,Object> data = new HashMap<>();
       data.put("success",attachmentService.update(attachment) == 1 ? true : false);
       return data;
   }
   @RequestMapping(value = "download/{id}")
   public void download(@PathVariable int id, HttpServletResponse response) throws IOException
   {
       //1.根据主键ID查询下载的文件详情 服务存储路径，用户上传真实名称
       Attachment attachment = attachmentService.queryById(id);
       String path = attachment.getPath();
       String realname = attachment.getRealname();
       //2.根据获取到的服务器路径，准备输出流
       OutputStream outputStream = null;
       response.reset();
       response.setContentType("application/octet-stream; charset=utf-8");
       response.setHeader("Content-Disposition","attachment; filename=" + new String(realname.getBytes("UTF-8"),"ISO8859-1"));
       outputStream = response.getOutputStream();
       outputStream.write(FileUtils.readFileToByteArray(new File(path)));
       outputStream.flush();
       outputStream.close();
      //3.更新该文件的下载次数
       attachmentService.updateDown(id);
//       return "redirect:/attachment/query.do";
   }
   @RequestMapping(value = "batch/{ides}/{rolepath}")
   public String batch(@PathVariable String ides,@PathVariable String rolepath){
       String[] arr =  ides.split(",");
       int[] ints = new int[ides.length()];
       for (int i = 0;i < arr.length;i ++){
           ints[i] = Integer.parseInt(arr[i]);
       }
       System.out.println(ides);
       attachmentService.batch(ints);
//       return "attachment/query/null.do";
       String bathpath = "redirect:/attachment/query/" + rolepath + ".do";
       return bathpath;
   }

}
