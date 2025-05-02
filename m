Return-Path: <linux-tip-commits+bounces-5172-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AED66AA6DAE
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 11:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9273B91F8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 09:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C344B2686A1;
	Fri,  2 May 2025 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fslbjb2J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P7zDfDm6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76150231825;
	Fri,  2 May 2025 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176672; cv=none; b=SZQcfwsFAFDzR/uDyVlvl7+ek25hicJVQw5b7bBqplh0PgmUlNjAL7y6RJWo/gnIc81AyE0i6jOoym/w/0zd3yn7k4Sj2fWOWyor/r3z8FqgCd1FIT8iUPECKtSvd6WMglSbbS54CwaRwa0rwIzkFd79P16/rLOPaxwxRAShxSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176672; c=relaxed/simple;
	bh=gsj6A2AtEaBXqWN9aEAjeaBWWdcyOd+wRo45TojsJwk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VybPyvzXwvlDipJioPDamI08CC2BkSyak4c81nGxcKRg/4ElUerWZzrV4FAyZvT6uQFhkZnLbCchhLLWgKi9Gpb/NSwwwnqwN+ksbvirPeoex/ErOspbX5+ODtJyndbFq/A/yfX2wJGyBl4lZuGO+/b1I6g/O5YQ8vvjtQMINJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fslbjb2J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P7zDfDm6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 09:04:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746176662;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UiFvvFrPnFl/Y1xZdiVoGX4WHrYLDBvz99ttpbyI3mo=;
	b=Fslbjb2Jo37HkzjIapi4lILKhAX5l4vs/Y1Z96O4mO/VjrgymTSoQWmecczLtjLWdCfn/a
	mo8CL2wFEjMoKuDc+Fxr9m2AkK280dvHEp176/Z0bv+nwEGwxQLdwE6ybvwGTuNPC6M0cp
	Ra156s8XvLyv58AfaddIje3UdyKQLovJWWjDBBH75KkXL+b1FkZPvBEE97sUvyn3XEBNIC
	yXJFiDbkP6l1qhRC9N09nczDlIFTlpTM34+eYf/IXEx+vtzq/KR8gZTOji/gyJpbIaJwGG
	POkptqqTg1auV2ZnhC3q+Hr+ptT6c1oKiDg2geqTT9W/djlfqxoO1Yz3+x/4Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746176662;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UiFvvFrPnFl/Y1xZdiVoGX4WHrYLDBvz99ttpbyI3mo=;
	b=P7zDfDm6t40/c3abDhkveXM77A/pTnkXzpH8VqtJ++K5N/tLIY63IrSlJ43d3aomY0wRiz
	OVtfg80IijqNQDCg==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/merge] x86/msr: Convert __rdmsr() uses to native_rdmsrq() uses
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
In-Reply-To: <20250427092027.1598740-10-xin@zytor.com>
References: <20250427092027.1598740-10-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174617666160.22196.10501829134860070654.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     3204877d05ca17162270890e3f28552741a1b1a2
Gitweb:        https://git.kernel.org/tip/3204877d05ca17162270890e3f28552741a1b1a2
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Sun, 27 Apr 2025 02:20:21 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 May 2025 10:36:35 +02:00

x86/msr: Convert __rdmsr() uses to native_rdmsrq() uses

__rdmsr() is the lowest level MSR write API, with native_rdmsr()
and native_rdmsrq() serving as higher-level wrappers around it.

  #define native_rdmsr(msr, val1, val2)                   \
  do {                                                    \
          u64 __val = __rdmsr((msr));                     \
          (void)((val1) = (u32)__val);                    \
          (void)((val2) = (u32)(__val >> 32));            \
  } while (0)

  static __always_inline u64 native_rdmsrq(u32 msr)
  {
          return __rdmsr(msr);
  }

However, __rdmsr() continues to be utilized in various locations.

MSR APIs are designed for different scenarios, such as native or
pvops, with or without trace, and safe or non-safe.  Unfortunately,
the current MSR API names do not adequately reflect these factors,
making it challenging to select the most appropriate API for
various situations.

To pave the way for improving MSR API names, convert __rdmsr()
uses to native_rdmsrq() to ensure consistent usage.  Later, these
APIs can be renamed to better reflect their implications, such as
native or pvops, with or without trace, and safe or non-safe.

No functional change intended.

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
Link: https://lore.kernel.org/r/20250427092027.1598740-10-xin@zytor.com
---
 arch/x86/coco/sev/core.c                  | 2 +-
 arch/x86/events/amd/brs.c                 | 2 +-
 arch/x86/hyperv/hv_vtl.c                  | 4 ++--
 arch/x86/hyperv/ivm.c                     | 2 +-
 arch/x86/include/asm/mshyperv.h           | 2 +-
 arch/x86/kernel/cpu/common.c              | 2 +-
 arch/x86/kernel/cpu/mce/core.c            | 4 ++--
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 2 +-
 arch/x86/kvm/vmx/vmx.c                    | 4 ++--
 arch/x86/mm/mem_encrypt_identity.c        | 4 ++--
 10 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 85b16a0..ff82151 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -277,7 +277,7 @@ static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
 
 static inline u64 sev_es_rd_ghcb_msr(void)
 {
-	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
+	return native_rdmsrq(MSR_AMD64_SEV_ES_GHCB);
 }
 
 static __always_inline void sev_es_wr_ghcb_msr(u64 val)
diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 3f5ecfd..06f35a6 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -49,7 +49,7 @@ static __always_inline void set_debug_extn_cfg(u64 val)
 
 static __always_inline u64 get_debug_extn_cfg(void)
 {
-	return __rdmsr(MSR_AMD_DBG_EXTN_CFG);
+	return native_rdmsrq(MSR_AMD_DBG_EXTN_CFG);
 }
 
 static bool __init amd_brs_detect(void)
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 079b276..4580936 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -150,11 +150,11 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ignored)
 	input->vp_context.rip = rip;
 	input->vp_context.rsp = rsp;
 	input->vp_context.rflags = 0x0000000000000002;
-	input->vp_context.efer = __rdmsr(MSR_EFER);
+	input->vp_context.efer = native_rdmsrq(MSR_EFER);
 	input->vp_context.cr0 = native_read_cr0();
 	input->vp_context.cr3 = __native_read_cr3();
 	input->vp_context.cr4 = native_read_cr4();
-	input->vp_context.msr_cr_pat = __rdmsr(MSR_IA32_CR_PAT);
+	input->vp_context.msr_cr_pat = native_rdmsrq(MSR_IA32_CR_PAT);
 	input->vp_context.idtr.limit = idt_ptr.size;
 	input->vp_context.idtr.base = idt_ptr.address;
 	input->vp_context.gdtr.limit = gdt_ptr.size;
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 8209de7..09a165a 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -111,7 +111,7 @@ u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size)
 
 static inline u64 rd_ghcb_msr(void)
 {
-	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
+	return native_rdmsrq(MSR_AMD64_SEV_ES_GHCB);
 }
 
 static inline void wr_ghcb_msr(u64 val)
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 15d00da..7784443 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -305,7 +305,7 @@ void hv_set_non_nested_msr(unsigned int reg, u64 value);
 
 static __always_inline u64 hv_raw_get_msr(unsigned int reg)
 {
-	return __rdmsr(reg);
+	return native_rdmsrq(reg);
 }
 
 #else /* CONFIG_HYPERV */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 079ded4..cefc999 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -164,7 +164,7 @@ static void ppin_init(struct cpuinfo_x86 *c)
 
 	/* Is the enable bit set? */
 	if (val & 2UL) {
-		c->ppin = __rdmsr(info->msr_ppin);
+		c->ppin = native_rdmsrq(info->msr_ppin);
 		set_cpu_cap(c, info->feature);
 		return;
 	}
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 96db2fd..e9b3c5d 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -121,7 +121,7 @@ void mce_prep_record_common(struct mce *m)
 {
 	m->cpuid	= cpuid_eax(1);
 	m->cpuvendor	= boot_cpu_data.x86_vendor;
-	m->mcgcap	= __rdmsr(MSR_IA32_MCG_CAP);
+	m->mcgcap	= native_rdmsrq(MSR_IA32_MCG_CAP);
 	/* need the internal __ version to avoid deadlocks */
 	m->time		= __ktime_get_real_seconds();
 }
@@ -1298,7 +1298,7 @@ static noinstr bool mce_check_crashing_cpu(void)
 	    (crashing_cpu != -1 && crashing_cpu != cpu)) {
 		u64 mcgstatus;
 
-		mcgstatus = __rdmsr(MSR_IA32_MCG_STATUS);
+		mcgstatus = native_rdmsrq(MSR_IA32_MCG_STATUS);
 
 		if (boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN) {
 			if (mcgstatus & MCG_STATUS_LMCES)
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 6e5edd7..324bd49 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -482,7 +482,7 @@ int resctrl_arch_pseudo_lock_fn(void *_plr)
 	 * the buffer and evict pseudo-locked memory read earlier from the
 	 * cache.
 	 */
-	saved_msr = __rdmsr(MSR_MISC_FEATURE_CONTROL);
+	saved_msr = native_rdmsrq(MSR_MISC_FEATURE_CONTROL);
 	native_wrmsrq(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits);
 	closid_p = this_cpu_read(pqr_state.cur_closid);
 	rmid_p = this_cpu_read(pqr_state.cur_rmid);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d8412cf..63de5f6 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -381,7 +381,7 @@ static __always_inline void vmx_disable_fb_clear(struct vcpu_vmx *vmx)
 	if (!vmx->disable_fb_clear)
 		return;
 
-	msr = __rdmsr(MSR_IA32_MCU_OPT_CTRL);
+	msr = native_rdmsrq(MSR_IA32_MCU_OPT_CTRL);
 	msr |= FB_CLEAR_DIS;
 	native_wrmsrq(MSR_IA32_MCU_OPT_CTRL, msr);
 	/* Cache the MSR value to avoid reading it later */
@@ -7308,7 +7308,7 @@ void noinstr vmx_spec_ctrl_restore_host(struct vcpu_vmx *vmx,
 		return;
 
 	if (flags & VMX_RUN_SAVE_SPEC_CTRL)
-		vmx->spec_ctrl = __rdmsr(MSR_IA32_SPEC_CTRL);
+		vmx->spec_ctrl = native_rdmsrq(MSR_IA32_SPEC_CTRL);
 
 	/*
 	 * If the guest/host SPEC_CTRL values differ, restore the host value.
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 5eecdd9..25f6677 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -526,7 +526,7 @@ void __head sme_enable(struct boot_params *bp)
 	me_mask = 1UL << (ebx & 0x3f);
 
 	/* Check the SEV MSR whether SEV or SME is enabled */
-	RIP_REL_REF(sev_status) = msr = __rdmsr(MSR_AMD64_SEV);
+	RIP_REL_REF(sev_status) = msr = native_rdmsrq(MSR_AMD64_SEV);
 	feature_mask = (msr & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
 
 	/*
@@ -557,7 +557,7 @@ void __head sme_enable(struct boot_params *bp)
 			return;
 
 		/* For SME, check the SYSCFG MSR */
-		msr = __rdmsr(MSR_AMD64_SYSCFG);
+		msr = native_rdmsrq(MSR_AMD64_SYSCFG);
 		if (!(msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT))
 			return;
 	}

