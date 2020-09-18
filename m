Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731F326F73D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 09:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgIRHmx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 03:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgIRHmg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 03:42:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA13C061788;
        Fri, 18 Sep 2020 00:42:35 -0700 (PDT)
Date:   Fri, 18 Sep 2020 07:42:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600414953;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K4+qqmw7hrGFJ24yh49ctzeVP8vWtjYon40QZ3veTog=;
        b=0hmfojkAXoY2fSiPPcsVTndn4MghIoFx2N+R0lESd8tMcw+IT+B55ZhuGYda7ttodw4LqX
        EYU03ZThAee0yJp7qdT4zvU1xicpGSw+oM2vZFc3CwruA/WSu8tGdY/I9R974hhx173E48
        11fX61jPhr5/sGPsqby37hWmpVYyxbSKNiUAPReeijkEN18iGk7E8S8RucoDH3yD74bujF
        D7pUmp7UWAGMyGCsPricwQlwypQrQnkrJxwi4z0ERKwOrTvqey395zXvE3S0A6c/UNjjRX
        bhlBXycB9S4H3jcovqc2i84mGPFH8BMog1T33Jhi+wjOtnBYYe+zPrJR6twRsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600414953;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K4+qqmw7hrGFJ24yh49ctzeVP8vWtjYon40QZ3veTog=;
        b=ooNzcPEHtE641wKuG6++iekXW/EmtF7wMbOnQAoK0cA8Yw63325PPmydZ8eem2bSry5lnF
        eQkdsL2ncI+9d6BA==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pasid] x86/cpufeatures: Enumerate ENQCMD and ENQCMDS instructions
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1600187413-163670-5-git-send-email-fenghua.yu@intel.com>
References: <1600187413-163670-5-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <160041495232.15536.3125228947449715394.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/pasid branch of tip:

Commit-ID:     ff4f82816dff28ffaaff96d1409bb3811d345514
Gitweb:        https://git.kernel.org/tip/ff4f82816dff28ffaaff96d1409bb3811d345514
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Tue, 15 Sep 2020 09:30:08 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 17 Sep 2020 20:03:54 +02:00

x86/cpufeatures: Enumerate ENQCMD and ENQCMDS instructions

Work submission instruction comes in two flavors. ENQCMD can be called
both in ring 3 and ring 0 and always uses the contents of a PASID MSR
when shipping the command to the device. ENQCMDS allows a kernel driver
to submit commands on behalf of a user process. The driver supplies the
PASID value in ENQCMDS. There isn't any usage of ENQCMD in the kernel as
of now.

The CPU feature flag is shown as "enqcmd" in /proc/cpuinfo.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/1600187413-163670-5-git-send-email-fenghua.yu@intel.com
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 2901d5d..fea10d0 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -353,6 +353,7 @@
 #define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
 #define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
 #define X86_FEATURE_MOVDIR64B		(16*32+28) /* MOVDIR64B instruction */
+#define X86_FEATURE_ENQCMD		(16*32+29) /* ENQCMD and ENQCMDS instructions */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 3cbe24c..3a02707 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -69,6 +69,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_CQM_MBM_TOTAL,		X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
+	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
 	{}
 };
 
