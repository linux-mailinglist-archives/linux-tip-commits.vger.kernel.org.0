Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB27285C46
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 12:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgJGKDK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 06:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgJGKC5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 06:02:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01652C061755;
        Wed,  7 Oct 2020 03:02:57 -0700 (PDT)
Date:   Wed, 07 Oct 2020 10:02:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602064975;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9gn0RJniQGCHLzamn9Vq2LHdRzy29vxhgkLmKDnIu/8=;
        b=xxIlFHGRjun5LtiPB1ef6ThRRHjHLqrVaAXjCRAnJpul6OqrLoXhulQkRzLaY1SfXHo1hu
        7C+oZm7SU+LKy6CNxb/a1hPySYl/lPC7MVtunLu9xEeOzwk/GFTGmKg3LDTpjXXsSXJ+zm
        WHzK+wK3M+7ZqeY/My5s4/zMvwz134ETTnU5EywHzHESjO1IZ4QS+BMZM+l8FttYpWSvyX
        hxOyvICn9iga6MRYYkJXxzesGOzftebXTesICLdB7xRmoRm7YTOQqc5dqiB4KP+1T0P7ZY
        RnuCvZIcXDMqdcKAVb2TcXCBBqoj7JbqSLV7McQjbmv7ep1MpadZFYycgzCWsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602064975;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9gn0RJniQGCHLzamn9Vq2LHdRzy29vxhgkLmKDnIu/8=;
        b=XTAvJ+N9JijPTxMFcZ8mIdcY9hZPOgrbNcN0QMDkJroxJP2Aovuq2H8eYSUPUZ/+d7+0dO
        msbR/1flFl2eJsBw==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Provide method to find out the type of an
 exception handler
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201006210910.21062-3-tony.luck@intel.com>
References: <20201006210910.21062-3-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <160206496950.7002.6730187672804066789.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     a05d54c41ecfa1a322b229b4e5ce50c157284f74
Gitweb:        https://git.kernel.org/tip/a05d54c41ecfa1a322b229b4e5ce50c157284f74
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 06 Oct 2020 14:09:06 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 07 Oct 2020 11:08:59 +02:00

x86/mce: Provide method to find out the type of an exception handler

Avoid a proliferation of ex_has_*_handler() functions by having just
one function that returns the type of the handler (if any).

Drop the __visible attribute for this function. It is not called
from assembler so the attribute is not necessary.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201006210910.21062-3-tony.luck@intel.com
---
 arch/x86/include/asm/extable.h     |  9 ++++++++-
 arch/x86/kernel/cpu/mce/severity.c |  5 ++++-
 arch/x86/mm/extable.c              | 12 ++++++++----
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/extable.h b/arch/x86/include/asm/extable.h
index d8c2198..1f0cbc5 100644
--- a/arch/x86/include/asm/extable.h
+++ b/arch/x86/include/asm/extable.h
@@ -29,10 +29,17 @@ struct pt_regs;
 		(b)->handler = (tmp).handler - (delta);		\
 	} while (0)
 
+enum handler_type {
+	EX_HANDLER_NONE,
+	EX_HANDLER_FAULT,
+	EX_HANDLER_UACCESS,
+	EX_HANDLER_OTHER
+};
+
 extern int fixup_exception(struct pt_regs *regs, int trapnr,
 			   unsigned long error_code, unsigned long fault_addr);
 extern int fixup_bug(struct pt_regs *regs, int trapnr);
-extern bool ex_has_fault_handler(unsigned long ip);
+extern enum handler_type ex_get_fault_handler_type(unsigned long ip);
 extern void early_fixup_exception(struct pt_regs *regs, int trapnr);
 
 #endif
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 0b072dc..c6494e6 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -225,10 +225,13 @@ static struct severity {
  */
 static int error_context(struct mce *m, struct pt_regs *regs)
 {
+	enum handler_type t;
+
 	if ((m->cs & 3) == 3)
 		return IN_USER;
 
-	if (mc_recoverable(m->mcgstatus) && ex_has_fault_handler(m->ip)) {
+	t = ex_get_fault_handler_type(m->ip);
+	if (mc_recoverable(m->mcgstatus) && t == EX_HANDLER_FAULT) {
 		m->kflags |= MCE_IN_KERNEL_RECOV;
 		return IN_KERNEL_RECOV;
 	}
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 1d6cb07..de43525 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -125,17 +125,21 @@ __visible bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
 }
 EXPORT_SYMBOL(ex_handler_clear_fs);
 
-__visible bool ex_has_fault_handler(unsigned long ip)
+enum handler_type ex_get_fault_handler_type(unsigned long ip)
 {
 	const struct exception_table_entry *e;
 	ex_handler_t handler;
 
 	e = search_exception_tables(ip);
 	if (!e)
-		return false;
+		return EX_HANDLER_NONE;
 	handler = ex_fixup_handler(e);
-
-	return handler == ex_handler_fault;
+	if (handler == ex_handler_fault)
+		return EX_HANDLER_FAULT;
+	else if (handler == ex_handler_uaccess)
+		return EX_HANDLER_UACCESS;
+	else
+		return EX_HANDLER_OTHER;
 }
 
 int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
