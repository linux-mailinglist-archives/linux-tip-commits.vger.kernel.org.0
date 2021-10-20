Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AD7434C7A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhJTNra (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbhJTNrD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:47:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FECC061755;
        Wed, 20 Oct 2021 06:44:39 -0700 (PDT)
Date:   Wed, 20 Oct 2021 13:44:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737478;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aoDvuqZuXvNzCvNxUgVT3AHSokgyRhu0AKYTEBirvak=;
        b=r5Vu3Sa+Cgz7sgFvsafckwT5gALOKFxBbCxksFh0FfXAxgGv1GvKagANaTtUSfmwCbeNya
        K41beRY4ntKR+tUc2WEPUehghHLyc8YLTeBpWBPJYfBfNb7crBc0aNHf3pCA/4boBRiEYc
        kBiIAtgopYDnJErAWrRVxc1kIjTteMOmE8mu91DoJM6zoxxGPXLr+ZxFtvzxPWAYJQXWov
        tddx/qGa+JX54kAJ0yycS8z0qEgnn6ej57KiwbVWipPYfekxTy1fo2EACNcS4WAnAv5b+R
        WJiPIoOMnxBN/GIN7Jz/t2qLH40TR7LVXdF7q9L9e6jS38U46xwGFezl1ToxQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737478;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aoDvuqZuXvNzCvNxUgVT3AHSokgyRhu0AKYTEBirvak=;
        b=D/AJc5OC55Lllc/f0dP2bT3FyXV19ekp3nGq8svUCaL6GG1SzNBAREnWPA5/B3oVy1s9it
        BdGYuBbdi5NgVUAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Rework copy_xstate_to_uabi_buf()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011539.191902137@linutronix.de>
References: <20211015011539.191902137@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473747755.25758.4060031587900668086.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     ca834defd33bae9cf9542ff92b15635a84e91946
Gitweb:        https://git.kernel.org/tip/ca834defd33bae9cf9542ff92b15635a84e91946
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:15 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:27 +02:00

x86/fpu: Rework copy_xstate_to_uabi_buf()

Prepare for replacing the KVM copy xstate to user function by extending
copy_xstate_to_uabi_buf() with a pkru argument which allows the caller to
hand in the pkru value, which is required for KVM because the guest PKRU is
not accessible via current. Fixup all callsites accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011539.191902137@linutronix.de
---
 arch/x86/kernel/fpu/xstate.c | 34 ++++++++++++++++++++++++++--------
 arch/x86/kernel/fpu/xstate.h |  3 +++
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index eeeb807..b2537a8 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -940,9 +940,10 @@ static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
 }
 
 /**
- * copy_xstate_to_uabi_buf - Copy kernel saved xstate to a UABI buffer
+ * __copy_xstate_to_uabi_buf - Copy kernel saved xstate to a UABI buffer
  * @to:		membuf descriptor
- * @tsk:	The task from which to copy the saved xstate
+ * @xsave:	The xsave from which to copy
+ * @pkru_val:	The PKRU value to store in the PKRU component
  * @copy_mode:	The requested copy mode
  *
  * Converts from kernel XSAVE or XSAVES compacted format to UABI conforming
@@ -951,11 +952,10 @@ static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
  *
  * It supports partial copy but @to.pos always starts from zero.
  */
-void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
-			     enum xstate_copy_mode copy_mode)
+void __copy_xstate_to_uabi_buf(struct membuf to, struct xregs_state *xsave,
+			       u32 pkru_val, enum xstate_copy_mode copy_mode)
 {
 	const unsigned int off_mxcsr = offsetof(struct fxregs_state, mxcsr);
-	struct xregs_state *xsave = &tsk->thread.fpu.state.xsave;
 	struct xregs_state *xinit = &init_fpstate.xsave;
 	struct xstate_header header;
 	unsigned int zerofrom;
@@ -1033,10 +1033,9 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 			struct pkru_state pkru = {0};
 			/*
 			 * PKRU is not necessarily up to date in the
-			 * thread's XSAVE buffer.  Fill this part from the
-			 * per-thread storage.
+			 * XSAVE buffer. Use the provided value.
 			 */
-			pkru.pkru = tsk->thread.pkru;
+			pkru.pkru = pkru_val;
 			membuf_write(&to, &pkru, sizeof(pkru));
 		} else {
 			copy_feature(header.xfeatures & BIT_ULL(i), &to,
@@ -1056,6 +1055,25 @@ out:
 		membuf_zero(&to, to.left);
 }
 
+/**
+ * copy_xstate_to_uabi_buf - Copy kernel saved xstate to a UABI buffer
+ * @to:		membuf descriptor
+ * @tsk:	The task from which to copy the saved xstate
+ * @copy_mode:	The requested copy mode
+ *
+ * Converts from kernel XSAVE or XSAVES compacted format to UABI conforming
+ * format, i.e. from the kernel internal hardware dependent storage format
+ * to the requested @mode. UABI XSTATE is always uncompacted!
+ *
+ * It supports partial copy but @to.pos always starts from zero.
+ */
+void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
+			     enum xstate_copy_mode copy_mode)
+{
+	__copy_xstate_to_uabi_buf(to, &tsk->thread.fpu.state.xsave,
+				  tsk->thread.pkru, copy_mode);
+}
+
 static int copy_from_buffer(void *dst, unsigned int offset, unsigned int size,
 			    const void *kbuf, const void __user *ubuf)
 {
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 0789a04..81f4202 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -15,4 +15,7 @@ static inline void xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
 		xsave->header.xcomp_bv = mask | XCOMP_BV_COMPACTED_FORMAT;
 }
 
+extern void __copy_xstate_to_uabi_buf(struct membuf to, struct xregs_state *xsave,
+				      u32 pkru_val, enum xstate_copy_mode copy_mode);
+
 #endif
