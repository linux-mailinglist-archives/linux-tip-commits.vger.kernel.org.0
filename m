Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D976443B6D4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbhJZQTR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34658 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237351AbhJZQTN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:13 -0400
Date:   Tue, 26 Oct 2021 16:16:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635265008;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EaSLpU5XXh7jOsJUT5EUyU1t0j2kCxWryIVJH1Uxkps=;
        b=FvVE6gwOLOIYZqwYUXA2EG1jUqTRLaRWj49f0MFMbOrdOi01+XVvSUm8r2Ayn565B+7E7M
        G54cuctuszgncRJUiEesFNNpNdCnmu65wXhS8lyOZDEvqhYKeFRWgkTghmFtwy+pZIapw/
        82+v88qOYJZkYZdQ2HZ4g5dQ4EJJiFN4vn7mpTwCHwE5AOyrbiwZ1jw4nTl4HYbUOdLPSo
        gPhFuFHALRV0xx9Qr7eVx+IHqDNpbuLG+etQaqUa2uwMbKMg0VCmo9E/peWnP5krz+uAJE
        ukCAa/fMuL9jGLCM+6Gc7buomWsq8G0XCWHNy2O2tkNLwZBmmX18+Y0iaLS0Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635265008;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EaSLpU5XXh7jOsJUT5EUyU1t0j2kCxWryIVJH1Uxkps=;
        b=ytGbAOjqsWLFPrFizxsmOWN66rv6SHQgUkW04EB1rCotGzzf7Su4T9xUnWruiNjPb8V/oW
        oZ3OS6NS5Sq63QAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Add members to struct fpu to cache permission
 information
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021225527.10184-5-chang.seok.bae@intel.com>
References: <20211021225527.10184-5-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526500699.626.2478396287199076729.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     6f6a7c09c4065a5b140194dfcfe4cf7104fec4d2
Gitweb:        https://git.kernel.org/tip/6f6a7c09c4065a5b140194dfcfe4cf7104fec4d2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 Oct 2021 15:55:08 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 10:18:09 +02:00

x86/fpu: Add members to struct fpu to cache permission information

Dynamically enabled features can be requested by any thread of a running
process at any time. The request does neither enable the feature nor
allocate larger buffers. It just stores the permission to use the feature
by adding the features to the permission bitmap and by calculating the
required sizes for kernel and user space.

The reallocation of the kernel buffer happens when the feature is used
for the first time which is caught by an exception. The permission
bitmap is then checked and if the feature is permitted, then it becomes
fully enabled. If not, the task dies similarly to a task which uses an
undefined instruction.

The size information is precomputed to allow proper sigaltstack size checks
once the feature is permitted, but not yet in use because otherwise this
would open race windows where too small stacks could be installed causing
a later fail on signal delivery.

Initialize them to the default feature set and sizes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211021225527.10184-5-chang.seok.bae@intel.com
---
 arch/x86/include/asm/fpu/types.h | 46 +++++++++++++++++++++++++++++++-
 arch/x86/kernel/fpu/core.c       |  5 +++-
 2 files changed, 51 insertions(+)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index c72cb22..c3ec562 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -352,6 +352,45 @@ struct fpstate {
 	/* @regs is dynamically sized! Don't add anything after @regs! */
 } __aligned(64);
 
+struct fpu_state_perm {
+	/*
+	 * @__state_perm:
+	 *
+	 * This bitmap indicates the permission for state components, which
+	 * are available to a thread group. The permission prctl() sets the
+	 * enabled state bits in thread_group_leader()->thread.fpu.
+	 *
+	 * All run time operations use the per thread information in the
+	 * currently active fpu.fpstate which contains the xfeature masks
+	 * and sizes for kernel and user space.
+	 *
+	 * This master permission field is only to be used when
+	 * task.fpu.fpstate based checks fail to validate whether the task
+	 * is allowed to expand it's xfeatures set which requires to
+	 * allocate a larger sized fpstate buffer.
+	 *
+	 * Do not access this field directly.  Use the provided helper
+	 * function. Unlocked access is possible for quick checks.
+	 */
+	u64				__state_perm;
+
+	/*
+	 * @__state_size:
+	 *
+	 * The size required for @__state_perm. Only valid to access
+	 * with sighand locked.
+	 */
+	unsigned int			__state_size;
+
+	/*
+	 * @__user_state_size:
+	 *
+	 * The size required for @__state_perm user part. Only valid to
+	 * access with sighand locked.
+	 */
+	unsigned int			__user_state_size;
+};
+
 /*
  * Highest level per task FPU state data structure that
  * contains the FPU register state plus various FPU
@@ -396,6 +435,13 @@ struct fpu {
 	struct fpstate			*__task_fpstate;
 
 	/*
+	 * @perm:
+	 *
+	 * Permission related information
+	 */
+	struct fpu_state_perm		perm;
+
+	/*
 	 * @__fpstate:
 	 *
 	 * Initial in-memory storage for FPU registers which are saved in
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 9c475e2..b05f6a3 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -412,6 +412,11 @@ void fpstate_reset(struct fpu *fpu)
 	/* Set the fpstate pointer to the default fpstate */
 	fpu->fpstate = &fpu->__fpstate;
 	__fpstate_reset(fpu->fpstate);
+
+	/* Initialize the permission related info in fpu */
+	fpu->perm.__state_perm		= fpu_kernel_cfg.default_features;
+	fpu->perm.__state_size		= fpu_kernel_cfg.default_size;
+	fpu->perm.__user_state_size	= fpu_user_cfg.default_size;
 }
 
 /* Clone current's FPU state on fork */
