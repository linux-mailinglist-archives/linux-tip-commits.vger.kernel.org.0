Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B6C2AF23F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 14:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgKKNge (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 08:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgKKNg1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 08:36:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45275C0613D4;
        Wed, 11 Nov 2020 05:36:27 -0800 (PST)
Date:   Wed, 11 Nov 2020 13:36:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605101785;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XC9D+el1FoWHK6clw661OrmDucdSAs01LvaDazMEkM=;
        b=DGMXv9vtd6zj0Wu2nbzOV/Rk/s51rS1zFYCfz4PE1AWexr2iFs0JYjp1LsVJoRp246utqL
        /sHapNsafjrk5X7leA445YQb4r3gFK4vVPMHBzuibks6wpu/2Lq1P2s1KSwnvvISF4xG8I
        g2Tv9LTJAgz/t40DAeEfONuPYIVcHz4s8a1ugEalrNGY572GbfiYoWV7SqunjQXkKh1Agg
        MOkfJxwZaDx+DY3He4kK2dCNFg/UGoNPSXbFh4SC45zT1iVP6Zr5+VTJpHszR/aVNGO2rG
        hJi0Z31b/82acmCCWzSFaCIa87u4e/0+gTlJZLsR/a1AoV0E6dgXFhlNWmY6FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605101785;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XC9D+el1FoWHK6clw661OrmDucdSAs01LvaDazMEkM=;
        b=SGUIHbaT9Z3EFQsraiyGvvaXJsaoubBP2/K3MhDuznkRSl3A8zp3eToB8owS7+BgTlOtTO
        V/NIE4HUnNL2k1BA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Simplify fpregs_[un]lock()
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201027101349.455380473@linutronix.de>
References: <20201027101349.455380473@linutronix.de>
MIME-Version: 1.0
Message-ID: <160510178403.11244.2199301004015376864.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     5f0c71278d6848b4809f83af90f28196e1505ab1
Gitweb:        https://git.kernel.org/tip/5f0c71278d6848b4809f83af90f28196e1505ab1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 27 Oct 2020 11:09:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 11 Nov 2020 14:35:16 +01:00

x86/fpu: Simplify fpregs_[un]lock()

There is no point in disabling preemption and then disabling bottom
halfs.

Just disabling bottom halfs is sufficient as it implicitly disables
preemption on !RT kernels.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201027101349.455380473@linutronix.de

---
 arch/x86/include/asm/fpu/api.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index dcd9503..2c5bef7 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -29,17 +29,18 @@ extern void fpregs_mark_activate(void);
  * A context switch will (and softirq might) save CPU's FPU registers to
  * fpu->state and set TIF_NEED_FPU_LOAD leaving CPU's FPU registers in
  * a random state.
+ *
+ * local_bh_disable() protects against both preemption and soft interrupts
+ * on !RT kernels.
  */
 static inline void fpregs_lock(void)
 {
-	preempt_disable();
 	local_bh_disable();
 }
 
 static inline void fpregs_unlock(void)
 {
 	local_bh_enable();
-	preempt_enable();
 }
 
 #ifdef CONFIG_X86_DEBUG_FPU
