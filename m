Return-Path: <linux-tip-commits+bounces-2377-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAA199461E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 13:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6AE91F27BA7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 11:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E751DED47;
	Tue,  8 Oct 2024 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hujka5Vi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eVL3P/dd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245D61DE2DA;
	Tue,  8 Oct 2024 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385521; cv=none; b=B0KUSY2eMbtnzawGHKPF2YHg4V+PgMlIx4lEwVjprTWsnQQkF3g/TzUEecw/QJSY8iDYNioOvtzJ8qEaFzcaWtMtY902M821fV/T/SZkeUqAG/gvED3sUtJ8v3xfSsPm5DVKU4lk4VD1iFcbbGwP5eSDv0+TrX66yB3TuA1XDJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385521; c=relaxed/simple;
	bh=UYxnDy5SrW4M94RVCYzZWm58u/RDnSF8aplwBXeJM1Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X/wizRxaqqY2kWWjb1yYaGnfLfOAF8XpmNZHRtezicjdeVIJh08m2gSBDro1uCNbvyRlDOQsiWA2y73BBf2Fo/oNnjoWYvY7sSjcWNR5t/B0HMtnRbwhkRVMk1E7+oJamk1acJFXx19YqlRk+lxSz7S7b52mqJDso3D0v/KXxhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hujka5Vi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eVL3P/dd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 11:05:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728385518;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bS2I3gdor9KxZgncBvqqdP7Yvmq4nvWbFv8wK3vN9DU=;
	b=hujka5Vij/sKo0jH9xLI+jyQIu8f/cMtpSNtaI5ai+bEuuNTNvP2mMSUADMh5jOr78w9s0
	OneT5d+fDfOQWwVAm7triQtW6MDxK1aM547wtqr6i3+a987WV8+bwYBxodv0kDjFXuBKfX
	YzAB9ovoeiHMJduJR6WcuyXqWpKsl8PHgwBOAXTJmZk4VqxU3jfTFHVYtwl4wqelQEUtK7
	PoClmOf9hGkpe+ie+JeBgUl3BqVxAQ39+ottkRasN4m4GUHQiGFNs18evWPkJ+wIth6ETs
	ZYcpU1ihAoxQVt8wiLFB07L7qnQRIwJdatBC9H2fX1xc0lX3GfhsJUB8LFKHqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728385518;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bS2I3gdor9KxZgncBvqqdP7Yvmq4nvWbFv8wK3vN9DU=;
	b=eVL3P/ddI0IKDiQkvu5Yc8nQr+ztrobaUduTjL6ids43znyjCYKiVdWU5/NoiL9t8YBesN
	oE0ocASkpucU44DQ==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] x86/cpu/intel: Define helper to get CPU core native ID
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820073853.1974746-3-dapeng1.mi@linux.intel.com>
References: <20240820073853.1974746-3-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172838551802.1442.7441587367876951681.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2eb2802a41a222bf8d78a88f193ce665071c869e
Gitweb:        https://git.kernel.org/tip/2eb2802a41a222bf8d78a88f193ce665071c869e
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Tue, 20 Aug 2024 07:38:51 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:43 +02:00

x86/cpu/intel: Define helper to get CPU core native ID

Define helper get_this_hybrid_cpu_native_id() to return the CPU core
native ID. This core native ID combining with core type can be used to
figure out the CPU core uarch uniquely.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Link: https://lkml.kernel.org/r/20240820073853.1974746-3-dapeng1.mi@linux.intel.com
---
 arch/x86/include/asm/cpu.h  |  6 ++++++
 arch/x86/kernel/cpu/intel.c | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index aa30fd8..5af69b5 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -32,6 +32,7 @@ extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
 extern bool handle_guest_split_lock(unsigned long ip);
 extern void handle_bus_lock(struct pt_regs *regs);
 u8 get_this_hybrid_cpu_type(void);
+u32 get_this_hybrid_cpu_native_id(void);
 #else
 static inline void __init sld_setup(struct cpuinfo_x86 *c) {}
 static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
@@ -50,6 +51,11 @@ static inline u8 get_this_hybrid_cpu_type(void)
 {
 	return 0;
 }
+
+static inline u32 get_this_hybrid_cpu_native_id(void)
+{
+	return 0;
+}
 #endif
 #ifdef CONFIG_IA32_FEAT_CTL
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index e7656cb..624397e 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1299,3 +1299,18 @@ u8 get_this_hybrid_cpu_type(void)
 
 	return cpuid_eax(0x0000001a) >> X86_HYBRID_CPU_TYPE_ID_SHIFT;
 }
+
+/**
+ * get_this_hybrid_cpu_native_id() - Get the native id of this hybrid CPU
+ *
+ * Returns the uarch native ID [23:0] of a CPU in a hybrid processor.
+ * If the processor is not hybrid, returns 0.
+ */
+u32 get_this_hybrid_cpu_native_id(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
+		return 0;
+
+	return cpuid_eax(0x0000001a) &
+	       (BIT_ULL(X86_HYBRID_CPU_TYPE_ID_SHIFT) - 1);
+}

