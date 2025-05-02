Return-Path: <linux-tip-commits+bounces-5161-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AF5AA6D92
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 11:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18D19C6830
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 09:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E82722DF97;
	Fri,  2 May 2025 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NEwKl9rd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lBHu7CwX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646913AA2E;
	Fri,  2 May 2025 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176664; cv=none; b=oZonZp4Vsia8pJXUn+4HGQ9ioxKQdd8GW0xVbw7hY4qSo01NA6OI0oGbX3W95WoyDqbTHkl1W0woCYAi3fBXmcvIMRygjD/CPAY75FdYWqilZPFo8iQ8Morh09LCRB4mg13nXgilbusdlqFrIwr/0Bny9FgkKpC8VedsxlAtZXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176664; c=relaxed/simple;
	bh=bwV5csuXMnqI4Pam72gE2jzZyJLOt/+IpkYzF4NyfOE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Jv8DbwvdSm7SEWA27/F7xizbuys8u3jRQpJXKK0JtBap7V7uiI7a7nkK9txHvQDK+MfeN5XPtEM4fXL5gCSMzwDheDmhHiyDc5VmJLq7vd6sGEdcqspNr84XXJiKR/pNYvPx/5IyL8V5s4+xN7ZInYtN8qEwwTZCiytXwg1Rsvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NEwKl9rd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lBHu7CwX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 09:04:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746176658;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INGVsNBb1BADwMoqqtCuoyyEAzGmahySBeQenCsYg94=;
	b=NEwKl9rdguxLkZwsRYrzczKm6BC3G+spiXlubrLuKzX8x/V90rxcAN0EbHSkKn7MQLOfbK
	DejF6xoNLrpgJXEd14LB/XfRKrWWU5Lii3ncUP2/oSGY/M0pxzaY6ZTsfS0uUy+x2dEVsY
	dLbXA+YvUfB/i5L7HUAxR5QGO8v8KIwnE2SmqhgtlGif1dCBYZlRvOQCALmqKysm1eoC0t
	6vrfZzbsKMTtH2LSrcKm7CFbdLC1qltNXb51K1590+XyObBtZfRH1hiQnhxXt4MYTBiWAB
	D/pgwNM5uW8mEWRkyNTMcZ8n7AvawzA4ArzAanZMbtaStTQqt16gN3mkqKwPfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746176658;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INGVsNBb1BADwMoqqtCuoyyEAzGmahySBeQenCsYg94=;
	b=lBHu7CwXuheEp4lFZ3Dnve35XsxoXV8+N+RKF8W9OlytMvWY9DZ/c1OFTOhH+RPsXQdKlI
	9IsnKgLkHDHJZfBQ==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/merge] x86/msr: Change the function type of native_read_msr_safe()
Cc: "Xin Li (Intel)" <xin@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250427092027.1598740-16-xin@zytor.com>
References: <20250427092027.1598740-16-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174617665306.22196.9443417057136673504.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     502ad6e5a6196840976c4c84b2ea2f9769942fbe
Gitweb:        https://git.kernel.org/tip/502ad6e5a6196840976c4c84b2ea2f9769942fbe
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Sun, 27 Apr 2025 02:20:27 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 May 2025 10:36:36 +02:00

x86/msr: Change the function type of native_read_msr_safe()

Modify the function type of native_read_msr_safe() to:

    int native_read_msr_safe(u32 msr, u64 *val)

This change makes the function return an error code instead of the
MSR value, aligning it with the type of native_write_msr_safe().
Consequently, their callers can check the results in the same way.

While at it, convert leftover MSR data type "unsigned int" to u32.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20250427092027.1598740-16-xin@zytor.com
---
 arch/x86/include/asm/msr.h            | 21 +++++++++++----------
 arch/x86/include/asm/paravirt.h       | 19 ++++++++-----------
 arch/x86/include/asm/paravirt_types.h |  6 +++---
 arch/x86/kvm/svm/svm.c                | 19 +++++++------------
 arch/x86/xen/enlighten_pv.c           | 13 ++++++++-----
 arch/x86/xen/pmu.c                    | 14 ++++++++------
 6 files changed, 45 insertions(+), 47 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index b244076..a9ce56f 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -113,18 +113,22 @@ static inline u64 native_read_msr(u32 msr)
 	return val;
 }
 
-static inline u64 native_read_msr_safe(u32 msr, int *err)
+static inline int native_read_msr_safe(u32 msr, u64 *p)
 {
+	int err;
 	EAX_EDX_DECLARE_ARGS(val, low, high);
 
 	asm volatile("1: rdmsr ; xor %[err],%[err]\n"
 		     "2:\n\t"
 		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_RDMSR_SAFE, %[err])
-		     : [err] "=r" (*err), EAX_EDX_RET(val, low, high)
+		     : [err] "=r" (err), EAX_EDX_RET(val, low, high)
 		     : "c" (msr));
 	if (tracepoint_enabled(read_msr))
-		do_trace_read_msr(msr, EAX_EDX_VAL(val, low, high), *err);
-	return EAX_EDX_VAL(val, low, high);
+		do_trace_read_msr(msr, EAX_EDX_VAL(val, low, high), err);
+
+	*p = EAX_EDX_VAL(val, low, high);
+
+	return err;
 }
 
 /* Can be uninlined because referenced by paravirt */
@@ -204,8 +208,8 @@ static inline int wrmsrq_safe(u32 msr, u64 val)
 /* rdmsr with exception handling */
 #define rdmsr_safe(msr, low, high)				\
 ({								\
-	int __err;						\
-	u64 __val = native_read_msr_safe((msr), &__err);	\
+	u64 __val;						\
+	int __err = native_read_msr_safe((msr), &__val);	\
 	(*low) = (u32)__val;					\
 	(*high) = (u32)(__val >> 32);				\
 	__err;							\
@@ -213,10 +217,7 @@ static inline int wrmsrq_safe(u32 msr, u64 val)
 
 static inline int rdmsrq_safe(u32 msr, u64 *p)
 {
-	int err;
-
-	*p = native_read_msr_safe(msr, &err);
-	return err;
+	return native_read_msr_safe(msr, p);
 }
 
 static __always_inline u64 rdpmc(int counter)
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index edf23bd..03f680d 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -175,7 +175,7 @@ static inline void __write_cr4(unsigned long x)
 	PVOP_VCALL1(cpu.write_cr4, x);
 }
 
-static inline u64 paravirt_read_msr(unsigned msr)
+static inline u64 paravirt_read_msr(u32 msr)
 {
 	return PVOP_CALL1(u64, cpu.read_msr, msr);
 }
@@ -185,9 +185,9 @@ static inline void paravirt_write_msr(u32 msr, u64 val)
 	PVOP_VCALL2(cpu.write_msr, msr, val);
 }
 
-static inline u64 paravirt_read_msr_safe(unsigned msr, int *err)
+static inline int paravirt_read_msr_safe(u32 msr, u64 *val)
 {
-	return PVOP_CALL2(u64, cpu.read_msr_safe, msr, err);
+	return PVOP_CALL2(int, cpu.read_msr_safe, msr, val);
 }
 
 static inline int paravirt_write_msr_safe(u32 msr, u64 val)
@@ -225,19 +225,16 @@ static inline int wrmsrq_safe(u32 msr, u64 val)
 /* rdmsr with exception handling */
 #define rdmsr_safe(msr, a, b)				\
 ({							\
-	int _err;					\
-	u64 _l = paravirt_read_msr_safe(msr, &_err);	\
+	u64 _l;						\
+	int _err = paravirt_read_msr_safe((msr), &_l);	\
 	(*a) = (u32)_l;					\
-	(*b) = _l >> 32;				\
+	(*b) = (u32)(_l >> 32);				\
 	_err;						\
 })
 
-static inline int rdmsrq_safe(unsigned msr, u64 *p)
+static __always_inline int rdmsrq_safe(u32 msr, u64 *p)
 {
-	int err;
-
-	*p = paravirt_read_msr_safe(msr, &err);
-	return err;
+	return paravirt_read_msr_safe(msr, p);
 }
 
 static __always_inline u64 rdpmc(int counter)
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 78777b7..b08b9d3 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -91,14 +91,14 @@ struct pv_cpu_ops {
 		      unsigned int *ecx, unsigned int *edx);
 
 	/* Unsafe MSR operations.  These will warn or panic on failure. */
-	u64 (*read_msr)(unsigned int msr);
+	u64 (*read_msr)(u32 msr);
 	void (*write_msr)(u32 msr, u64 val);
 
 	/*
 	 * Safe MSR operations.
-	 * read sets err to 0 or -EIO.  write returns 0 or -EIO.
+	 * Returns 0 or -EIO.
 	 */
-	u64 (*read_msr_safe)(unsigned int msr, int *err);
+	int (*read_msr_safe)(u32 msr, u64 *val);
 	int (*write_msr_safe)(u32 msr, u64 val);
 
 	u64 (*read_pmc)(int counter);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 131f485..4c2a843 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -476,15 +476,13 @@ static void svm_inject_exception(struct kvm_vcpu *vcpu)
 
 static void svm_init_erratum_383(void)
 {
-	int err;
 	u64 val;
 
 	if (!static_cpu_has_bug(X86_BUG_AMD_TLB_MMATCH))
 		return;
 
 	/* Use _safe variants to not break nested virtualization */
-	val = native_read_msr_safe(MSR_AMD64_DC_CFG, &err);
-	if (err)
+	if (native_read_msr_safe(MSR_AMD64_DC_CFG, &val))
 		return;
 
 	val |= (1ULL << 47);
@@ -649,13 +647,12 @@ static int svm_enable_virtualization_cpu(void)
 	 * erratum is present everywhere).
 	 */
 	if (cpu_has(&boot_cpu_data, X86_FEATURE_OSVW)) {
-		uint64_t len, status = 0;
+		u64 len, status = 0;
 		int err;
 
-		len = native_read_msr_safe(MSR_AMD64_OSVW_ID_LENGTH, &err);
+		err = native_read_msr_safe(MSR_AMD64_OSVW_ID_LENGTH, &len);
 		if (!err)
-			status = native_read_msr_safe(MSR_AMD64_OSVW_STATUS,
-						      &err);
+			err = native_read_msr_safe(MSR_AMD64_OSVW_STATUS, &status);
 
 		if (err)
 			osvw_status = osvw_len = 0;
@@ -2146,14 +2143,13 @@ static int ac_interception(struct kvm_vcpu *vcpu)
 
 static bool is_erratum_383(void)
 {
-	int err, i;
+	int i;
 	u64 value;
 
 	if (!erratum_383_found)
 		return false;
 
-	value = native_read_msr_safe(MSR_IA32_MC0_STATUS, &err);
-	if (err)
+	if (native_read_msr_safe(MSR_IA32_MC0_STATUS, &value))
 		return false;
 
 	/* Bit 62 may or may not be set for this mce */
@@ -2166,8 +2162,7 @@ static bool is_erratum_383(void)
 	for (i = 0; i < 6; ++i)
 		native_write_msr_safe(MSR_IA32_MCx_STATUS(i), 0);
 
-	value = native_read_msr_safe(MSR_IA32_MCG_STATUS, &err);
-	if (!err) {
+	if (!native_read_msr_safe(MSR_IA32_MCG_STATUS, &value)) {
 		value &= ~(1ULL << 2);
 		native_write_msr_safe(MSR_IA32_MCG_STATUS, value);
 	}
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 4fbe0bd..3be3835 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1087,7 +1087,7 @@ static void xen_write_cr4(unsigned long cr4)
 	native_write_cr4(cr4);
 }
 
-static u64 xen_do_read_msr(unsigned int msr, int *err)
+static u64 xen_do_read_msr(u32 msr, int *err)
 {
 	u64 val = 0;	/* Avoid uninitialized value for safe variant. */
 
@@ -1095,7 +1095,7 @@ static u64 xen_do_read_msr(unsigned int msr, int *err)
 		return val;
 
 	if (err)
-		val = native_read_msr_safe(msr, err);
+		*err = native_read_msr_safe(msr, &val);
 	else
 		val = native_read_msr(msr);
 
@@ -1160,9 +1160,12 @@ static void xen_do_write_msr(u32 msr, u64 val, int *err)
 	}
 }
 
-static u64 xen_read_msr_safe(unsigned int msr, int *err)
+static int xen_read_msr_safe(u32 msr, u64 *val)
 {
-	return xen_do_read_msr(msr, err);
+	int err;
+
+	*val = xen_do_read_msr(msr, &err);
+	return err;
 }
 
 static int xen_write_msr_safe(u32 msr, u64 val)
@@ -1174,7 +1177,7 @@ static int xen_write_msr_safe(u32 msr, u64 val)
 	return err;
 }
 
-static u64 xen_read_msr(unsigned int msr)
+static u64 xen_read_msr(u32 msr)
 {
 	int err;
 
diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index 043d72b..8f89ce0 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -319,11 +319,12 @@ static u64 xen_amd_read_pmc(int counter)
 	uint8_t xenpmu_flags = get_xenpmu_flags();
 
 	if (!xenpmu_data || !(xenpmu_flags & XENPMU_IRQ_PROCESSING)) {
-		uint32_t msr;
-		int err;
+		u32 msr;
+		u64 val;
 
 		msr = amd_counters_base + (counter * amd_msr_step);
-		return native_read_msr_safe(msr, &err);
+		native_read_msr_safe(msr, &val);
+		return val;
 	}
 
 	ctxt = &xenpmu_data->pmu.c.amd;
@@ -340,15 +341,16 @@ static u64 xen_intel_read_pmc(int counter)
 	uint8_t xenpmu_flags = get_xenpmu_flags();
 
 	if (!xenpmu_data || !(xenpmu_flags & XENPMU_IRQ_PROCESSING)) {
-		uint32_t msr;
-		int err;
+		u32 msr;
+		u64 val;
 
 		if (counter & (1 << INTEL_PMC_TYPE_SHIFT))
 			msr = MSR_CORE_PERF_FIXED_CTR0 + (counter & 0xffff);
 		else
 			msr = MSR_IA32_PERFCTR0 + counter;
 
-		return native_read_msr_safe(msr, &err);
+		native_read_msr_safe(msr, &val);
+		return val;
 	}
 
 	ctxt = &xenpmu_data->pmu.c.intel;

