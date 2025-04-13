Return-Path: <linux-tip-commits+bounces-4927-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F373A87338
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 20:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177DD16ED5A
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 18:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A6F1F3B9E;
	Sun, 13 Apr 2025 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jjCjVCel";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F+AsLJrO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2111EEA59;
	Sun, 13 Apr 2025 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570573; cv=none; b=EbMsKEcVRbG4pl8LP7eK+KhVCl4tcRtyW7ZKlfh181ucbBXlHoaPDpm5AtrjWeAmdKnIzm5jCtTmgsnpaHu8Cj5MSndGM8ReAzTrOPDfucE5pUMRAN1gVsNCYpCIC9juLQzChuHQzwYoOa9rCy/OlcqICjA1GkZiRkFMGtHrkr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570573; c=relaxed/simple;
	bh=ku4fomBzYVRwuuZtL0h4HQ0eLiQzPRZl+A8pD3091eU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=CuF9EtkheXFAPOro80++On3XdeRorRKqHDT4FiUeAlrbQnrFeceeqc8LCqJwzRFb6umAQG3A7xah8C22Q0P3v+9B2iqxK8uO6fzMo76mz3alhYi9N9kcF/zqSfUgsAXKnIJ2blbQk02ACwgRnQZYtwfJ0/Ki/5IzMs6HUF1PjCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jjCjVCel; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F+AsLJrO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 18:56:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744570570;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=94qQz+G3TswotxZs+At17Vha7rXM1dgV6TGSnSLyrzM=;
	b=jjCjVCelACFEWmCo5AteI8qu4eNE7Zl0T3KpKX7OpeFpBePUdGPrZM3tJfdrzktYcVEeVA
	5Gf+BhoqvKQeXahF9BlOZ4lypRh8JXi9TGXxFmSblSy7x4gycDj4saa9d4uC2R/KnLG8UM
	h/oqG2x2SYDu5HJPGbgteewF5776n6p124AnS0HCdq8bvUh+iFU/UKC35pM6JZp3n9Daxo
	WmC4tu+gs25D4OzhPlNWaA3ZzrGi5vB9EXMSLRACxbREZwkt0PIWqzbFu1i8joEszcU3zs
	++hWqTo5Up1cUOFZncWHdrBJKmfvlPBKQm7HeYSCEUfoVNtJryOmrWi5XyIUSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744570570;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=94qQz+G3TswotxZs+At17Vha7rXM1dgV6TGSnSLyrzM=;
	b=F+AsLJrOyg6g8dv4Zo7OF0mqVB1+iNqsQAMsgAZdz9xdSU5ei+m7DhUSMEztZrz7i+A9hD
	/evSZ0bw0FXoLSDA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/msr] x86/msr: Rename 'native_wrmsrl()' to 'native_wrmsrq()'
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juergen Gross <jgross@suse.com>, Dave Hansen <dave.hansen@intel.com>,
 Xin Li <xin@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174457056937.31282.5055011506752254958.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     7cbc2ba7c107a1a537524ae505e192f4f88cc209
Gitweb:        https://git.kernel.org/tip/7cbc2ba7c107a1a537524ae505e192f4f88cc209
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 22:29:06 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 11:59:28 +02:00

x86/msr: Rename 'native_wrmsrl()' to 'native_wrmsrq()'

Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Xin Li <xin@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/hyperv/ivm.c                 | 2 +-
 arch/x86/include/asm/microcode.h      | 2 +-
 arch/x86/include/asm/msr.h            | 2 +-
 arch/x86/include/asm/spec-ctrl.h      | 2 +-
 arch/x86/kernel/cpu/microcode/amd.c   | 2 +-
 arch/x86/kernel/cpu/microcode/intel.c | 2 +-
 arch/x86/kvm/vmx/vmx.c                | 8 ++++----
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 77bf05f..1b8a241 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -115,7 +115,7 @@ static inline u64 rd_ghcb_msr(void)
 
 static inline void wr_ghcb_msr(u64 val)
 {
-	native_wrmsrl(MSR_AMD64_SEV_ES_GHCB, val);
+	native_wrmsrq(MSR_AMD64_SEV_ES_GHCB, val);
 }
 
 static enum es_result hv_ghcb_hv_call(struct ghcb *ghcb, u64 exit_code,
diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 695e569..263ea3d 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -61,7 +61,7 @@ static inline u32 intel_get_microcode_revision(void)
 {
 	u32 rev, dummy;
 
-	native_wrmsrl(MSR_IA32_UCODE_REV, 0);
+	native_wrmsrq(MSR_IA32_UCODE_REV, 0);
 
 	/* As documented in the SDM: Do a CPUID 1 here */
 	native_cpuid_eax(1);
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 4335f91..20deb58 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -109,7 +109,7 @@ do {							\
 #define native_wrmsr(msr, low, high)			\
 	__wrmsr(msr, low, high)
 
-#define native_wrmsrl(msr, val)				\
+#define native_wrmsrq(msr, val)				\
 	__wrmsr((msr), (u32)((u64)(val)),		\
 		       (u32)((u64)(val) >> 32))
 
diff --git a/arch/x86/include/asm/spec-ctrl.h b/arch/x86/include/asm/spec-ctrl.h
index 658b690..00b7e03 100644
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -84,7 +84,7 @@ static inline u64 ssbd_tif_to_amd_ls_cfg(u64 tifn)
 static __always_inline void __update_spec_ctrl(u64 val)
 {
 	__this_cpu_write(x86_spec_ctrl_current, val);
-	native_wrmsrl(MSR_IA32_SPEC_CTRL, val);
+	native_wrmsrq(MSR_IA32_SPEC_CTRL, val);
 }
 
 #ifdef CONFIG_SMP
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index b61028c..041dae0 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -602,7 +602,7 @@ static bool __apply_microcode_amd(struct microcode_amd *mc, u32 *cur_rev,
 	if (!verify_sha256_digest(mc->hdr.patch_id, *cur_rev, (const u8 *)p_addr, psize))
 		return false;
 
-	native_wrmsrl(MSR_AMD64_PATCH_LOADER, p_addr);
+	native_wrmsrq(MSR_AMD64_PATCH_LOADER, p_addr);
 
 	if (x86_family(bsp_cpuid_1_eax) == 0x17) {
 		unsigned long p_addr_end = p_addr + psize - 1;
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 819199b..86e1047 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -320,7 +320,7 @@ static enum ucode_state __apply_microcode(struct ucode_cpu_info *uci,
 	}
 
 	/* write microcode via MSR 0x79 */
-	native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
+	native_wrmsrq(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
 	rev = intel_get_microcode_revision();
 	if (rev != mc->hdr.rev)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9b221bd..cd0d6c1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -382,7 +382,7 @@ static __always_inline void vmx_disable_fb_clear(struct vcpu_vmx *vmx)
 
 	msr = __rdmsr(MSR_IA32_MCU_OPT_CTRL);
 	msr |= FB_CLEAR_DIS;
-	native_wrmsrl(MSR_IA32_MCU_OPT_CTRL, msr);
+	native_wrmsrq(MSR_IA32_MCU_OPT_CTRL, msr);
 	/* Cache the MSR value to avoid reading it later */
 	vmx->msr_ia32_mcu_opt_ctrl = msr;
 }
@@ -393,7 +393,7 @@ static __always_inline void vmx_enable_fb_clear(struct vcpu_vmx *vmx)
 		return;
 
 	vmx->msr_ia32_mcu_opt_ctrl &= ~FB_CLEAR_DIS;
-	native_wrmsrl(MSR_IA32_MCU_OPT_CTRL, vmx->msr_ia32_mcu_opt_ctrl);
+	native_wrmsrq(MSR_IA32_MCU_OPT_CTRL, vmx->msr_ia32_mcu_opt_ctrl);
 }
 
 static void vmx_update_fb_clear_dis(struct kvm_vcpu *vcpu, struct vcpu_vmx *vmx)
@@ -6745,7 +6745,7 @@ static noinstr void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 	vcpu->stat.l1d_flush++;
 
 	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
-		native_wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
+		native_wrmsrq(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
 		return;
 	}
 
@@ -7318,7 +7318,7 @@ void noinstr vmx_spec_ctrl_restore_host(struct vcpu_vmx *vmx,
 	 */
 	if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS) ||
 	    vmx->spec_ctrl != hostval)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, hostval);
+		native_wrmsrq(MSR_IA32_SPEC_CTRL, hostval);
 
 	barrier_nospec();
 }

