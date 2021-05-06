Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065BD375381
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 May 2021 14:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhEFMPM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 May 2021 08:15:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38674 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbhEFMPG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 May 2021 08:15:06 -0400
Date:   Thu, 06 May 2021 12:14:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620303247;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kN5tDD5vXQHItyKRr5OB+VZS5LAJOBnwou1sKeVites=;
        b=vIb9WAUujVNVULfJHmlarxvC6LT+28rbfH++5TzQ8J/2HpekBXThM5ktAzqDwb0BwWCyST
        KsZmPKSYyJ7TjpV0KBdDV6FYPmwfPjgLg8htzp/KjKvIjgmp+nqHNNELOzYQDVuRhA9LJM
        AKu5SW6D4YtS1XSFsOply5Uii9IBL+5YDrO5IXOC0Z1htQBSWDl+ZV2GK41Gom2e9hRjzJ
        BjY2SHMl0OUtcZ3bd3ewLh4Gh6cLf5TyOrA2phEWzVc/TLINBzAY4Vgqu7/1EfxD43+6nC
        FmHsJ5JBRGuG4+7DaLlARlmjt8WJlz0loM1gEGYkPLgStvUJIMQ12LguFnCu+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620303247;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kN5tDD5vXQHItyKRr5OB+VZS5LAJOBnwou1sKeVites=;
        b=XiN8PmDfxupwuyoRgxed+BM/5b7b44RlbdMK2P0SFNOKXuK1JazcbZoXwtwrOCT6deXntc
        pJObUr16GXUijMAw==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Remove write_tsc() and write_rdtscp_aux() wrappers
Cc:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210504225632.1532621-3-seanjc@google.com>
References: <20210504225632.1532621-3-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <162030324666.29796.2683724814193084316.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     fc48a6d1faadbf08b7a840d58a5a6eb85bd1a79a
Gitweb:        https://git.kernel.org/tip/fc48a6d1faadbf08b7a840d58a5a6eb85bd1a79a
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Tue, 04 May 2021 15:56:32 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 05 May 2021 21:50:14 +02:00

x86/cpu: Remove write_tsc() and write_rdtscp_aux() wrappers

Drop write_tsc() and write_rdtscp_aux(); the former has no users, and the
latter has only a single user and is slightly misleading since the only
in-kernel consumer of MSR_TSC_AUX is RDPID, not RDTSCP.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210504225632.1532621-3-seanjc@google.com

---
 arch/x86/include/asm/msr.h   | 4 ----
 arch/x86/kernel/cpu/common.c | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index e16cccd..a3f87f1 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -324,10 +324,6 @@ static inline int wrmsrl_safe(u32 msr, u64 val)
 	return wrmsr_safe(msr, (u32)val,  (u32)(val >> 32));
 }
 
-#define write_tsc(low, high) wrmsr(MSR_IA32_TSC, (low), (high))
-
-#define write_rdtscp_aux(val) wrmsr(MSR_TSC_AUX, (val), 0)
-
 struct msr *msrs_alloc(void);
 void msrs_free(struct msr *msrs);
 int msr_set_bit(u32 msr, u8 bit);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 490bed0..a1b756c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1852,7 +1852,7 @@ static inline void setup_getcpu(int cpu)
 	struct desc_struct d = { };
 
 	if (boot_cpu_has(X86_FEATURE_RDTSCP) || boot_cpu_has(X86_FEATURE_RDPID))
-		write_rdtscp_aux(cpudata);
+		wrmsr(MSR_TSC_AUX, cpudata, 0);
 
 	/* Store CPU and node number in limit. */
 	d.limit0 = cpudata;
