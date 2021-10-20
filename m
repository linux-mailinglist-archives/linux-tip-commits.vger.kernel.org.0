Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D391434C70
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhJTNrK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:47:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53026 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhJTNq5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:46:57 -0400
Date:   Wed, 20 Oct 2021 13:44:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b+MJi8yWzhDmj5AxIYMmDl7AcBvxbFIfUkfoZozo79E=;
        b=B0yqxWpENcGRFCshmQ8gG29IdL4PoI3w+qyZNMPdtRcw0yXvUWATPEgABtbDc9YDAZiHg2
        S3V+jE+98g7dyRCeznjL7hFLqe0lJPpmm1bhoUPmnw1VmXlwpAXx6NIDbDNukfNCWFgDNb
        EUuCCzobNqLlCIejhKex3o/ung5bXyWI1Y+r0RlsiCRGkkOaaIyhN9PqirsjZnoa2ViLD2
        0YaKWuE2ikDcvGvjHHnhO6NKQW9AEnw+f53fOjii1wfFPrxh018Plml5URtOaO3wGinfP4
        L0ed+HThl6m3ik9CzPgPMKz+EG8y+Aze2rfEph36urlCKfJ682H1RSg/ODjBQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b+MJi8yWzhDmj5AxIYMmDl7AcBvxbFIfUkfoZozo79E=;
        b=7tBBu0uZugb35PwjydQHUvqlX8Ry7qWDu8b3VMQVpFB9HDeOab4IlHPZrfF1+NvRh7m0SM
        w9RnBqLNUlrxyYBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Do not inherit FPU context for kernel and IO
 worker threads
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011538.839822981@linutronix.de>
References: <20211015011538.839822981@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473748163.25758.597185307000575063.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     509e7a30cd0a9f38abac4114832d9f69ff0d73b4
Gitweb:        https://git.kernel.org/tip/509e7a30cd0a9f38abac4114832d9f69ff0d73b4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:06 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:26 +02:00

x86/fpu: Do not inherit FPU context for kernel and IO worker threads

There is no reason why kernel and IO worker threads need a full clone of
the parent's FPU state. Both are kernel threads which are not supposed to
use FPU. So copying a large state or doing XSAVE() is pointless. Just clean
out the minimally required state for those tasks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011538.839822981@linutronix.de
---
 arch/x86/kernel/fpu/core.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 191269e..9a6b195 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -212,6 +212,15 @@ static inline void fpstate_init_xstate(struct xregs_state *xsave)
 	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask_all;
 }
 
+static inline unsigned int init_fpstate_copy_size(void)
+{
+	if (!use_xsave())
+		return fpu_kernel_xstate_size;
+
+	/* XSAVE(S) just needs the legacy and the xstate header part */
+	return sizeof(init_fpstate.xsave);
+}
+
 static inline void fpstate_init_fxstate(struct fxregs_state *fx)
 {
 	fx->cwd = 0x37f;
@@ -260,6 +269,23 @@ int fpu_clone(struct task_struct *dst)
 		return 0;
 
 	/*
+	 * Enforce reload for user space tasks and prevent kernel threads
+	 * from trying to save the FPU registers on context switch.
+	 */
+	set_tsk_thread_flag(dst, TIF_NEED_FPU_LOAD);
+
+	/*
+	 * No FPU state inheritance for kernel threads and IO
+	 * worker threads.
+	 */
+	if (dst->flags & (PF_KTHREAD | PF_IO_WORKER)) {
+		/* Clear out the minimal state */
+		memcpy(&dst_fpu->state, &init_fpstate,
+		       init_fpstate_copy_size());
+		return 0;
+	}
+
+	/*
 	 * If the FPU registers are not owned by current just memcpy() the
 	 * state.  Otherwise save the FPU registers directly into the
 	 * child's FPU context, without any memory-to-memory copying.
@@ -272,8 +298,6 @@ int fpu_clone(struct task_struct *dst)
 		save_fpregs_to_fpstate(dst_fpu);
 	fpregs_unlock();
 
-	set_tsk_thread_flag(dst, TIF_NEED_FPU_LOAD);
-
 	trace_x86_fpu_copy_src(src_fpu);
 	trace_x86_fpu_copy_dst(dst_fpu);
 
@@ -322,15 +346,6 @@ static inline void restore_fpregs_from_init_fpstate(u64 features_mask)
 	pkru_write_default();
 }
 
-static inline unsigned int init_fpstate_copy_size(void)
-{
-	if (!use_xsave())
-		return fpu_kernel_xstate_size;
-
-	/* XSAVE(S) just needs the legacy and the xstate header part */
-	return sizeof(init_fpstate.xsave);
-}
-
 /*
  * Reset current->fpu memory state to the init values.
  */
