Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346003656A0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhDTKr1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51694 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhDTKrW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:22 -0400
Date:   Tue, 20 Apr 2021 10:46:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JpJ7/wcH9ZqAF27R9awa1mYM2q2vmr+TnLqlhpiVPhg=;
        b=GCqDvzsXz1XC5AT8Iq3DaPhxhrF2prmlI3sdJ7NIWKcQxRw8ydMbRVAtH16Epf4rStzD8v
        /5SVAilS/uL1JWmJqFmBrNitoNaVBDQddKDe914YFx5vz4hSJzvZ5uxV+XcGL0ODX2hGNS
        KQMyQEM2fBHODDqWwj9GNaMrijP1dVbEkwBePE3I/JAiq6Cd8tSk61PYw3bsojm5vtkgCG
        yk/77eywq/X/mOgkC1T8hoypwsycA01jqpoI79LNhCdLEjv/ntJlcEll+EFt+ZtGvvlqdh
        /kR0uw+WVeiV6VLF5fEYV4ijuhylQp2aZm6xY1RwjSMe+cT+vUamzdfc4KF6eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JpJ7/wcH9ZqAF27R9awa1mYM2q2vmr+TnLqlhpiVPhg=;
        b=xJLUrXnzhrpu2lnSOGCfmj+WxtzqV+lpqBHfF1tF9UPtLkERcRU4QaKCltITZSy428EQlr
        P70+2vRkWqb0c3Dg==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/cpu: Add helper function to get the type of the
 current hybrid CPU
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-3-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560955.29796.10811256921836669612.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     250b3c0d79d1f4a55e54d8a9ef48058660483fef
Gitweb:        https://git.kernel.org/tip/250b3c0d79d1f4a55e54d8a9ef48058660483fef
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:30:42 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:23 +02:00

x86/cpu: Add helper function to get the type of the current hybrid CPU

On processors with Intel Hybrid Technology (i.e., one having more than
one type of CPU in the same package), all CPUs support the same
instruction set and enumerate the same features on CPUID. Thus, all
software can run on any CPU without restrictions. However, there may be
model-specific differences among types of CPUs. For instance, each type
of CPU may support a different number of performance counters. Also,
machine check error banks may be wired differently. Even though most
software will not care about these differences, kernel subsystems
dealing with these differences must know.

Add and expose a new helper function get_this_hybrid_cpu_type() to query
the type of the current hybrid CPU. The function will be used later in
the perf subsystem.

The Intel Software Developer's Manual defines the CPU type as 8-bit
identifier.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Acked-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/1618237865-33448-3-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/include/asm/cpu.h  |  6 ++++++
 arch/x86/kernel/cpu/intel.c | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index da78ccb..610905d 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -45,6 +45,7 @@ extern void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c);
 extern void switch_to_sld(unsigned long tifn);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
 extern bool handle_guest_split_lock(unsigned long ip);
+u8 get_this_hybrid_cpu_type(void);
 #else
 static inline void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c) {}
 static inline void switch_to_sld(unsigned long tifn) {}
@@ -57,6 +58,11 @@ static inline bool handle_guest_split_lock(unsigned long ip)
 {
 	return false;
 }
+
+static inline u8 get_this_hybrid_cpu_type(void)
+{
+	return 0;
+}
 #endif
 #ifdef CONFIG_IA32_FEAT_CTL
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 0e422a5..26fb626 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1195,3 +1195,19 @@ void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
 	cpu_model_supports_sld = true;
 	split_lock_setup();
 }
+
+#define X86_HYBRID_CPU_TYPE_ID_SHIFT	24
+
+/**
+ * get_this_hybrid_cpu_type() - Get the type of this hybrid CPU
+ *
+ * Returns the CPU type [31:24] (i.e., Atom or Core) of a CPU in
+ * a hybrid processor. If the processor is not hybrid, returns 0.
+ */
+u8 get_this_hybrid_cpu_type(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
+		return 0;
+
+	return cpuid_eax(0x0000001a) >> X86_HYBRID_CPU_TYPE_ID_SHIFT;
+}
