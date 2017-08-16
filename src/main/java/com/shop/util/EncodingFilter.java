package com.shop.util;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2003</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */

import java.io.IOException;  

import javax.servlet.Filter;

import javax.servlet.FilterChain;

import javax.servlet.FilterConfig;

import javax.servlet.ServletException;

import javax.servlet.ServletRequest;

import javax.servlet.ServletResponse;

public class EncodingFilter implements Filter {

  private FilterConfig config;

  private String defalutEncodeing;

  public void init(FilterConfig config) {

    this.config = config;
    defalutEncodeing = "UTF-8";

  }

  public void doFilter(ServletRequest request,ServletResponse response,

                       FilterChain chain) throws IOException,ServletException {

    request.setCharacterEncoding(defalutEncodeing); 
    response.setCharacterEncoding(defalutEncodeing);
    chain.doFilter(request,response);

  }

  public void destroy() {

  }

}
