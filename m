Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7862641A9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Sep 2020 11:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgIJJ0I (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Sep 2020 05:26:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38890 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730140AbgIJJYA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Sep 2020 05:24:00 -0400
Date:   Thu, 10 Sep 2020 09:22:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldllKGn/fQYbCAZeuD89K28PNmawGHqEYumoUxsrlDk=;
        b=kAcUoD4VEXZge3KABb1w0IhnCOFB2hK+3KORXstbD6ufxfe0JVs0ny92HNvxAUP17mm6c+
        EvSb4KvxRY9yRHmfBGl6/X9U1gkTllAe9y7/gcXmvyTHacrQgv82shQKgxF4SNeXFHlfa9
        30Hbkh3kWCGSyNrb99I045/jkcqNos/JL+v3kgtSFQvB4sp+mgUYiKL3ZuR25KRBTlerKL
        Hbi7X+C+AigiqGpvWGzZ2ooAJao15U0Mb2mUMWhPI8nF2VcUK3cI/OCXg7d/+GjJuZxNgw
        DHbc4sG2OjB9itNIeJ7C2zXfVmf7nW9rnFlbC0NNeLCxP+HQYEWWOWqIjE+G1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldllKGn/fQYbCAZeuD89K28PNmawGHqEYumoUxsrlDk=;
        b=f2MgHChCfWKPtRp3Bve0cZkliC8fMOO7/hyVkpLxqLbnMLGTcnomnPBz+vHx93/Q4byyKw
        OXMshA4FGyacgQCQ==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/cpufeatures: Add SEV-ES CPU feature
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-6-joro@8bytes.org>
References: <20200907131613.12703-6-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972975068.20229.9399017352340085405.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     360e7c5c4ca4fd8e627781ed42f95d58bc3bb732
Gitweb:        https://git.kernel.org/tip/360e7c5c4ca4fd8e627781ed42f95d58bc3bb732
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 07 Sep 2020 15:15:06 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 19:45:24 +02:00

x86/cpufeatures: Add SEV-ES CPU feature

Add CPU feature detection for Secure Encrypted Virtualization with
Encrypted State. This feature enhances SEV by also encrypting the
guest register state, making it in-accessible to the hypervisor.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-6-joro@8bytes.org
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/amd.c          | 3 ++-
 arch/x86/kernel/cpu/scattered.c    | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 83fc9d3..1205c1b 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -236,6 +236,7 @@
 #define X86_FEATURE_EPT_AD		( 8*32+17) /* Intel Extended Page Table access-dirty bit */
 #define X86_FEATURE_VMCALL		( 8*32+18) /* "" Hypervisor supports the VMCALL instruction */
 #define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* "" VMware prefers VMMCALL hypercall instruction */
+#define X86_FEATURE_SEV_ES		( 8*32+20) /* AMD Secure Encrypted Virtualization - Encrypted State */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index dcc3d94..6062ce5 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -614,7 +614,7 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 	 *	      If BIOS has not enabled SME then don't advertise the
 	 *	      SME feature (set in scattered.c).
 	 *   For SEV: If BIOS has not enabled SEV then don't advertise the
-	 *            SEV feature (set in scattered.c).
+	 *            SEV and SEV_ES feature (set in scattered.c).
 	 *
 	 *   In all cases, since support for SME and SEV requires long mode,
 	 *   don't advertise the feature under CONFIG_X86_32.
@@ -645,6 +645,7 @@ clear_all:
 		setup_clear_cpu_cap(X86_FEATURE_SME);
 clear_sev:
 		setup_clear_cpu_cap(X86_FEATURE_SEV);
+		setup_clear_cpu_cap(X86_FEATURE_SEV_ES);
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 62b137c..30f3549 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -41,6 +41,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SME,		CPUID_EAX,  0, 0x8000001f, 0 },
 	{ X86_FEATURE_SEV,		CPUID_EAX,  1, 0x8000001f, 0 },
+	{ X86_FEATURE_SEV_ES,		CPUID_EAX,  3, 0x8000001f, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
