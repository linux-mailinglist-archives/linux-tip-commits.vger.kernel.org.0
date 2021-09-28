Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C8641B7C6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 Sep 2021 21:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242023AbhI1TxT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 28 Sep 2021 15:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242120AbhI1TxS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 28 Sep 2021 15:53:18 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22A0C061746
        for <linux-tip-commits@vger.kernel.org>; Tue, 28 Sep 2021 12:51:38 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v18so51858551edc.11
        for <linux-tip-commits@vger.kernel.org>; Tue, 28 Sep 2021 12:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=bIEnocFRtneXYJ0fHHwX1J2ddQaMD/rrUCnpD/BupmA=;
        b=nuE9fNgZ7qFoihKhXYrtr72Y47rfzcsMuyGXk8hzSd8ZN1alhXva9+NFCk7scuX1fQ
         HvhKH6hK9WmyB9bpTTbHAz6M9sD2DEpxYhBTLBnOnw7FN2o0+5kdepde/CxyG43E5zJ/
         2IwBCwPPBPITcNHWNQJjHIFGBGY2FD5VOL7xjzOKJpTkiBOWR1KOVqy0HuLC8jjSI2It
         UExszG+BcUfEAaMaRnZeX2G1ccSHXWLCtZe3aWg+YByezBJEeVvyp1OWqEQcJJN635oH
         q5JtCxYZEoy4egrSxbKiFJ1AtEbU66rN7uujsnCud8rAkrv4WH1beOvGptFLYv/GF+uu
         XnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=bIEnocFRtneXYJ0fHHwX1J2ddQaMD/rrUCnpD/BupmA=;
        b=SNW60B68RDVyr11iXoyansN/f3Vu1oDve/+LKnTLYrv5Di8jqQKj2qLmr2fzwbZWD5
         aW7No+m5sLceimNrqovVVMSCv9+wb3CDRW0/sDJm5KXoK4lYlLdt3yGgZmmW1A4UYGHh
         YfCNkP0VJMCsJOBQwVg8wxKkuKHi+NcAkIidQuPa0TNbsrk8z/Gly0pwypluKNIZ2pW3
         aNDV+zcAoc4M5RoQKLWX4OIdxGtTZhUBEFxvNRkPUD8FWhSLttn8iszTogUSNQO9h2+t
         qkB1gFoRmLlfiei/X6lwxP6TuThWKTpGdsxbWcHBNRNRqe6I+GTkbXQGNC1zYuUpzOMD
         CEhA==
X-Gm-Message-State: AOAM532Bo5C34tJvMj0np/6luxNzDIhjdoPsv9Jl3cnw9FC5Xs1cimlc
        QWyuvtriYxyCFAsWgdt4NQKEku0+y98GdVy9fXw=
X-Google-Smtp-Source: ABdhPJzJCyk6DGHiVw7H19hgduOwAThXvxCVwom6DykPON842GuyHAbw8wnc52Y+DWmBmIveRzUI11xX9MCnzHQAHFk=
X-Received: by 2002:a17:906:38ce:: with SMTP id r14mr8847643ejd.268.1632858697345;
 Tue, 28 Sep 2021 12:51:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:9607:0:0:0:0 with HTTP; Tue, 28 Sep 2021 12:51:36
 -0700 (PDT)
Reply-To: wwwheadofficet@gmail.com
In-Reply-To: <CACRybBZ3ev8a6juUkdUJsXVAepAvbRYrG2FhZVcAuiiLVZsguw@mail.gmail.com>
References: <CACRybBbL7R7Ro83QcWZM6a5K9iA1TFVZep=JU6-M-MBsNhwyKw@mail.gmail.com>
 <CACRybBZ3ev8a6juUkdUJsXVAepAvbRYrG2FhZVcAuiiLVZsguw@mail.gmail.com>
From:   "wwwheadofficet@gmail.com" <infowunion2@gmail.com>
Date:   Tue, 28 Sep 2021 19:51:36 +0000
Message-ID: <CACRybBbDCef4X9G6ay=VNkfLu3hamGaB6XsWafVBWz1+9qL-Pg@mail.gmail.com>
Subject: Bnk
To:     infowunion2@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

 Our office contact, 2554 Road Of Kpalime Face Pharmacy Bet, Lome, Gulf.

This is WU bank director bring notice for you that  International
monetary fund (IMF) who compensation you sum of $850,000.00 because
they found your email address in the list of scam victim . Do you
willing to get this fund or not?

We look forward to hear from you urgently.

Yours faithfully
 Tony  Albert
 BANK DIRECTOR
Whatsapp, +22870077685
