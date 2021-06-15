Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52DD3A8744
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Jun 2021 19:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFORQo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 15 Jun 2021 13:16:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34892 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhFORQn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 15 Jun 2021 13:16:43 -0400
Date:   Tue, 15 Jun 2021 17:14:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623777278;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EN44rp/l+iTpLRWA/25WHboruwRmJr4ZupLdHzInMw0=;
        b=eL+2RYn1+yPVqpGRCTcdLKuEDRBKwuscj8VY/Y8sfOlGFSM0AhcAG4njep9biI6oaZdnQO
        tfr/D8Y00P/Uc0uQFY03C2z9Z6vE4GEFDNCA3LZQqnyWYByC880VyrLiIZJ6jX/BJ3X9Gt
        x0cB+lNMtoWDZwIMMZEbyt5stgNq3jmjguArTLrNq2HhSM/TM6aIqzTNK0DXoc9Q9T/izO
        d3D9N4zPtRFJZIGmXjyPj3ZViO38L/JMZKed8i56ISimIcpJhynfxAyml0Yb59w/jsIEdz
        aAMdIYrDoUFmMUP80FhBlc6yvxxLttDBSS/qxGORv44NpUBz/HHePzUgf0/krw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623777278;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EN44rp/l+iTpLRWA/25WHboruwRmJr4ZupLdHzInMw0=;
        b=sIFfBjrQKDAjzVjunwy3tX7DaN532tJLgoEm1hMqinwnvVmUpyV6YZ9jH1NH/hjjqIl3U4
        TClpEdEaJsYP+oBQ==
From:   "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/msr: Define new bits in TSX_FORCE_ABORT MSR
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Neelima Krishnan <neelima.krishnan@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C9add61915b4a4eedad74fbd869107863a28b428e=2E16237?=
 =?utf-8?q?04845=2Egit-series=2Epawan=2Ekumar=2Egupta=40linux=2Eintel=2Eco?=
 =?utf-8?q?m=3E?=
References: =?utf-8?q?=3C9add61915b4a4eedad74fbd869107863a28b428e=2E162370?=
 =?utf-8?q?4845=2Egit-series=2Epawan=2Ekumar=2Egupta=40linux=2Eintel=2Ecom?=
 =?utf-8?q?=3E?=
MIME-Version: 1.0
Message-ID: <162377727757.19906.3940302915932711819.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     1348924ba8169f35cedfd0a0087872b81a632b8e
Gitweb:        https://git.kernel.org/tip/1348924ba8169f35cedfd0a0087872b81a632b8e
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Mon, 14 Jun 2021 14:12:22 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 15 Jun 2021 17:23:15 +02:00

x86/msr: Define new bits in TSX_FORCE_ABORT MSR

Intel client processors that support the IA32_TSX_FORCE_ABORT MSR
related to perf counter interaction [1] received a microcode update that
deprecates the Transactional Synchronization Extension (TSX) feature.
The bit FORCE_ABORT_RTM now defaults to 1, writes to this bit are
ignored. A new bit TSX_CPUID_CLEAR clears the TSX related CPUID bits.

The summary of changes to the IA32_TSX_FORCE_ABORT MSR are:

  Bit 0: FORCE_ABORT_RTM (legacy bit, new default=1) Status bit that
  indicates if RTM transactions are always aborted. This bit is
  essentially !SDV_ENABLE_RTM(Bit 2). Writes to this bit are ignored.

  Bit 1: TSX_CPUID_CLEAR (new bit, default=0) When set, CPUID.HLE = 0
  and CPUID.RTM = 0.

  Bit 2: SDV_ENABLE_RTM (new bit, default=0) When clear, XBEGIN will
  always abort with EAX code 0. When set, XBEGIN will not be forced to
  abort (but will always abort in SGX enclaves). This bit is intended to
  be used on developer systems. If this bit is set, transactional
  atomicity correctness is not certain. SDV = Software Development
  Vehicle (SDV), i.e. developer systems.

Performance monitoring counter 3 is usable in all cases, regardless of
the value of above bits.

Add support for a new CPUID bit - CPUID.RTM_ALWAYS_ABORT (CPUID 7.EDX[11])
 - to indicate the status of always abort behavior.

[1] [ bp: Look for document ID 604224, "Performance Monitoring Impact
      of Intel Transactional Synchronization Extension Memory". Since
      there's no way for us to have stable links to documents... ]

 [ bp: Massage and extend commit message. ]

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Neelima Krishnan <neelima.krishnan@intel.com>
Link: https://lkml.kernel.org/r/9add61915b4a4eedad74fbd869107863a28b428e.1623704845.git-series.pawan.kumar.gupta@linux.intel.com
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/include/asm/msr-index.h   | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 81269c7..d0ce5cf 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -378,6 +378,7 @@
 #define X86_FEATURE_AVX512_VP2INTERSECT (18*32+ 8) /* AVX-512 Intersect for D/Q */
 #define X86_FEATURE_SRBDS_CTRL		(18*32+ 9) /* "" SRBDS mitigation MSR available */
 #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
+#define X86_FEATURE_RTM_ALWAYS_ABORT	(18*32+11) /* "" RTM transaction always aborts */
 #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
 #define X86_FEATURE_SERIALIZE		(18*32+14) /* SERIALIZE instruction */
 #define X86_FEATURE_HYBRID_CPU		(18*32+15) /* "" This part has CPUs of more than one type */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 742d89a..2bc1600 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -772,6 +772,10 @@
 
 #define MSR_TFA_RTM_FORCE_ABORT_BIT	0
 #define MSR_TFA_RTM_FORCE_ABORT		BIT_ULL(MSR_TFA_RTM_FORCE_ABORT_BIT)
+#define MSR_TFA_TSX_CPUID_CLEAR_BIT	1
+#define MSR_TFA_TSX_CPUID_CLEAR		BIT_ULL(MSR_TFA_TSX_CPUID_CLEAR_BIT)
+#define MSR_TFA_SDV_ENABLE_RTM_BIT	2
+#define MSR_TFA_SDV_ENABLE_RTM		BIT_ULL(MSR_TFA_SDV_ENABLE_RTM_BIT)
 
 /* P4/Xeon+ specific */
 #define MSR_IA32_MCG_EAX		0x00000180
