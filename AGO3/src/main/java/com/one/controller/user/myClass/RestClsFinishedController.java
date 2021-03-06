package com.one.controller.user.myClass;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.one.utils.MakeFileName;


@RestController
@RequestMapping("/user/myClass/clsFinished")
public class RestClsFinishedController {

	@Resource(name = "extReportStamp")
	private String picturePath;

	@RequestMapping(value = "/picture", method = RequestMethod.POST, produces = "test/plain;charset=utf-8")
	public ResponseEntity<String> picture(@RequestParam("pictureFile") MultipartFile multi, String oldPicture)
			throws IOException {
		ResponseEntity<String> entity = null;

		String result = savePicture(oldPicture, multi);

		entity = new ResponseEntity<String>(result, HttpStatus.OK);

		return entity;

	}

	@RequestMapping(value = "/getPicture.do", produces = "text/plain;charset=utf-8")
	public ResponseEntity<byte[]> getPicture(String picture) throws IOException {
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		String imgPath = this.picturePath;
		try {

			in = new FileInputStream(new File(imgPath, picture));
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), HttpStatus.CREATED);
		} finally {
			in.close();
		}

		return entity;
	}

	private String savePicture(String oldPicture, MultipartFile multi) throws IOException {

		String fileName = null;

		// 파일 유무 확인
		if (!(multi == null || multi.isEmpty() || multi.getSize() > 1024 * 1024 * 5)) {

			// 파일 저장 폴더 설정
			String uploadPath = picturePath;
			fileName = MakeFileName.toUUIDFileName(multi.getOriginalFilename(), "$$");
			File storeFile = new File(uploadPath, fileName);

			storeFile.mkdirs();

			// local HDD에 저장
			multi.transferTo(storeFile);

			if (oldPicture != null && !oldPicture.isEmpty()) {
				File oldFile = new File(uploadPath, oldPicture);
				if (oldFile.exists()) {
					oldFile.delete();
				}
			}
		}

		return fileName;
	}
}
