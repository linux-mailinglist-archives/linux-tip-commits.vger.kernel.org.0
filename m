Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7981926F78F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 09:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgIRH6l (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 03:58:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60816 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgIRH6j (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 03:58:39 -0400
Date:   Fri, 18 Sep 2020 07:58:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600415916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJ3nkibF2B/vDoniHLfD0X7Q3rUEgY+JQJTaY4UTSvU=;
        b=TQyvDH0TvTknSOKF93Lnz3y0SKGrY++I8dKHQfJN6OJeHhEBNuDTS9y0PoeI9AxIJhYPIi
        wDMStqfmoujIPYbWm+nNwLJa507mWPUv1UuqsDwI2J6UZoar+lEngmH18YiFA5XdJQo6kZ
        E6286Ypzjmri7DUNfrMiM7ymM8EM+yo6C6RWQTJKIe+0DMdDmaM0M77ev7yJzd733FUMVd
        HcU/e+b76wiZDxtXlT9Sl5mfJBP6Daxlly4+NQnElXwmBeYjhwbkm95COEHXRQQDwodtiM
        kyusFMNSe+2DmaTmueXvOut9h+fl4gJf+mJq1uS4qxttNhoPF8FliHDl+oDfXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600415916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJ3nkibF2B/vDoniHLfD0X7Q3rUEgY+JQJTaY4UTSvU=;
        b=ThhpyMk/2BNb5/YV/BUYoL5sGtOb0aHx9onbVhudAf4ZZ4UOARPoPJkHWjEXHaRt1M0Kkn
        sg3KhYMn9uCNAKCA==
From:   "tip-bot2 for Krish Sadhukhan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Add hardware-enforced cache coherency as a
 CPUID feature
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200917212038.5090-2-krish.sadhukhan@oracle.com>
References: <20200917212038.5090-2-krish.sadhukhan@oracle.com>
MIME-Version: 1.0
Message-ID: <160041591536.15536.9107710778522234278.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     f1f325183519ba25370765607e2732d6edf53de1
Gitweb:        https://git.kernel.org/tip/f1f325183519ba25370765607e2732d6edf53de1
Author:        Krish Sadhukhan <krish.sadhukhan@oracle.com>
AuthorDate:    Thu, 17 Sep 2020 21:20:36 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Sep 2020 09:46:06 +02:00

x86/cpu: Add hardware-enforced cache coherency as a CPUID feature

In some hardware implementations, coherency between the encrypted and
unencrypted mappings of the same physical page is enforced. In such a system,
it is not required for software to flush the page from all CPU caches in the
system prior to changing the value of the C-bit for a page. This hardware-
enforced cache coherency is indicated by EAX[10] in CPUID leaf 0x8000001f.

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200917212038.5090-2-krish.sadhukhan@oracle.com
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 83fc9d3..ba6e8f4 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -288,6 +288,7 @@
 #define X86_FEATURE_FENCE_SWAPGS_USER	(11*32+ 4) /* "" LFENCE in user entry SWAPGS path */
 #define X86_FEATURE_FENCE_SWAPGS_KERNEL	(11*32+ 5) /* "" LFENCE in kernel entry SWAPGS path */
 #define X86_FEATURE_SPLIT_LOCK_DETECT	(11*32+ 6) /* #AC for split lock */
+#define X86_FEATURE_SME_COHERENT	(11*32+ 7) /* "" AMD hardware-enforced cache coherency */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 62b137c..3221b71 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -41,6 +41,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SME,		CPUID_EAX,  0, 0x8000001f, 0 },
 	{ X86_FEATURE_SEV,		CPUID_EAX,  1, 0x8000001f, 0 },
+	{ X86_FEATURE_SME_COHERENT,	CPUID_EAX, 10, 0x8000001f, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
