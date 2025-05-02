Return-Path: <linux-tip-commits+bounces-5160-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE43AA6D8A
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 11:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2022A4C1C5D
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 09:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D665022C35C;
	Fri,  2 May 2025 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FDajAH90";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gVdIr99C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6423433CE;
	Fri,  2 May 2025 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176662; cv=none; b=uA4bCMhk4EuJh7WFi774OxvP3eVhZcSnhKFpME8ls6XItKexcGdFHsTStYoZiR6jLAYq5t8riz50Q/3pmtPMnDsJSYVYoVTw8ol10MpZMx0eMWhhmYci9haOTvMOxmNN3g2SWvZCq9y3jLsCSjktESBfi3nTkFAVPll8dTVpR1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176662; c=relaxed/simple;
	bh=8xRBW7BjKjLy+wVGSuSOr3agsqbvD1P1kl2sha3112s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U/lJOEptxKjLCwD49lTQQtUL4zlyJuaz+4fo9uQqBl9YW45vtTMy5wT/9uEcA0W90sEcZmHX0eqGDeo5caeq0R9pR29OQ67EjMD50sSuhO5fC8sMVzLhX2Pf/nvGDh1yBIHckMfeVQjxitflM3kXiRasSjeCl0z5+CgsG6KhcIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FDajAH90; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gVdIr99C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 09:04:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746176658;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbi71XM0OV2kWNw9zbHk+Y6isPvtJsbX6ZMUFMUZwJA=;
	b=FDajAH90JP4eTZRQy+ygkghgg3Ez9HasFTywsFyPdxHu46uPwLeGfDAHqV9nc7HVYsmIgb
	vmaYku/x2KNmr87x39riiFbFwngITNUcXvqeVi/Zt62b3QeR5jNPNK9E0uPxl2uoSRbK//
	tOA/QIauDdCGIX72i9iImIrwsnTZhA9tATekF5ll6GxbzCe5fitEcL3ORYVIG6GsWeoZZy
	uzWApE072DE611LxNOzHnw5WPVzU0Ha1Q5+zZ7NWsb7mdi4HL53/ibMrqnyk5I5gqsYMpo
	E6DeG1v0IH6gIgXMU09d6yBeX9JGLiTy53skOhqZX0PIWU7rj7rHhtrdrJmppA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746176658;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbi71XM0OV2kWNw9zbHk+Y6isPvtJsbX6ZMUFMUZwJA=;
	b=gVdIr99CFyL8uPNxYCJ7ryXsw9DhV9okFNfEz2f0y5YEGAhFpeT9UCAU9V0he0NNHhnrOK
	AH9gmi5EqKLVDJCg==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/merge] x86/msr: Replace wrmsr(msr, low, 0) with wrmsrq(msr, low)
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
In-Reply-To: <20250427092027.1598740-15-xin@zytor.com>
References: <20250427092027.1598740-15-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174617665757.22196.213699917175739032.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     444b46a128ccd0883f83ffa2e6b4a1f64ea4ca1c
Gitweb:        https://git.kernel.org/tip/444b46a128ccd0883f83ffa2e6b4a1f64ea4ca1c
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Sun, 27 Apr 2025 02:20:26 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 May 2025 10:36:36 +02:00

x86/msr: Replace wrmsr(msr, low, 0) with wrmsrq(msr, low)

The third argument in wrmsr(msr, low, 0) is unnecessary.  Instead, use
wrmsrq(msr, low), which automatically sets the higher 32 bits of the
MSR value to 0.

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
Link: https://lore.kernel.org/r/20250427092027.1598740-15-xin@zytor.com
---
 arch/x86/hyperv/hv_apic.c                 | 6 +++---
 arch/x86/include/asm/apic.h               | 2 +-
 arch/x86/include/asm/switch_to.h          | 2 +-
 arch/x86/kernel/cpu/amd.c                 | 2 +-
 arch/x86/kernel/cpu/common.c              | 8 ++++----
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 4 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 2 +-
 arch/x86/kernel/cpu/umwait.c              | 4 ++--
 arch/x86/kernel/kvm.c                     | 2 +-
 9 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index a079a14..bfde0a3 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -76,10 +76,10 @@ static void hv_apic_write(u32 reg, u32 val)
 {
 	switch (reg) {
 	case APIC_EOI:
-		wrmsr(HV_X64_MSR_EOI, val, 0);
+		wrmsrq(HV_X64_MSR_EOI, val);
 		break;
 	case APIC_TASKPRI:
-		wrmsr(HV_X64_MSR_TPR, val, 0);
+		wrmsrq(HV_X64_MSR_TPR, val);
 		break;
 	default:
 		native_apic_mem_write(reg, val);
@@ -93,7 +93,7 @@ static void hv_apic_eoi_write(void)
 	if (hvp && (xchg(&hvp->apic_assist, 0) & 0x1))
 		return;
 
-	wrmsr(HV_X64_MSR_EOI, APIC_EOI_ACK, 0);
+	wrmsrq(HV_X64_MSR_EOI, APIC_EOI_ACK);
 }
 
 static bool cpu_is_self(int cpu)
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 0174dd5..68e10e3 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -209,7 +209,7 @@ static inline void native_apic_msr_write(u32 reg, u32 v)
 	    reg == APIC_LVR)
 		return;
 
-	wrmsr(APIC_BASE_MSR + (reg >> 4), v, 0);
+	wrmsrq(APIC_BASE_MSR + (reg >> 4), v);
 }
 
 static inline void native_apic_msr_eoi(void)
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index 4f21df7..499b1c1 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -61,7 +61,7 @@ static inline void refresh_sysenter_cs(struct thread_struct *thread)
 		return;
 
 	this_cpu_write(cpu_tss_rw.x86_tss.ss1, thread->sysenter_cs);
-	wrmsr(MSR_IA32_SYSENTER_CS, thread->sysenter_cs, 0);
+	wrmsrq(MSR_IA32_SYSENTER_CS, thread->sysenter_cs);
 }
 #endif
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index e153cd1..d8365c4 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1207,7 +1207,7 @@ void amd_set_dr_addr_mask(unsigned long mask, unsigned int dr)
 	if (per_cpu(amd_dr_addr_mask, cpu)[dr] == mask)
 		return;
 
-	wrmsr(amd_msr_dr_addr_masks[dr], mask, 0);
+	wrmsrq(amd_msr_dr_addr_masks[dr], mask);
 	per_cpu(amd_dr_addr_mask, cpu)[dr] = mask;
 }
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index cefc999..ef9751d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1982,9 +1982,9 @@ void enable_sep_cpu(void)
 	 */
 
 	tss->x86_tss.ss1 = __KERNEL_CS;
-	wrmsr(MSR_IA32_SYSENTER_CS, tss->x86_tss.ss1, 0);
-	wrmsr(MSR_IA32_SYSENTER_ESP, (unsigned long)(cpu_entry_stack(cpu) + 1), 0);
-	wrmsr(MSR_IA32_SYSENTER_EIP, (unsigned long)entry_SYSENTER_32, 0);
+	wrmsrq(MSR_IA32_SYSENTER_CS, tss->x86_tss.ss1);
+	wrmsrq(MSR_IA32_SYSENTER_ESP, (unsigned long)(cpu_entry_stack(cpu) + 1));
+	wrmsrq(MSR_IA32_SYSENTER_EIP, (unsigned long)entry_SYSENTER_32);
 
 	put_cpu();
 }
@@ -2198,7 +2198,7 @@ static inline void setup_getcpu(int cpu)
 	struct desc_struct d = { };
 
 	if (boot_cpu_has(X86_FEATURE_RDTSCP) || boot_cpu_has(X86_FEATURE_RDPID))
-		wrmsr(MSR_TSC_AUX, cpudata, 0);
+		wrmsrq(MSR_TSC_AUX, cpudata);
 
 	/* Store CPU and node number in limit. */
 	d.limit0 = cpudata;
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 324bd49..1190c48 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -905,7 +905,7 @@ int resctrl_arch_measure_cycles_lat_fn(void *_plr)
 	 * Disable hardware prefetchers.
 	 */
 	rdmsr(MSR_MISC_FEATURE_CONTROL, saved_low, saved_high);
-	wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
+	wrmsrq(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits);
 	mem_r = READ_ONCE(plr->kmem);
 	/*
 	 * Dummy execute of the time measurement to load the needed
@@ -1001,7 +1001,7 @@ static int measure_residency_fn(struct perf_event_attr *miss_attr,
 	 * Disable hardware prefetchers.
 	 */
 	rdmsr(MSR_MISC_FEATURE_CONTROL, saved_low, saved_high);
-	wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
+	wrmsrq(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits);
 
 	/* Initialize rest of local variables */
 	/*
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f724b8f..c85ace2 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1708,7 +1708,7 @@ void resctrl_arch_mon_event_config_write(void *_config_info)
 		pr_warn_once("Invalid event id %d\n", config_info->evtid);
 		return;
 	}
-	wrmsr(MSR_IA32_EVT_CFG_BASE + index, config_info->mon_config, 0);
+	wrmsrq(MSR_IA32_EVT_CFG_BASE + index, config_info->mon_config);
 }
 
 static void mbm_config_write_domain(struct rdt_resource *r,
diff --git a/arch/x86/kernel/cpu/umwait.c b/arch/x86/kernel/cpu/umwait.c
index 0050eae..933fcd7 100644
--- a/arch/x86/kernel/cpu/umwait.c
+++ b/arch/x86/kernel/cpu/umwait.c
@@ -33,7 +33,7 @@ static DEFINE_MUTEX(umwait_lock);
 static void umwait_update_control_msr(void * unused)
 {
 	lockdep_assert_irqs_disabled();
-	wrmsr(MSR_IA32_UMWAIT_CONTROL, READ_ONCE(umwait_control_cached), 0);
+	wrmsrq(MSR_IA32_UMWAIT_CONTROL, READ_ONCE(umwait_control_cached));
 }
 
 /*
@@ -71,7 +71,7 @@ static int umwait_cpu_offline(unsigned int cpu)
 	 * the original control MSR value in umwait_init(). So there
 	 * is no race condition here.
 	 */
-	wrmsr(MSR_IA32_UMWAIT_CONTROL, orig_umwait_control_cached, 0);
+	wrmsrq(MSR_IA32_UMWAIT_CONTROL, orig_umwait_control_cached);
 
 	return 0;
 }
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 27f7192..f364222 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -400,7 +400,7 @@ static void kvm_disable_steal_time(void)
 	if (!has_steal_clock)
 		return;
 
-	wrmsr(MSR_KVM_STEAL_TIME, 0, 0);
+	wrmsrq(MSR_KVM_STEAL_TIME, 0);
 }
 
 static u64 kvm_steal_clock(int cpu)

