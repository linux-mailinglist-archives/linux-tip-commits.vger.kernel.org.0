Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E3737B90C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 11:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhELJYp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 05:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhELJYn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 05:24:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197C5C061574;
        Wed, 12 May 2021 02:23:35 -0700 (PDT)
Date:   Wed, 12 May 2021 09:23:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620811413;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U73vDTtSOm+Ipy96hwjnKSSfD3f6/Ro8KWHjqbgGBpc=;
        b=qSI9Ka2OX/vTvhPGnxkh1cDW3t/zCjTqA7NyBQSJFfAfbZVu+bjWYlzes3d8dXPFC8Sw3B
        uoPS0CvyT/OZDh6zPnrcfV/b+35vuit+hGrZUT8ukS97xQRwN7C71up+LxrediM5l4pHgN
        lusdB8djjx7WRLtCU78rPpK4yPtpLXy3vnfDVY1ZWkHm4zo36yiD1rTROdz2qBBlS/H8Bk
        +QuPVH6oFkTfGk6bcqgage2v17Kzou4OSulgfjMV1GeMDHgwnFHwbtJ1jXnJaXHeBJgpBm
        +sicOjtdeYkcTXoXEGCZpgbOj5vzKAJ9CldImeIEeD0FoNte006IfA5njL5XIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620811413;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U73vDTtSOm+Ipy96hwjnKSSfD3f6/Ro8KWHjqbgGBpc=;
        b=WtP7+6A4a3aSRgrCZRYvJGPVo+7ssmxmR1FsHZ/34YXon8L0W8rcZNEqB/OdWIMQC4Vq4G
        B2M8YnrYHqBlz+AQ==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/syscall: Unconditionally prototype
 {ia32,x32}_sys_call_table[]
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210510185316.3307264-4-hpa@zytor.com>
References: <20210510185316.3307264-4-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <162081141303.29796.12436833692837564048.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     dce0aa3b2ef28900cc4c779c59a870f1b4bdadee
Gitweb:        https://git.kernel.org/tip/dce0aa3b2ef28900cc4c779c59a870f1b4bdadee
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Mon, 10 May 2021 11:53:12 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 10:49:15 +02:00

x86/syscall: Unconditionally prototype {ia32,x32}_sys_call_table[]

Even if these APIs are disabled, and the arrays therefore do not
exist, having the prototypes allows us to use IS_ENABLED() rather than
using #ifdefs.

If something ends up trying to actually *use* these arrays a linker
error will ensue.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210510185316.3307264-4-hpa@zytor.com
---
 arch/x86/include/asm/syscall.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 4e20054..f6593ca 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -21,13 +21,12 @@ extern const sys_call_ptr_t sys_call_table[];
 
 #if defined(CONFIG_X86_32)
 #define ia32_sys_call_table sys_call_table
-#endif
-
-#if defined(CONFIG_IA32_EMULATION)
+#else
+/*
+ * These may not exist, but still put the prototypes in so we
+ * can use IS_ENABLED().
+ */
 extern const sys_call_ptr_t ia32_sys_call_table[];
-#endif
-
-#ifdef CONFIG_X86_X32_ABI
 extern const sys_call_ptr_t x32_sys_call_table[];
 #endif
 
