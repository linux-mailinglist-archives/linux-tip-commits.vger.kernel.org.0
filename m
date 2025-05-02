Return-Path: <linux-tip-commits+bounces-5163-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F39AA6D88
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 11:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0751BC654E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 09:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F410A22F176;
	Fri,  2 May 2025 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ujltCmH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aRnv2GfF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF172AF0E;
	Fri,  2 May 2025 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176664; cv=none; b=rsSijowBXRE46LrB64LzPgLf52sqOlosGCnVlbpGzzmvS43PV1gOTVtZvvLrwg0ENPmrAw6kHZfNh9EUnsYCiqdJsug9vscUCV+Bd/zOB8iizYUdh4ntZLaYRn08LaHx/k95UmXD6mu8W8g+mi8MA3cQh1Ag3vcefqmC5RkPH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176664; c=relaxed/simple;
	bh=LLYEfreD2wq2Fb3G3DYkyjUnLGl84CwvYZ38a73HvLo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mm+fmnZUtT04RqRJpPo5FtB7WXcjQLuDaNGH1twod/+CPnKDjszJr7EOSX9bubdfBP/KyupFHhqVhC5Nh8R2l/dihv8u0cGPReKXY/sfifw/UPF+MIV2G6Ghf91JsjOIMfUBvpNeXIBSm4lvLofOyK7PQAlwxKMyFybkEyr7gQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ujltCmH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aRnv2GfF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 09:04:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746176659;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ROWBo5kR+tnmmqu48/dcWiqkosQNGP7gIdgW9Xlrabs=;
	b=1ujltCmHWZ0cpd1RhoC3GBypWzL4NcrcOxrnbcf1jkYsk7RCrBQDLpD3PdLBpG44hV6MRG
	qAKDqIe7UHA3L/79FAJnjJKkyRBxecIZ9feVT6IVLn71DSdlYhxESS1ggbqWcRPgelEXK+
	XB4ZkoQ7hldNNWbOZ3QLxae0U0PL4mr0pgVlhBcBwij8D/AIKgOZHMTtM6IbqPtdFe0rtv
	4DQPHU25qdy9dv6FMRx9XKOMCIZSp/tzcaW6AdCXHu/0FUi8pM1JD+qlXhRujQOgm/fg3q
	thKlBwkQ84Oo/GxtbcEhtVEEWaFS9Q9i+F4P3+CJmnwcfrjXV7TWBJ5cozDXKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746176659;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ROWBo5kR+tnmmqu48/dcWiqkosQNGP7gIdgW9Xlrabs=;
	b=aRnv2GfFBuZSH8AD0ckdA6HFTgT8v4/a5/h8d+hU2C6GK62mdPQVcWPcIPUu3dfYcCZx2+
	Kv1FJyEzt7pkM7BQ==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/merge] x86/pvops/msr: Refactor pv_cpu_ops.write_msr{,_safe}()
Cc: "Xin Li (Intel)" <xin@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Juergen Gross <jgross@suse.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250427092027.1598740-14-xin@zytor.com>
References: <20250427092027.1598740-14-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174617665846.22196.16306968254391372133.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     0c2678efed6c6a2908dfe14af1e93a6bebc78e79
Gitweb:        https://git.kernel.org/tip/0c2678efed6c6a2908dfe14af1e93a6bebc78e79
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Sun, 27 Apr 2025 02:20:25 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 May 2025 10:36:36 +02:00

x86/pvops/msr: Refactor pv_cpu_ops.write_msr{,_safe}()

An MSR value is represented as a 64-bit unsigned integer, with existing
MSR instructions storing it in EDX:EAX as two 32-bit segments.

The new immediate form MSR instructions, however, utilize a 64-bit
general-purpose register to store the MSR value.  To unify the usage of
all MSR instructions, let the default MSR access APIs accept an MSR
value as a single 64-bit argument instead of two 32-bit segments.

The dual 32-bit APIs are still available as convenient wrappers over the
APIs that handle an MSR value as a single 64-bit argument.

The following illustrates the updated derivation of the MSR write APIs:

                 __wrmsrq(u32 msr, u64 val)
                   /                  \
                  /                    \
           native_wrmsrq(msr, val)    native_wrmsr(msr, low, high)
                 |
                 |
           native_write_msr(msr, val)
                /          \
               /            \
       wrmsrq(msr, val)    wrmsr(msr, low, high)

When CONFIG_PARAVIRT is enabled, wrmsrq() and wrmsr() are defined on top
of paravirt_write_msr():

            paravirt_write_msr(u32 msr, u64 val)
               /             \
              /               \
          wrmsrq(msr, val)    wrmsr(msr, low, high)

paravirt_write_msr() invokes cpu.write_msr(msr, val), an indirect layer
of pv_ops MSR write call:

    If on native:

            cpu.write_msr = native_write_msr

    If on Xen:

            cpu.write_msr = xen_write_msr

Therefore, refactor pv_cpu_ops.write_msr{_safe}() to accept an MSR value
in a single u64 argument, replacing the current dual u32 arguments.

No functional change intended.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20250427092027.1598740-14-xin@zytor.com
---
 arch/x86/include/asm/msr.h            | 35 +++++++++++---------------
 arch/x86/include/asm/paravirt.h       | 27 ++++++++++----------
 arch/x86/include/asm/paravirt_types.h |  4 +--
 arch/x86/kernel/kvmclock.c            |  2 +-
 arch/x86/kvm/svm/svm.c                | 15 ++---------
 arch/x86/xen/enlighten_pv.c           | 30 ++++++++--------------
 6 files changed, 46 insertions(+), 67 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index adef3ae..b244076 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -75,12 +75,12 @@ static __always_inline u64 __rdmsr(u32 msr)
 	return EAX_EDX_VAL(val, low, high);
 }
 
-static __always_inline void __wrmsr(u32 msr, u32 low, u32 high)
+static __always_inline void __wrmsrq(u32 msr, u64 val)
 {
 	asm volatile("1: wrmsr\n"
 		     "2:\n"
 		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
-		     : : "c" (msr), "a"(low), "d" (high) : "memory");
+		     : : "c" (msr), "a" ((u32)val), "d" ((u32)(val >> 32)) : "memory");
 }
 
 #define native_rdmsr(msr, val1, val2)			\
@@ -96,11 +96,10 @@ static __always_inline u64 native_rdmsrq(u32 msr)
 }
 
 #define native_wrmsr(msr, low, high)			\
-	__wrmsr(msr, low, high)
+	__wrmsrq((msr), (u64)(high) << 32 | (low))
 
 #define native_wrmsrq(msr, val)				\
-	__wrmsr((msr), (u32)((u64)(val)),		\
-		       (u32)((u64)(val) >> 32))
+	__wrmsrq((msr), (val))
 
 static inline u64 native_read_msr(u32 msr)
 {
@@ -129,11 +128,8 @@ static inline u64 native_read_msr_safe(u32 msr, int *err)
 }
 
 /* Can be uninlined because referenced by paravirt */
-static inline void notrace
-native_write_msr(u32 msr, u32 low, u32 high)
+static inline void notrace native_write_msr(u32 msr, u64 val)
 {
-	u64 val = (u64)high << 32 | low;
-
 	native_wrmsrq(msr, val);
 
 	if (tracepoint_enabled(write_msr))
@@ -141,8 +137,7 @@ native_write_msr(u32 msr, u32 low, u32 high)
 }
 
 /* Can be uninlined because referenced by paravirt */
-static inline int notrace
-native_write_msr_safe(u32 msr, u32 low, u32 high)
+static inline int notrace native_write_msr_safe(u32 msr, u64 val)
 {
 	int err;
 
@@ -150,10 +145,10 @@ native_write_msr_safe(u32 msr, u32 low, u32 high)
 		     "2:\n\t"
 		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_WRMSR_SAFE, %[err])
 		     : [err] "=a" (err)
-		     : "c" (msr), "0" (low), "d" (high)
+		     : "c" (msr), "0" ((u32)val), "d" ((u32)(val >> 32))
 		     : "memory");
 	if (tracepoint_enabled(write_msr))
-		do_trace_write_msr(msr, ((u64)high << 32 | low), err);
+		do_trace_write_msr(msr, val, err);
 	return err;
 }
 
@@ -189,7 +184,7 @@ do {								\
 
 static inline void wrmsr(u32 msr, u32 low, u32 high)
 {
-	native_write_msr(msr, low, high);
+	native_write_msr(msr, (u64)high << 32 | low);
 }
 
 #define rdmsrq(msr, val)			\
@@ -197,13 +192,13 @@ static inline void wrmsr(u32 msr, u32 low, u32 high)
 
 static inline void wrmsrq(u32 msr, u64 val)
 {
-	native_write_msr(msr, (u32)(val & 0xffffffffULL), (u32)(val >> 32));
+	native_write_msr(msr, val);
 }
 
 /* wrmsr with exception handling */
-static inline int wrmsr_safe(u32 msr, u32 low, u32 high)
+static inline int wrmsrq_safe(u32 msr, u64 val)
 {
-	return native_write_msr_safe(msr, low, high);
+	return native_write_msr_safe(msr, val);
 }
 
 /* rdmsr with exception handling */
@@ -247,11 +242,11 @@ static __always_inline void wrmsrns(u32 msr, u64 val)
 }
 
 /*
- * 64-bit version of wrmsr_safe():
+ * Dual u32 version of wrmsrq_safe():
  */
-static inline int wrmsrq_safe(u32 msr, u64 val)
+static inline int wrmsr_safe(u32 msr, u32 low, u32 high)
 {
-	return wrmsr_safe(msr, (u32)val,  (u32)(val >> 32));
+	return wrmsrq_safe(msr, (u64)high << 32 | low);
 }
 
 struct msr __percpu *msrs_alloc(void);
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index f272c4b..edf23bd 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -180,10 +180,9 @@ static inline u64 paravirt_read_msr(unsigned msr)
 	return PVOP_CALL1(u64, cpu.read_msr, msr);
 }
 
-static inline void paravirt_write_msr(unsigned msr,
-				      unsigned low, unsigned high)
+static inline void paravirt_write_msr(u32 msr, u64 val)
 {
-	PVOP_VCALL3(cpu.write_msr, msr, low, high);
+	PVOP_VCALL2(cpu.write_msr, msr, val);
 }
 
 static inline u64 paravirt_read_msr_safe(unsigned msr, int *err)
@@ -191,10 +190,9 @@ static inline u64 paravirt_read_msr_safe(unsigned msr, int *err)
 	return PVOP_CALL2(u64, cpu.read_msr_safe, msr, err);
 }
 
-static inline int paravirt_write_msr_safe(unsigned msr,
-					  unsigned low, unsigned high)
+static inline int paravirt_write_msr_safe(u32 msr, u64 val)
 {
-	return PVOP_CALL3(int, cpu.write_msr_safe, msr, low, high);
+	return PVOP_CALL2(int, cpu.write_msr_safe, msr, val);
 }
 
 #define rdmsr(msr, val1, val2)			\
@@ -204,22 +202,25 @@ do {						\
 	val2 = _l >> 32;			\
 } while (0)
 
-#define wrmsr(msr, val1, val2)			\
-do {						\
-	paravirt_write_msr(msr, val1, val2);	\
-} while (0)
+static __always_inline void wrmsr(u32 msr, u32 low, u32 high)
+{
+	paravirt_write_msr(msr, (u64)high << 32 | low);
+}
 
 #define rdmsrq(msr, val)			\
 do {						\
 	val = paravirt_read_msr(msr);		\
 } while (0)
 
-static inline void wrmsrq(unsigned msr, u64 val)
+static inline void wrmsrq(u32 msr, u64 val)
 {
-	wrmsr(msr, (u32)val, (u32)(val>>32));
+	paravirt_write_msr(msr, val);
 }
 
-#define wrmsr_safe(msr, a, b)	paravirt_write_msr_safe(msr, a, b)
+static inline int wrmsrq_safe(u32 msr, u64 val)
+{
+	return paravirt_write_msr_safe(msr, val);
+}
 
 /* rdmsr with exception handling */
 #define rdmsr_safe(msr, a, b)				\
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 631c306..78777b7 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -92,14 +92,14 @@ struct pv_cpu_ops {
 
 	/* Unsafe MSR operations.  These will warn or panic on failure. */
 	u64 (*read_msr)(unsigned int msr);
-	void (*write_msr)(unsigned int msr, unsigned low, unsigned high);
+	void (*write_msr)(u32 msr, u64 val);
 
 	/*
 	 * Safe MSR operations.
 	 * read sets err to 0 or -EIO.  write returns 0 or -EIO.
 	 */
 	u64 (*read_msr_safe)(unsigned int msr, int *err);
-	int (*write_msr_safe)(unsigned int msr, unsigned low, unsigned high);
+	int (*write_msr_safe)(u32 msr, u64 val);
 
 	u64 (*read_pmc)(int counter);
 
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 0af7979..ca0a49e 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -196,7 +196,7 @@ static void kvm_setup_secondary_clock(void)
 void kvmclock_disable(void)
 {
 	if (msr_kvm_system_time)
-		native_write_msr(msr_kvm_system_time, 0, 0);
+		native_write_msr(msr_kvm_system_time, 0);
 }
 
 static void __init kvmclock_init_mem(void)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c23f620..131f485 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -476,7 +476,6 @@ static void svm_inject_exception(struct kvm_vcpu *vcpu)
 
 static void svm_init_erratum_383(void)
 {
-	u32 low, high;
 	int err;
 	u64 val;
 
@@ -490,10 +489,7 @@ static void svm_init_erratum_383(void)
 
 	val |= (1ULL << 47);
 
-	low  = lower_32_bits(val);
-	high = upper_32_bits(val);
-
-	native_write_msr_safe(MSR_AMD64_DC_CFG, low, high);
+	native_write_msr_safe(MSR_AMD64_DC_CFG, val);
 
 	erratum_383_found = true;
 }
@@ -2168,17 +2164,12 @@ static bool is_erratum_383(void)
 
 	/* Clear MCi_STATUS registers */
 	for (i = 0; i < 6; ++i)
-		native_write_msr_safe(MSR_IA32_MCx_STATUS(i), 0, 0);
+		native_write_msr_safe(MSR_IA32_MCx_STATUS(i), 0);
 
 	value = native_read_msr_safe(MSR_IA32_MCG_STATUS, &err);
 	if (!err) {
-		u32 low, high;
-
 		value &= ~(1ULL << 2);
-		low    = lower_32_bits(value);
-		high   = upper_32_bits(value);
-
-		native_write_msr_safe(MSR_IA32_MCG_STATUS, low, high);
+		native_write_msr_safe(MSR_IA32_MCG_STATUS, value);
 	}
 
 	/* Flush tlb to evict multi-match entries */
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 97f7894..4fbe0bd 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1111,10 +1111,8 @@ static u64 xen_do_read_msr(unsigned int msr, int *err)
 	return val;
 }
 
-static void set_seg(u32 which, u32 low, u32 high)
+static void set_seg(u32 which, u64 base)
 {
-	u64 base = ((u64)high << 32) | low;
-
 	if (HYPERVISOR_set_segment_base(which, base))
 		WARN(1, "Xen set_segment_base(%u, %llx) failed\n", which, base);
 }
@@ -1124,22 +1122,19 @@ static void set_seg(u32 which, u32 low, u32 high)
  * With err == NULL write_msr() semantics are selected.
  * Supplying an err pointer requires err to be pre-initialized with 0.
  */
-static void xen_do_write_msr(unsigned int msr, unsigned int low,
-			     unsigned int high, int *err)
+static void xen_do_write_msr(u32 msr, u64 val, int *err)
 {
-	u64 val;
-
 	switch (msr) {
 	case MSR_FS_BASE:
-		set_seg(SEGBASE_FS, low, high);
+		set_seg(SEGBASE_FS, val);
 		break;
 
 	case MSR_KERNEL_GS_BASE:
-		set_seg(SEGBASE_GS_USER, low, high);
+		set_seg(SEGBASE_GS_USER, val);
 		break;
 
 	case MSR_GS_BASE:
-		set_seg(SEGBASE_GS_KERNEL, low, high);
+		set_seg(SEGBASE_GS_KERNEL, val);
 		break;
 
 	case MSR_STAR:
@@ -1155,15 +1150,13 @@ static void xen_do_write_msr(unsigned int msr, unsigned int low,
 		break;
 
 	default:
-		val = (u64)high << 32 | low;
-
 		if (pmu_msr_chk_emulated(msr, &val, false))
 			return;
 
 		if (err)
-			*err = native_write_msr_safe(msr, low, high);
+			*err = native_write_msr_safe(msr, val);
 		else
-			native_write_msr(msr, low, high);
+			native_write_msr(msr, val);
 	}
 }
 
@@ -1172,12 +1165,11 @@ static u64 xen_read_msr_safe(unsigned int msr, int *err)
 	return xen_do_read_msr(msr, err);
 }
 
-static int xen_write_msr_safe(unsigned int msr, unsigned int low,
-			      unsigned int high)
+static int xen_write_msr_safe(u32 msr, u64 val)
 {
 	int err = 0;
 
-	xen_do_write_msr(msr, low, high, &err);
+	xen_do_write_msr(msr, val, &err);
 
 	return err;
 }
@@ -1189,11 +1181,11 @@ static u64 xen_read_msr(unsigned int msr)
 	return xen_do_read_msr(msr, xen_msr_safe ? &err : NULL);
 }
 
-static void xen_write_msr(unsigned int msr, unsigned low, unsigned high)
+static void xen_write_msr(u32 msr, u64 val)
 {
 	int err;
 
-	xen_do_write_msr(msr, low, high, xen_msr_safe ? &err : NULL);
+	xen_do_write_msr(msr, val, xen_msr_safe ? &err : NULL);
 }
 
 /* This is called once we have the cpu_possible_mask */

