Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCD92AF246
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 14:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgKKNgd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 08:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgKKNg1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 08:36:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4521BC0613D1;
        Wed, 11 Nov 2020 05:36:27 -0800 (PST)
Date:   Wed, 11 Nov 2020 13:36:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605101784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KSPhQ2upG2dWWh9XRQLnfBIgg40EYUB+gBorBPYw9p8=;
        b=EvMQfe7uyv97BIdi7N8d4eMLZZZENeNSRPzSfLqaXbvAUE8aeKY5XrFv7WHH0WOEBmPIvY
        gy0x8qq23Z8Jc81jSOwQM1hHyxYX4/AbZocwdqIr6syA0t32K40vCzc1o9wG/6oRkx5yxH
        nXjkgfp9GfhZb9WpPP9m7c9ZZ5MdjAsZmB6is6LknXroc2dzosJjvKoa1ox0eobZESU09y
        WrOsU5gHZlvsXni0gekZC/egBIS/zuRlqCedIav/Oz93qwp0Y2pmEkuV8/rL2SYjXc/V/p
        VX43/Dpsz/uuOcnrs7SdT/U1sDWXNeWAa/l7w7VsaE2Y3+Adbfl1vFFxBawEbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605101784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KSPhQ2upG2dWWh9XRQLnfBIgg40EYUB+gBorBPYw9p8=;
        b=PhW+HszYzxLHcmhHkf6hVslwgvlXFSULz/obB9FzF6sCIRjeDi8QliehMG64iREC8ODQNQ
        G1srLw0QxIN5JkCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Make kernel FPU protection RT friendly
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201027101349.588965083@linutronix.de>
References: <20201027101349.588965083@linutronix.de>
MIME-Version: 1.0
Message-ID: <160510178339.11244.18052705321586947595.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     cba08c5dc6dc1a906a0b5ddac9a9ac6c9a64f2e8
Gitweb:        https://git.kernel.org/tip/cba08c5dc6dc1a906a0b5ddac9a9ac6c9a64f2e8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 27 Oct 2020 11:09:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 11 Nov 2020 14:35:16 +01:00

x86/fpu: Make kernel FPU protection RT friendly

Non RT kernels need to protect FPU against preemption and bottom half
processing. This is achieved by disabling bottom halfs via
local_bh_disable() which implictly disables preemption.

On RT kernels this protection mechanism is not sufficient because
local_bh_disable() does not disable preemption. It serializes bottom half
related processing via a CPU local lock.

As bottom halfs are running always in thread context on RT kernels
disabling preemption is the proper choice as it implicitly prevents bottom
half processing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201027101349.588965083@linutronix.de

---
 arch/x86/include/asm/fpu/api.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 2c5bef7..a5aba4a 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -32,15 +32,29 @@ extern void fpregs_mark_activate(void);
  *
  * local_bh_disable() protects against both preemption and soft interrupts
  * on !RT kernels.
+ *
+ * On RT kernels local_bh_disable() is not sufficient because it only
+ * serializes soft interrupt related sections via a local lock, but stays
+ * preemptible. Disabling preemption is the right choice here as bottom
+ * half processing is always in thread context on RT kernels so it
+ * implicitly prevents bottom half processing as well.
+ *
+ * Disabling preemption also serializes against kernel_fpu_begin().
  */
 static inline void fpregs_lock(void)
 {
-	local_bh_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_disable();
+	else
+		preempt_disable();
 }
 
 static inline void fpregs_unlock(void)
 {
-	local_bh_enable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_enable();
+	else
+		preempt_enable();
 }
 
 #ifdef CONFIG_X86_DEBUG_FPU
