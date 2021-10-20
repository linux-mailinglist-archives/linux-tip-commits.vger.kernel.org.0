Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A521434C57
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhJTNqt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:46:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52936 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhJTNqr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:46:47 -0400
Date:   Wed, 20 Oct 2021 13:44:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737471;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wJA1uHrCM0nfQVsRvjSv6PS+xCR4iUeUzVHgMrxugRQ=;
        b=03bShxJuKGnhzWsTvhw3rprzz9qKDEEbVx2TFasGy5eMvXONTm11edYmoMaEbR+UwPtLNU
        rd8tyZWkuJWWAnejEbvu+vXbwbjvRUBPdHJfXJuETQGmaJAP3OdAVpS5woqbEzXe74dSVw
        3oHk4lrDlGzQU1fsk9gP9JWuC+PCDXtBaEb29yvP/lmwtdyvQvrfU3bn+OnQzYf/XB20Ae
        a2LWRlH6sr6jj5nnJ6LY1CEBoLEIHXdd/5p0oc/RrgHC392/8nT+mRsPnAbZN/X2grePO0
        PQxMenqR4MfaifjlDOryMNRDN8YeotmWl4d3miD+WvUJUwjOCzf9PflKmDSyjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737471;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wJA1uHrCM0nfQVsRvjSv6PS+xCR4iUeUzVHgMrxugRQ=;
        b=O5rCEb8idUxA+8zFSlIKVznUzYYRuVleveuqaioXIeWzXDyBPNqu6aGZx6pY5ROXXDtllp
        q+WZ5FQVBgGAUCAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Move fpstate functions to api.h
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011539.792363754@linutronix.de>
References: <20211015011539.792363754@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473747073.25758.934939590563455411.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     90489f1dee8b703a3301857917c0aba0b22b5d83
Gitweb:        https://git.kernel.org/tip/90489f1dee8b703a3301857917c0aba0b22b5d83
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:33 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:28 +02:00

x86/fpu: Move fpstate functions to api.h

Move function declarations which need to be globally available to api.h
where they belong.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011539.792363754@linutronix.de
---
 arch/x86/include/asm/fpu/api.h      |  9 +++++++++
 arch/x86/include/asm/fpu/internal.h |  9 ---------
 arch/x86/kernel/fpu/internal.h      |  3 +++
 arch/x86/math-emu/fpu_entry.c       |  2 +-
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 77a732e..56cf884 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -110,6 +110,15 @@ extern int cpu_has_xfeatures(u64 xfeatures_mask, const char **feature_name);
 
 static inline void update_pasid(void) { }
 
+#ifdef CONFIG_MATH_EMULATION
+extern void fpstate_init_soft(struct swregs_state *soft);
+#else
+static inline void fpstate_init_soft(struct swregs_state *soft) {}
+#endif
+
+/* fpstate */
+extern union fpregs_state init_fpstate;
+
 /* fpstate-related functions which are exported to KVM */
 extern void fpu_init_fpstate_user(struct fpu *fpu);
 
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 74b7cc3..d8bb491 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -42,15 +42,6 @@ extern void fpu__init_system(struct cpuinfo_x86 *c);
 extern void fpu__init_check_bugs(void);
 extern void fpu__resume_cpu(void);
 
-extern union fpregs_state init_fpstate;
-extern void fpstate_init_user(union fpregs_state *state);
-
-#ifdef CONFIG_MATH_EMULATION
-extern void fpstate_init_soft(struct swregs_state *soft);
-#else
-static inline void fpstate_init_soft(struct swregs_state *soft) {}
-#endif
-
 extern void restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask);
 
 extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
diff --git a/arch/x86/kernel/fpu/internal.h b/arch/x86/kernel/fpu/internal.h
index 5ddc09e..bd7f813 100644
--- a/arch/x86/kernel/fpu/internal.h
+++ b/arch/x86/kernel/fpu/internal.h
@@ -22,4 +22,7 @@ static __always_inline __pure bool use_fxsr(void)
 /* Init functions */
 extern void fpu__init_prepare_fx_sw_frame(void);
 
+/* Used in init.c */
+extern void fpstate_init_user(union fpregs_state *state);
+
 #endif
diff --git a/arch/x86/math-emu/fpu_entry.c b/arch/x86/math-emu/fpu_entry.c
index 8679a9d..50195e2 100644
--- a/arch/x86/math-emu/fpu_entry.c
+++ b/arch/x86/math-emu/fpu_entry.c
@@ -31,7 +31,7 @@
 #include <linux/uaccess.h>
 #include <asm/traps.h>
 #include <asm/user.h>
-#include <asm/fpu/internal.h>
+#include <asm/fpu/api.h>
 
 #include "fpu_system.h"
 #include "fpu_emu.h"
