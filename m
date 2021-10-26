Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A2443B6BE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbhJZQTB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34524 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbhJZQTA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:00 -0400
Date:   Tue, 26 Oct 2021 16:16:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635264995;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C/Y5w2cigxJPQyAwDPQ6sws/nwkk05ndnNSOnkj1bSY=;
        b=XSVZQvFORFoMKewVfJGeYEwoqBrITcL/Y27YT4o7lALvV7BIHJvxG4kGpeZ262r2fQu4r8
        3x8StxlT7vR80g15OG+9IpoSyZbvsJ/hHr/0eO/T6WzlIJVYuJtj3VgiTCxou60Sz4q9XP
        QEnwhfK1zkMGNN6VPT01wxuJaabCugK9c2Ys0DwEwHNXor46gdwLU3aD8FHLnG65hL9S5z
        lP/NpImRNjOFevkFQNN+2ifXAuu9Vl68RCiXRcpixEJb63ZRSwYSlegc1Ws0H75ZfMFNpY
        1xHjcxyYKx47KrepX+/6Cgx53evI1z9WFwM4+xZX9LqKZR1XjC2+Y4FUiRb4Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635264995;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C/Y5w2cigxJPQyAwDPQ6sws/nwkk05ndnNSOnkj1bSY=;
        b=bsWoWUZ+FRB9KOe+2oN3TwX8HDl/vVoJacsO8ootXcpcYNXd/rIvNyitFscFQN+9tm5jPs
        HMbvMvvlCE3d1VDw==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Add XFD handling for dynamic states
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021225527.10184-23-chang.seok.bae@intel.com>
References: <20211021225527.10184-23-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526499416.626.3578675865392179297.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     db3e7321b4b84b1cb39598ff79b90d1252481378
Gitweb:        https://git.kernel.org/tip/db3e7321b4b84b1cb39598ff79b90d1252481378
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 21 Oct 2021 15:55:26 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 10:53:03 +02:00

x86/fpu: Add XFD handling for dynamic states

To handle the dynamic sizing of buffers on first use the XFD MSR has to be
armed. Store the delta between the maximum available and the default
feature bits in init_fpstate where it can be retrieved for task creation.

If the delta is non zero then dynamic features are enabled. This needs also
to enable the static key which guards the XFD updates. This is delayed to
an initcall because the FPU setup runs before jump labels are initialized.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211021225527.10184-23-chang.seok.bae@intel.com
---
 arch/x86/kernel/fpu/xstate.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index b0f6e9a..987a07b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -835,6 +835,12 @@ static void __init fpu__init_disable_system_xstate(unsigned int legacy_size)
 	fpu_user_cfg.max_size = legacy_size;
 	fpu_user_cfg.default_size = legacy_size;
 
+	/*
+	 * Prevent enabling the static branch which enables writes to the
+	 * XFD MSR.
+	 */
+	init_fpstate.xfd = 0;
+
 	fpstate_reset(&current->thread.fpu);
 }
 
@@ -918,6 +924,14 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	/* Store it for paranoia check at the end */
 	xfeatures = fpu_kernel_cfg.max_features;
 
+	/*
+	 * Initialize the default XFD state in initfp_state and enable the
+	 * dynamic sizing mechanism if dynamic states are available.  The
+	 * static key cannot be enabled here because this runs before
+	 * jump_label_init(). This is delayed to an initcall.
+	 */
+	init_fpstate.xfd = fpu_user_cfg.max_features & XFEATURE_MASK_USER_DYNAMIC;
+
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
 	err = init_xstate_size();
@@ -1466,9 +1480,21 @@ void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor)
 }
 #endif /* CONFIG_X86_DEBUG_FPU */
 
+static int __init xfd_update_static_branch(void)
+{
+	/*
+	 * If init_fpstate.xfd has bits set then dynamic features are
+	 * available and the dynamic sizing must be enabled.
+	 */
+	if (init_fpstate.xfd)
+		static_branch_enable(&__fpu_state_size_dynamic);
+	return 0;
+}
+arch_initcall(xfd_update_static_branch)
+
 void fpstate_free(struct fpu *fpu)
 {
-	if (fpu->fpstate || fpu->fpstate != &fpu->__fpstate)
+	if (fpu->fpstate && fpu->fpstate != &fpu->__fpstate)
 		vfree(fpu->fpstate);
 }
 
