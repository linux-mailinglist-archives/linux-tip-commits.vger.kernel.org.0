Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D854B40B7D2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Sep 2021 21:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbhINTUx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Sep 2021 15:20:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35368 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbhINTUt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Sep 2021 15:20:49 -0400
Date:   Tue, 14 Sep 2021 19:19:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631647170;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ywOizrv73AApFx1vwFei2h08cAz9nC1EuR5IqgsktdE=;
        b=45nCP6zksP9g806Pn75JPPtllAm7UtqCpdjhjbhhSDxcIMn1d1fz1usJsNyvlGC+UKaEQn
        qxRqqlLY6HKAc1pbUXjk9N/KL8t9ultD8Kvq2RodKudDloi+LUtaaPyaPKwCygczz9ZwW5
        rsESOMO8b/OYa3cPfR3bznUjSuyQzmpZOImhEiXgnymPc7iMZDGqXFytL5F02aLeLw3CNK
        GpHDaOtM3eo4m3sjVmZWwf0KTxTLMcXFwlIQFPHQMgfmypz4o0c4/Dcl4iK3Ife7+XrSLa
        A+/DP7tyzrNMq9gRHQJlZYzkkg3Ck/jlz9fFzvE7b5WT7bFLwixY3etxV7tHiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631647170;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ywOizrv73AApFx1vwFei2h08cAz9nC1EuR5IqgsktdE=;
        b=n9h/0PeMBBXqGhGYI0YtPEnoOA5TWhQKdkzByl6ekyL05fojKN+LT/Y6g8IzOS+Cj7+O+Y
        iHuL6Dedbp4ZqDDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/signal: Move header zeroing out of
 xsave_to_user_sigframe()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210908132525.621674721@linutronix.de>
References: <20210908132525.621674721@linutronix.de>
MIME-Version: 1.0
Message-ID: <163164717015.25758.13064322936965435358.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     4164a482a5d92c29eaf53d01755103f6bbce38f2
Gitweb:        https://git.kernel.org/tip/4164a482a5d92c29eaf53d01755103f6bbce38f2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 08 Sep 2021 15:29:29 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Sep 2021 21:10:03 +02:00

x86/fpu/signal: Move header zeroing out of xsave_to_user_sigframe()

There is no reason to have the header zeroing in the pagefault disabled
region. Do it upfront once.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210908132525.621674721@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 17 ++++++-----------
 arch/x86/kernel/fpu/signal.c        | 12 ++++++++++++
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 4cfd40d..c856ca4 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -318,9 +318,12 @@ static inline void os_xrstor(struct xregs_state *xstate, u64 mask)
  * We don't use modified optimization because xrstor/xrstors might track
  * a different application.
  *
- * We don't use compacted format xsave area for
- * backward compatibility for old applications which don't understand
- * compacted format of xsave area.
+ * We don't use compacted format xsave area for backward compatibility for
+ * old applications which don't understand the compacted format of the
+ * xsave area.
+ *
+ * The caller has to zero buf::header before calling this because XSAVE*
+ * does not touch the reserved fields in the header.
  */
 static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 {
@@ -334,14 +337,6 @@ static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 	u32 hmask = mask >> 32;
 	int err;
 
-	/*
-	 * Clear the xsave header first, so that reserved fields are
-	 * initialized to zero.
-	 */
-	err = __clear_user(&buf->header, sizeof(buf->header));
-	if (unlikely(err))
-		return -EFAULT;
-
 	stac();
 	XSTATE_OP(XSAVE, buf, lmask, hmask, err);
 	clac();
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 9bfffdb..5ca3ce9 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -189,6 +189,18 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 
 	if (!access_ok(buf, size))
 		return -EACCES;
+
+	if (use_xsave()) {
+		struct xregs_state __user *xbuf = buf_fx;
+
+		/*
+		 * Clear the xsave header first, so that reserved fields are
+		 * initialized to zero.
+		 */
+		ret = __clear_user(&xbuf->header, sizeof(xbuf->header));
+		if (unlikely(ret))
+			return ret;
+	}
 retry:
 	/*
 	 * Load the FPU registers if they are not valid for the current task.
