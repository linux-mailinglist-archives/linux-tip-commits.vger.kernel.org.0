Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B8C3B2338
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhFWWMu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhFWWMB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:12:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C99C061760;
        Wed, 23 Jun 2021 15:09:11 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:09:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486150;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTjJIqAFaHCGH5q5DVikqIg+zHskzi2+9/D4zLvhYSM=;
        b=qRvWs+1LqIujbjbH/TtVMg5UbXhhZ1fnUYmzZ87rKS60xHmEoww5sZ753RgCMsfMRdboVe
        u3raQezmTddOw9vNmbcC6pm9Q8/i9dCB1/xsKq3IT6n8jPBZ+kAqJDInHNkGSjlwgnxu33
        x20XdLjesqEAZy19EZZA4lyzVskWj9/pnkdzXDHZcX/pmhy4gq9keS6JBgoqSKSa696peR
        j3uTyHTOckbAboRkZV8XylFsXOIBkmXRYRwFUeK+Ql/YWdRS+K3S2V/8jO56Nrhz0l6b0p
        VdzuCxmTztWFbyXIaViLE3gNhRVvmO1VYQE2Hto3oT0X5Kn8cslomHFgnqcC3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486150;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTjJIqAFaHCGH5q5DVikqIg+zHskzi2+9/D4zLvhYSM=;
        b=y04/it7PKndKBYl842of24IRFVvT+ryp9XDs/KKYmt7JeE7r1ZdXx0wDzbCOSdEGTUZ2iK
        QmMxJFA2L1lksaAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/cpu: Write the default PKRU value when enabling PKE
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121455.622983906@linutronix.de>
References: <20210623121455.622983906@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448614891.395.9514193239716919752.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     fa8c84b77a54bf3cf351c8b4b26a5aca27a14013
Gitweb:        https://git.kernel.org/tip/fa8c84b77a54bf3cf351c8b4b26a5aca27a14013
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:10 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 19:14:54 +02:00

x86/cpu: Write the default PKRU value when enabling PKE

In preparation of making the PKRU management more independent from XSTATES,
write the default PKRU value into the hardware right after enabling PKRU in
CR4. This ensures that switch_to() and copy_thread() have the correct
setting for init task and the per CPU idle threads right away.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121455.622983906@linutronix.de
---
 arch/x86/kernel/cpu/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index dbfb335..ca668ef 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -480,6 +480,8 @@ static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 	}
 
 	cr4_set_bits(X86_CR4_PKE);
+	/* Load the default PKRU value */
+	pkru_write_default();
 }
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
