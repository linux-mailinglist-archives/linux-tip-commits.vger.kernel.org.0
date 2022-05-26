Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA410534DAB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 May 2022 13:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344164AbiEZLBp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 May 2022 07:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiEZLBp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 May 2022 07:01:45 -0400
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348A11D0F3;
        Thu, 26 May 2022 04:01:44 -0700 (PDT)
Received: by mail-pj1-f65.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so1412609pjf.5;
        Thu, 26 May 2022 04:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pLaR1c4A1+kJhjeDUMdwZ1PPmHOVlp2foYVmGTfi61k=;
        b=k3Q8m/FusXUMFixi3vHlAoMu9+d/DDvw4boo9n5gFLA1eLB6u8ZfKQbZpNb4a92MWl
         i1zhWbo1IewuO7c4TtVejrXYa3XK/Hi3/+aEvhkcUXoHJFro4Ay1Aeo0Nlf9KBBHcbUI
         syUJKaTkxvSACAgiOo93D5K3WpAPRmgGS9G1c/gMi87BxEAWICBgLKouBRUmQloLJpqq
         mKNn+fldo71M1shGmr+Sj71jXRdLRdcgl55zNUu1ihZRJP882CwZrIkCS9gR2tEeucQm
         RLCzWEPyCBxl9MQ15KGfLUl78TtfCi4p6EXiJZkWYKG6nDFNKVqId13ozpAdgp+CXJCL
         xc1g==
X-Gm-Message-State: AOAM531JxEOZw6HzVoq+KXJBySJYFk2G2rHzYbU74grL/5ogo2E/stgv
        1qvwBUJ3OfW9SwqE67D+Ig==
X-Google-Smtp-Source: ABdhPJyMj4AgF4QEIpibY6f3wBBkQDlIr/bkTPnTCGjzBlKV5ATVIMD4VF8evXXgl04FuKOjd3EwFg==
X-Received: by 2002:a17:902:bd93:b0:162:135a:8309 with SMTP id q19-20020a170902bd9300b00162135a8309mr23248475pls.35.1653562903644;
        Thu, 26 May 2022 04:01:43 -0700 (PDT)
Received: from localhost.localdomain (ns1003916.ip-51-81-154.us. [51.81.154.37])
        by smtp.gmail.com with ESMTPSA id z16-20020a17090a015000b001d95c09f877sm1193832pje.35.2022.05.26.04.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:01:43 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     mingo@kernel.org, linux-tip-commits@vger.kernel.org,
        dave.hansen@linux.intel.com, rostedt@goodmis.org
Cc:     x86@kernel.org, inux-kernel@vger.kernel.org, sunliming@kylinos.cn,
        kelulanainsley@gmail.com
Subject: [PATCH V2] x86/idt: traceponit.c: fix comment for irq vector tracepoints
Date:   Thu, 26 May 2022 19:01:17 +0800
Message-Id: <20220526110117.174985-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Commit:

  4b9a8dca0e58 ("x86/idt: Remove the tracing IDT completely")

removed the 'tracing IDT' from arch/x86/kernel/tracepoint.c,
but left related comment. So that the comment become anachronistic.
Just remove the comment.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 arch/x86/kernel/tracepoint.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/tracepoint.c b/arch/x86/kernel/tracepoint.c
index fcfc077afe2d..065191022035 100644
--- a/arch/x86/kernel/tracepoint.c
+++ b/arch/x86/kernel/tracepoint.c
@@ -1,9 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Code for supporting irq vector tracepoints.
- *
  * Copyright (C) 2013 Seiji Aguchi <seiji.aguchi@hds.com>
- *
  */
 #include <linux/jump_label.h>
 #include <linux/atomic.h>
-- 
2.25.1

