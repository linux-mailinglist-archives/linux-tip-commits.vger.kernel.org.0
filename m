Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B912D3B2343
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbhFWWNN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:13:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39982 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhFWWMK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:12:10 -0400
Date:   Wed, 23 Jun 2021 22:09:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486182;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7k3ri/hV+I/AhDhLiNz2Zu40fmTollIrDV7xEL08iCo=;
        b=Wya0SI/wGTChy4C6fAR8UQOSJmvkTN5alaQHgYHWpA7BrI0PgCRemQ6FU8xH0mc2r41yCE
        2s1yxoxCdmPbh1wP1LQbPs7IKSns85/GXTAgOSK4k11TvD+GdYH+UbwpkNeDATP/19nHv7
        Qw8ag2DTq/TIB9hEMclVxH4vOQ+AYJEtz/LLrLvKxvQfm25CYzKoh8RdP3eXHvgSkpjIe0
        PeDmZqxQoX/HNV9OdPH4eOv+0/+CjdyAOjkNCjbisqFeLxmqni7p997O7cWlrVOhdhLS57
        9fnKKIjE8mlo0NANY6PSN9baP9mnOGcMMcXdVrOG/3AtnOgDf0G8Q7e//kgnWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486182;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7k3ri/hV+I/AhDhLiNz2Zu40fmTollIrDV7xEL08iCo=;
        b=PBspYXuUpGaLBc7jDIIv6Ko/cVX+lIma5fHYHGsz4QC8LMuYalYDh2ZlzaK1uJDO+G+uZz
        sLSFb2JOOmi8wEAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Move inlines where they belong
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121452.023118522@linutronix.de>
References: <20210623121452.023118522@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448618139.395.4058878310733266216.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     e68524456c855e500f0a636adb1aa977e1e0b4d8
Gitweb:        https://git.kernel.org/tip/e68524456c855e500f0a636adb1aa977e1e0b4d8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:34 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:49:46 +02:00

x86/fpu: Move inlines where they belong

They are only used in fpstate_init() and there is no point to have them in
a header just to make reading the code harder.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121452.023118522@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 14 --------------
 arch/x86/kernel/fpu/core.c          | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 58f2082..9ed9846 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -86,20 +86,6 @@ extern void fpstate_init_soft(struct swregs_state *soft);
 static inline void fpstate_init_soft(struct swregs_state *soft) {}
 #endif
 
-static inline void fpstate_init_xstate(struct xregs_state *xsave)
-{
-	/*
-	 * XRSTORS requires these bits set in xcomp_bv, or it will
-	 * trigger #GP:
-	 */
-	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask_all;
-}
-
-static inline void fpstate_init_fxstate(struct fxregs_state *fx)
-{
-	fx->cwd = 0x37f;
-	fx->mxcsr = MXCSR_DEFAULT;
-}
 extern void fpstate_sanitize_xstate(struct fpu *fpu);
 
 #define user_insn(insn, output, input...)				\
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 571220a..9ff467b 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -181,6 +181,21 @@ void fpu__save(struct fpu *fpu)
 	fpregs_unlock();
 }
 
+static inline void fpstate_init_xstate(struct xregs_state *xsave)
+{
+	/*
+	 * XRSTORS requires these bits set in xcomp_bv, or it will
+	 * trigger #GP:
+	 */
+	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask_all;
+}
+
+static inline void fpstate_init_fxstate(struct fxregs_state *fx)
+{
+	fx->cwd = 0x37f;
+	fx->mxcsr = MXCSR_DEFAULT;
+}
+
 /*
  * Legacy x87 fpstate state init:
  */
