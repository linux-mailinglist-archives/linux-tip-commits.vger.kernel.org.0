Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5192D8DBC
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 15:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgLMOGQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 09:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394910AbgLMOF7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 09:05:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E631C0613D3;
        Sun, 13 Dec 2020 06:05:19 -0800 (PST)
Date:   Sun, 13 Dec 2020 14:05:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607868317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=oUrdT9QMUmCx2ZW1P0csOGdxKgb+L3ZEsEgXVhnO+tA=;
        b=BKwGtqbA712T6FhmIC0LlNj2j0TyYSMj2A1A5xBg3Xkg5qrlhWY7pJSuw/CYboQoirdhpN
        uT3OmXt2Fs9VmK+cxXT2st5H2x4ZTbGKS8d2mHfX1LFvB92BzKd/n2M2/2E4ChevG3aryZ
        4X1s7AODXREAzbB5RWFa20eUdjH1W8Az02BYaKL/pIqEsqYvSPQ31Fs2dvsfAiKqVg/6bm
        M6LRRINXtnzsBK8tn0IpruT6PaYclN6JqY6DE0qJb2mh+fYPZXLGbPdjHjVzUq3siLp/Fv
        t0dn/+GCm0Xk6FStAZreFCkjDEW/UlpbLR6kn1rS99vqh77mdYlVi0ySczzi4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607868317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=oUrdT9QMUmCx2ZW1P0csOGdxKgb+L3ZEsEgXVhnO+tA=;
        b=D0fr90tdulxWxMR6EUV+mIAqgqznUz6PXt7LrUpBWmXEstKnv7FhfKlyT1nmw1kF1stblE
        wHbKaoBqqDGW30Dw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Reexport irq_to_desc() for PPC KVM
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
MIME-Version: 1.0
Message-ID: <160786831574.3364.1303776836725071487.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3bda84519c6c2d57e7378417ac116f61d50abae1
Gitweb:        https://git.kernel.org/tip/3bda84519c6c2d57e7378417ac116f61d50abae1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 13 Dec 2020 14:33:57 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 13 Dec 2020 14:58:44 +01:00

genirq: Reexport irq_to_desc() for PPC KVM

Commit f07147b162a1 ("genirq: Remove export of irq_to_desc()") breaks the
PPC - CONFIG_KVM_BOOK3S_64_HV=n build because the analysis of irq_to_desc()
usage missed that the creative fiddling in arch/powerpc/kvm/ is actually in
a module and not in built in code. The only real purpose is to access
irq_desc::kstat_irqs which can be solved differently, but not without some
surgery.

Reexport it when KVM_BOOK3S_64_HV is enabled. That means that all other
modular code especially drivers/* cannot rely on it, which was the whole
point of the exercise.

Fixes: f07147b162a1 ("genirq: Remove export of irq_to_desc()")
Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 kernel/irq/irqdesc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 5d766f4..0e1f89d 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -352,6 +352,9 @@ struct irq_desc *irq_to_desc(unsigned int irq)
 {
 	return radix_tree_lookup(&irq_desc_tree, irq);
 }
+#ifdef CONFIG_KVM_BOOK3S_64_HV
+EXPORT_SYMBOL_GPL(irq_to_desc);
+#endif
 
 static void delete_irq_desc(unsigned int irq)
 {
