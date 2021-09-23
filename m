Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A76A415B91
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Sep 2021 11:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbhIWJ7T (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 23 Sep 2021 05:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240310AbhIWJ7T (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 23 Sep 2021 05:59:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22FBC061756;
        Thu, 23 Sep 2021 02:57:47 -0700 (PDT)
Date:   Thu, 23 Sep 2021 09:57:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632391066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5UltBQHhMoF8Yb7sKIN4Z42AUWMPW8NPyidd7V7lcc4=;
        b=T1NdHgzlIpt4/6CXDIMM714cSrHQbFwp6tC94NNjNcNT8prIllNAqk7IxXBDu8/bGJMePq
        0R6eQ+Yzc3NelHW2oMCfuEwH4L+Rscb7p11ztmuj+Y4mq0P2pNE3Gh9rwysZ/kLTZEMl1V
        Wr22ZY0yt6BNprKMZRJFq87Q4akKFjl6Wn6aAmxZ09oTXxlsgKm2L3fJAMuyBKnmsG7wKm
        CWrrquhn2VP8fI+0hYZSpEBcNEorOn0FAQ/tNDHwPK8k68oR/WbXvXg1Uu68adRMkCGqMG
        Lk46f3c/D+TfOoB/yVuITdefrG560Z4xItszjxdhHhKcdFa+jSQFJuM14EhZZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632391066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5UltBQHhMoF8Yb7sKIN4Z42AUWMPW8NPyidd7V7lcc4=;
        b=CZhwIi2VSDDJ4+K/k07WzFaRDZIIGQse08AQJ2WaYpwueaEFWDrEsEEdfZYN0Z1R7tCzsx
        zlBCkS6nO74tJBCw==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/asm: Fix SETZ size enqcmds() build failure
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210910223332.3224851-1-keescook@chromium.org>
References: <20210910223332.3224851-1-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <163239106571.25758.1553748717788924474.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d81ff5fe14a950f53e2833cfa196e7bb3fd5d4e3
Gitweb:        https://git.kernel.org/tip/d81ff5fe14a950f53e2833cfa196e7bb3fd5d4e3
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 10 Sep 2021 15:33:32 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 22 Sep 2021 19:45:48 +02:00

x86/asm: Fix SETZ size enqcmds() build failure

When building under GCC 4.9 and 5.5:

  arch/x86/include/asm/special_insns.h: Assembler messages:
  arch/x86/include/asm/special_insns.h:286: Error: operand size mismatch for `setz'

Change the type to "bool" for condition code arguments, as documented.

Fixes: 7f5933f81bd8 ("x86/asm: Add an enqcmds() wrapper for the ENQCMDS instruction")
Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210910223332.3224851-1-keescook@chromium.org
---
 arch/x86/include/asm/special_insns.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index f3fbb84..68c257a 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -275,7 +275,7 @@ static inline int enqcmds(void __iomem *dst, const void *src)
 {
 	const struct { char _[64]; } *__src = src;
 	struct { char _[64]; } __iomem *__dst = dst;
-	int zf;
+	bool zf;
 
 	/*
 	 * ENQCMDS %(rdx), rax
