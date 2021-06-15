Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5926C3A7C75
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Jun 2021 12:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhFOKyI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 15 Jun 2021 06:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhFOKyG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 15 Jun 2021 06:54:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF5AC06175F;
        Tue, 15 Jun 2021 03:52:01 -0700 (PDT)
Date:   Tue, 15 Jun 2021 10:51:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623754317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ehTyxZ1zPqyQv+vzIOiUtO11ULsVjYxCXCKYkwBgtKU=;
        b=cT4LsHqWZbBg7Ua6+vJgu5CKP0vmP5UzNerY6aYXQMAO/eBtfPQe5TFdcn2Pm5UHg0/jPk
        h0NrsrxEnyPgLFQovWzxckq/rozyFF1pLZG69uFBE8qlhqlgAPCrmYgNK+qlLh20U6fzsE
        Zy+0PeBonys9r0oHNT328P+i55pQB+ckAVAwQfJEBurL9k6oypjlswVZo5bflNVw+eK6u9
        o+r/kCJDj/cL0XmTI1qJw+44rt3U84CKIHU7Kjm14M5tahVr6j4ZEeG6OyIh+YrBkrzIzU
        w0u+woBP7x7aH5FoWAMIRwX7Af+I6Vv1C1hOEgRoAW2Sv8w5L2LcyQfNfXZJ4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623754317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ehTyxZ1zPqyQv+vzIOiUtO11ULsVjYxCXCKYkwBgtKU=;
        b=hHxozy12bn9NkdueCvtnD2wQ2+09AhxE/WP7ohVPmOzVLdDV0JX/Yrhe8kmuD8bdNcVhsR
        t+O5vRQRDNfqNjAg==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/insn: Extend error reporting from
 insn_fetch_from_user[_inatomic]()
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210614135327.9921-6-joro@8bytes.org>
References: <20210614135327.9921-6-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <162375431666.19906.425378072212766758.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     4aaa7eacd7cc7c10f269c7f2a01d044b375bed8e
Gitweb:        https://git.kernel.org/tip/4aaa7eacd7cc7c10f269c7f2a01d044b375bed8e
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 14 Jun 2021 15:53:26 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 15 Jun 2021 11:39:30 +02:00

x86/insn: Extend error reporting from insn_fetch_from_user[_inatomic]()

The error reporting from the insn_fetch_from_user*() functions is not
very verbose. Extend it to include information on whether the linear
RIP could not be calculated or whether the memory access faulted.

This will be used in the SEV-ES code to propagate the correct
exception depending on what went wrong during instruction fetch.

 [ bp: Massage comments. ]

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210614135327.9921-6-joro@8bytes.org
---
 arch/x86/kernel/sev.c    |  8 ++++----
 arch/x86/kernel/umip.c   | 10 ++++------
 arch/x86/lib/insn-eval.c | 16 ++++++++--------
 3 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 4fd997b..a1eeaa7 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -258,17 +258,17 @@ static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
 static enum es_result __vc_decode_user_insn(struct es_em_ctxt *ctxt)
 {
 	char buffer[MAX_INSN_SIZE];
-	int res;
+	int insn_bytes;
 
-	res = insn_fetch_from_user_inatomic(ctxt->regs, buffer);
-	if (!res) {
+	insn_bytes = insn_fetch_from_user_inatomic(ctxt->regs, buffer);
+	if (insn_bytes <= 0) {
 		ctxt->fi.vector     = X86_TRAP_PF;
 		ctxt->fi.error_code = X86_PF_INSTR | X86_PF_USER;
 		ctxt->fi.cr2        = ctxt->regs->ip;
 		return ES_EXCEPTION;
 	}
 
-	if (!insn_decode_from_regs(&ctxt->insn, ctxt->regs, buffer, res))
+	if (!insn_decode_from_regs(&ctxt->insn, ctxt->regs, buffer, insn_bytes))
 		return ES_DECODE_FAILED;
 
 	if (ctxt->insn.immediate.got)
diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 8daa70b..576b47e 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -346,14 +346,12 @@ bool fixup_umip_exception(struct pt_regs *regs)
 	if (!regs)
 		return false;
 
-	nr_copied = insn_fetch_from_user(regs, buf);
-
 	/*
-	 * The insn_fetch_from_user above could have failed if user code
-	 * is protected by a memory protection key. Give up on emulation
-	 * in such a case.  Should we issue a page fault?
+	 * Give up on emulation if fetching the instruction failed. Should a
+	 * page fault or a #GP be issued?
 	 */
-	if (!nr_copied)
+	nr_copied = insn_fetch_from_user(regs, buf);
+	if (nr_copied <= 0)
 		return false;
 
 	if (!insn_decode_from_regs(&insn, regs, buf, nr_copied))
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 4eecb9c..a1d24fd 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1448,9 +1448,9 @@ static int insn_get_effective_ip(struct pt_regs *regs, unsigned long *ip)
  *
  * Returns:
  *
- * Number of instruction bytes copied.
- *
- * 0 if nothing was copied.
+ * - number of instruction bytes copied.
+ * - 0 if nothing was copied.
+ * - -EINVAL if the linear address of the instruction could not be calculated
  */
 int insn_fetch_from_user(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
 {
@@ -1458,7 +1458,7 @@ int insn_fetch_from_user(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
 	int not_copied;
 
 	if (insn_get_effective_ip(regs, &ip))
-		return 0;
+		return -EINVAL;
 
 	not_copied = copy_from_user(buf, (void __user *)ip, MAX_INSN_SIZE);
 
@@ -1476,9 +1476,9 @@ int insn_fetch_from_user(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
  *
  * Returns:
  *
- * Number of instruction bytes copied.
- *
- * 0 if nothing was copied.
+ *  - number of instruction bytes copied.
+ *  - 0 if nothing was copied.
+ *  - -EINVAL if the linear address of the instruction could not be calculated.
  */
 int insn_fetch_from_user_inatomic(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
 {
@@ -1486,7 +1486,7 @@ int insn_fetch_from_user_inatomic(struct pt_regs *regs, unsigned char buf[MAX_IN
 	int not_copied;
 
 	if (insn_get_effective_ip(regs, &ip))
-		return 0;
+		return -EINVAL;
 
 	not_copied = __copy_from_user_inatomic(buf, (void __user *)ip, MAX_INSN_SIZE);
 
