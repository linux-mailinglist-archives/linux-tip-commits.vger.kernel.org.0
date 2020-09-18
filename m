Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5860B26F8E0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 11:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgIRJD3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 05:03:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33082 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIRJD2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 05:03:28 -0400
Date:   Fri, 18 Sep 2020 09:03:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600419805;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BMIsdipQFi70xHYIMGSIjEONwqcN3WIsR/VI+eP1OHQ=;
        b=scQNw6SrTac8vmEKWqRrxiQTc02tTEOgxCjFfIteRMwomyK4cXEM9SiPSM69uo7jLfyghe
        K+BfeKEb6TTWYk0tQyUwcItthNcx23mI6jTETNSkNEl5OTLU6li7IysgLnQriRH+D66kKH
        WsPP+C+G4CTqSE18M2guV+8tFtJd/hbV88S2U7m2+zYYkxGAzQZtkNqfat3ghqjhZsllhe
        1BM6M75CYrBzPZxXZClGPK80WUgShHj9eF1wJFOuG5aKZ387NXUfvlXpHyWZo4aSQgSYb9
        Du6hJViMe0kfwULDKOd4d8hUq1ox0aDUlo/O1uQOAq5SVwzVB5CHvEL/CwjAXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600419805;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BMIsdipQFi70xHYIMGSIjEONwqcN3WIsR/VI+eP1OHQ=;
        b=4lpTiAtY8KQ+L9n3HGdmVks3qpt90/oa6BhpRMAy6SPgwTrlegJpdvQ5pNZ3hbsuZO0TT6
        F/RSxb5rqiSACXCQ==
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
Message-ID: <160041980522.15536.7919433093725831191.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     5866e9205b47a983a77ebc8654949f696342f2ab
Gitweb:        https://git.kernel.org/tip/5866e9205b47a983a77ebc8654949f696342f2ab
Author:        Krish Sadhukhan <krish.sadhukhan@oracle.com>
AuthorDate:    Thu, 17 Sep 2020 21:20:36 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Sep 2020 10:46:41 +02:00

x86/cpu: Add hardware-enforced cache coherency as a CPUID feature

In some hardware implementations, coherency between the encrypted and
unencrypted mappings of the same physical page is enforced. In such a system,
it is not required for software to flush the page from all CPU caches in the
system prior to changing the value of the C-bit for a page. This hardware-
enforced cache coherency is indicated by EAX[10] in CPUID leaf 0x8000001f.

 [ bp: Use one of the free slots in word 3. ]

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200917212038.5090-2-krish.sadhukhan@oracle.com
---
 arch/x86/include/asm/cpufeatures.h | 2 +-
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 83fc9d3..50b2a8d 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -96,7 +96,7 @@
 #define X86_FEATURE_SYSCALL32		( 3*32+14) /* "" syscall in IA32 userspace */
 #define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 userspace */
 #define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
-/* free					( 3*32+17) */
+#define X86_FEATURE_SME_COHERENT	( 3*32+17) /* "" AMD hardware-enforced cache coherency */
 #define X86_FEATURE_LFENCE_RDTSC	( 3*32+18) /* "" LFENCE synchronizes RDTSC */
 #define X86_FEATURE_ACC_POWER		( 3*32+19) /* AMD Accumulated Power Mechanism */
 #define X86_FEATURE_NOPL		( 3*32+20) /* The NOPL (0F 1F) instructions */
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
 
