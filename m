Return-Path: <linux-tip-commits+bounces-6292-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E1FB2D917
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 11:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD1E5A50D8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 09:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DF32EBB85;
	Wed, 20 Aug 2025 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bbs/Hz3y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SoU4dKKK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5502EB85C;
	Wed, 20 Aug 2025 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682759; cv=none; b=P8+VhVl2kiJCRIVyvoY5GtQcY/dESO2cqdruF5S46tkNaNiW9bMbpTUIOGTP5xZLCFfhXsXkI7u1myYZc49EIwbut+DOIWICXSaHEiq+h2tujIlASFIc61nLcqYU7UHVQCgJBOMHUymjQ+WaMBukfKPNV8Pe3LlGoBhP4koc1rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682759; c=relaxed/simple;
	bh=ne6BbK3vBBo058PwvGbghlmt5YqGoBQCMdzMyJdAsHc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UYDfpwC61aDlMt//c1qUiZknTPeFsNQQi+lJlKhOXXxy6OzpL+83vdLAVjEJcBeo5OrPPNmq9xRHWFbq1F+9wBY2IvZhfpMchi0dCD0dP+l+epQV8GRwx0QJwyKb9WQcfEw7loufVvgxuPVlMnwdyZdoZ0DrSv0nsPgTUXFQ6FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bbs/Hz3y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SoU4dKKK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 09:39:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755682751;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHN1AwkPiU2VW3xOYUR8IK4wyMxlxJyp+8tvrYSaSbo=;
	b=bbs/Hz3yvDKVtssViexWQy7mQ616+SQLncjHaABLX1D1zlmTTHuBcAAO9GcvvkO2p9n42J
	vW+kbNbZ9ZM1+2IoDS5tF16bmyiIsZXhOzxVk1ipDx5XfRceuQJc6qdcJ4TmnlKixnFO7l
	/FsA6skRgb+M8ey4TBfyqRRMdx9N7AK/9fpmDNanPQH5qld8KwmZIAr/XYFi3jNQkUIiml
	5lNOM4BheeuIEkSo5+tldwCxKuP5lcrwGCWtwoMrqhQ2E7M7jYRcN0J90dVyu5mAtvZ1+o
	euzQ2vJ9Id3qqXsw+ASdUSlhHUEfGcqNCxF55s53NfynBdEs0U7NOx8feoDjoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755682751;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHN1AwkPiU2VW3xOYUR8IK4wyMxlxJyp+8tvrYSaSbo=;
	b=SoU4dKKKscSSw5JyiT1Is/mOKEsoyF2BE9YxT/ho5zJmM7RjJRubbmA+M1uuZqH9fyVgNg
	o+XC3Kw8ASGVkRBg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/hyperv: Clean up hv_do_hypercall()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250714103440.897136093@infradead.org>
References: <20250714103440.897136093@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175568275057.1420.16211584514250757101.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     0e20f1f4c2cb77130cfe903a058a08883645dc4b
Gitweb:        https://git.kernel.org/tip/0e20f1f4c2cb77130cfe903a058a0888364=
5dc4b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 12 Apr 2025 13:55:49 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 18 Aug 2025 14:23:07 +02:00

x86/hyperv: Clean up hv_do_hypercall()

What used to be a simple few instructions has turned into a giant mess
(for x86_64). Not only does it use static_branch wrong, it mixes it
with dynamic branches for no apparent reason.

Notably it uses static_branch through an out-of-line function call,
which completely defeats the purpose, since instead of a simple
JMP/NOP site, you get a CALL+RET+TEST+Jcc sequence in return, which is
absolutely idiotic.

Add to that a dynamic test of hyperv_paravisor_present, something
which is set once and never changed.

Replace all this idiocy with a single direct function call to the
right hypercall variant.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lkml.kernel.org/r/20250714103440.897136093@infradead.org
---
 arch/x86/hyperv/hv_init.c       |  20 +++++-
 arch/x86/hyperv/ivm.c           |  15 +++-
 arch/x86/include/asm/mshyperv.h | 137 +++++++++----------------------
 arch/x86/kernel/cpu/mshyperv.c  |  19 ++--
 4 files changed, 89 insertions(+), 102 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index afdbda2..5ef1e64 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -37,7 +37,27 @@
 #include <linux/export.h>
=20
 void *hv_hypercall_pg;
+
+#ifdef CONFIG_X86_64
+u64 hv_std_hypercall(u64 control, u64 param1, u64 param2)
+{
+	u64 hv_status;
+
+	if (!hv_hypercall_pg)
+		return U64_MAX;
+
+	register u64 __r8 asm("r8") =3D param2;
+	asm volatile (CALL_NOSPEC
+		      : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
+		        "+c" (control), "+d" (param1), "+r" (__r8)
+		      : THUNK_TARGET(hv_hypercall_pg)
+		      : "cc", "memory", "r9", "r10", "r11");
+
+	return hv_status;
+}
+#else
 EXPORT_SYMBOL_GPL(hv_hypercall_pg);
+#endif
=20
 union hv_ghcb * __percpu *hv_ghcb_pg;
=20
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index ade6c66..21042fa 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -385,9 +385,23 @@ int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, =
unsigned int cpu)
 	return ret;
 }
=20
+u64 hv_snp_hypercall(u64 control, u64 param1, u64 param2)
+{
+	u64 hv_status;
+
+	register u64 __r8 asm("r8") =3D param2;
+	asm volatile("vmmcall"
+		     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
+		       "+c" (control), "+d" (param1), "+r" (__r8)
+		     : : "cc", "memory", "r9", "r10", "r11");
+
+	return hv_status;
+}
+
 #else
 static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
 static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
+u64 hv_snp_hypercall(u64 control, u64 param1, u64 param2) { return U64_MAX; }
 #endif /* CONFIG_AMD_MEM_ENCRYPT */
=20
 #ifdef CONFIG_INTEL_TDX_GUEST
@@ -437,6 +451,7 @@ u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
 #else
 static inline void hv_tdx_msr_write(u64 msr, u64 value) {}
 static inline void hv_tdx_msr_read(u64 msr, u64 *value) {}
+u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2) { return U64_MAX; }
 #endif /* CONFIG_INTEL_TDX_GUEST */
=20
 #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index abc4659..605abd0 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -6,6 +6,7 @@
 #include <linux/nmi.h>
 #include <linux/msi.h>
 #include <linux/io.h>
+#include <linux/static_call.h>
 #include <asm/nospec-branch.h>
 #include <asm/paravirt.h>
 #include <asm/msr.h>
@@ -39,16 +40,21 @@ static inline unsigned char hv_get_nmi_reason(void)
 	return 0;
 }
=20
-#if IS_ENABLED(CONFIG_HYPERV)
-extern bool hyperv_paravisor_present;
+extern u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
+extern u64 hv_snp_hypercall(u64 control, u64 param1, u64 param2);
+extern u64 hv_std_hypercall(u64 control, u64 param1, u64 param2);
=20
+#if IS_ENABLED(CONFIG_HYPERV)
 extern void *hv_hypercall_pg;
=20
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
=20
 bool hv_isolation_type_snp(void);
 bool hv_isolation_type_tdx(void);
-u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
+
+#ifdef CONFIG_X86_64
+DECLARE_STATIC_CALL(hv_hypercall, hv_std_hypercall);
+#endif
=20
 /*
  * DEFAULT INIT GPAT and SEGMENT LIMIT value in struct VMSA
@@ -65,37 +71,15 @@ static inline u64 hv_do_hypercall(u64 control, void *inpu=
t, void *output)
 {
 	u64 input_address =3D input ? virt_to_phys(input) : 0;
 	u64 output_address =3D output ? virt_to_phys(output) : 0;
-	u64 hv_status;
=20
 #ifdef CONFIG_X86_64
-	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
-		return hv_tdx_hypercall(control, input_address, output_address);
-
-	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
-		__asm__ __volatile__("mov %[output_address], %%r8\n"
-				     "vmmcall"
-				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
-				       "+c" (control), "+d" (input_address)
-				     : [output_address] "r" (output_address)
-				     : "cc", "memory", "r8", "r9", "r10", "r11");
-		return hv_status;
-	}
-
-	if (!hv_hypercall_pg)
-		return U64_MAX;
-
-	__asm__ __volatile__("mov %[output_address], %%r8\n"
-			     CALL_NOSPEC
-			     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
-			       "+c" (control), "+d" (input_address)
-			     : [output_address] "r" (output_address),
-			       THUNK_TARGET(hv_hypercall_pg)
-			     : "cc", "memory", "r8", "r9", "r10", "r11");
+	return static_call_mod(hv_hypercall)(control, input_address, output_address=
);
 #else
 	u32 input_address_hi =3D upper_32_bits(input_address);
 	u32 input_address_lo =3D lower_32_bits(input_address);
 	u32 output_address_hi =3D upper_32_bits(output_address);
 	u32 output_address_lo =3D lower_32_bits(output_address);
+	u64 hv_status;
=20
 	if (!hv_hypercall_pg)
 		return U64_MAX;
@@ -108,48 +92,30 @@ static inline u64 hv_do_hypercall(u64 control, void *inp=
ut, void *output)
 			       "D"(output_address_hi), "S"(output_address_lo),
 			       THUNK_TARGET(hv_hypercall_pg)
 			     : "cc", "memory");
-#endif /* !x86_64 */
 	return hv_status;
+#endif /* !x86_64 */
 }
=20
 /* Fast hypercall with 8 bytes of input and no output */
 static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
 {
-	u64 hv_status;
-
 #ifdef CONFIG_X86_64
-	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
-		return hv_tdx_hypercall(control, input1, 0);
-
-	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
-		__asm__ __volatile__(
-				"vmmcall"
-				: "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
-				"+c" (control), "+d" (input1)
-				:: "cc", "r8", "r9", "r10", "r11");
-	} else {
-		__asm__ __volatile__(CALL_NOSPEC
-				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
-				       "+c" (control), "+d" (input1)
-				     : THUNK_TARGET(hv_hypercall_pg)
-				     : "cc", "r8", "r9", "r10", "r11");
-	}
+	return static_call_mod(hv_hypercall)(control, input1, 0);
 #else
-	{
-		u32 input1_hi =3D upper_32_bits(input1);
-		u32 input1_lo =3D lower_32_bits(input1);
-
-		__asm__ __volatile__ (CALL_NOSPEC
-				      : "=3DA"(hv_status),
-					"+c"(input1_lo),
-					ASM_CALL_CONSTRAINT
-				      :	"A" (control),
-					"b" (input1_hi),
-					THUNK_TARGET(hv_hypercall_pg)
-				      : "cc", "edi", "esi");
-	}
-#endif
+	u32 input1_hi =3D upper_32_bits(input1);
+	u32 input1_lo =3D lower_32_bits(input1);
+	u64 hv_status;
+
+	__asm__ __volatile__ (CALL_NOSPEC
+			      : "=3DA"(hv_status),
+			      "+c"(input1_lo),
+			      ASM_CALL_CONSTRAINT
+			      :	"A" (control),
+			      "b" (input1_hi),
+			      THUNK_TARGET(hv_hypercall_pg)
+			      : "cc", "edi", "esi");
 	return hv_status;
+#endif
 }
=20
 static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
@@ -162,45 +128,24 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u64 i=
nput1)
 /* Fast hypercall with 16 bytes of input */
 static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input=
2)
 {
-	u64 hv_status;
-
 #ifdef CONFIG_X86_64
-	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
-		return hv_tdx_hypercall(control, input1, input2);
-
-	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
-		__asm__ __volatile__("mov %[input2], %%r8\n"
-				     "vmmcall"
-				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
-				       "+c" (control), "+d" (input1)
-				     : [input2] "r" (input2)
-				     : "cc", "r8", "r9", "r10", "r11");
-	} else {
-		__asm__ __volatile__("mov %[input2], %%r8\n"
-				     CALL_NOSPEC
-				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
-				       "+c" (control), "+d" (input1)
-				     : [input2] "r" (input2),
-				       THUNK_TARGET(hv_hypercall_pg)
-				     : "cc", "r8", "r9", "r10", "r11");
-	}
+	return static_call_mod(hv_hypercall)(control, input1, input2);
 #else
-	{
-		u32 input1_hi =3D upper_32_bits(input1);
-		u32 input1_lo =3D lower_32_bits(input1);
-		u32 input2_hi =3D upper_32_bits(input2);
-		u32 input2_lo =3D lower_32_bits(input2);
-
-		__asm__ __volatile__ (CALL_NOSPEC
-				      : "=3DA"(hv_status),
-					"+c"(input1_lo), ASM_CALL_CONSTRAINT
-				      :	"A" (control), "b" (input1_hi),
-					"D"(input2_hi), "S"(input2_lo),
-					THUNK_TARGET(hv_hypercall_pg)
-				      : "cc");
-	}
-#endif
+	u32 input1_hi =3D upper_32_bits(input1);
+	u32 input1_lo =3D lower_32_bits(input1);
+	u32 input2_hi =3D upper_32_bits(input2);
+	u32 input2_lo =3D lower_32_bits(input2);
+	u64 hv_status;
+
+	__asm__ __volatile__ (CALL_NOSPEC
+			      : "=3DA"(hv_status),
+			      "+c"(input1_lo), ASM_CALL_CONSTRAINT
+			      :	"A" (control), "b" (input1_hi),
+			      "D"(input2_hi), "S"(input2_lo),
+			      THUNK_TARGET(hv_hypercall_pg)
+			      : "cc");
 	return hv_status;
+#endif
 }
=20
 static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index c78f860..3c71eff 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -38,10 +38,6 @@
 bool hv_nested;
 struct ms_hyperv_info ms_hyperv;
=20
-/* Used in modules via hv_do_hypercall(): see arch/x86/include/asm/mshyperv.=
h */
-bool hyperv_paravisor_present __ro_after_init;
-EXPORT_SYMBOL_GPL(hyperv_paravisor_present);
-
 #if IS_ENABLED(CONFIG_HYPERV)
 static inline unsigned int hv_get_nested_msr(unsigned int reg)
 {
@@ -288,8 +284,18 @@ static void __init x86_setup_ops_for_tsc_pg_clock(void)
 	old_restore_sched_clock_state =3D x86_platform.restore_sched_clock_state;
 	x86_platform.restore_sched_clock_state =3D hv_restore_sched_clock_state;
 }
+
+#ifdef CONFIG_X86_64
+DEFINE_STATIC_CALL(hv_hypercall, hv_std_hypercall);
+EXPORT_STATIC_CALL_TRAMP_GPL(hv_hypercall);
+#define hypercall_update(hc) static_call_update(hv_hypercall, hc)
+#endif
 #endif /* CONFIG_HYPERV */
=20
+#ifndef hypercall_update
+#define hypercall_update(hc) (void)hc
+#endif
+
 static uint32_t  __init ms_hyperv_platform(void)
 {
 	u32 eax;
@@ -484,14 +490,14 @@ static void __init ms_hyperv_init_platform(void)
 			ms_hyperv.shared_gpa_boundary =3D
 				BIT_ULL(ms_hyperv.shared_gpa_boundary_bits);
=20
-		hyperv_paravisor_present =3D !!ms_hyperv.paravisor_present;
-
 		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
 			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
=20
=20
 		if (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_SNP) {
 			static_branch_enable(&isolation_type_snp);
+			if (!ms_hyperv.paravisor_present)
+				hypercall_update(hv_snp_hypercall);
 		} else if (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_TDX) {
 			static_branch_enable(&isolation_type_tdx);
=20
@@ -499,6 +505,7 @@ static void __init ms_hyperv_init_platform(void)
 			ms_hyperv.hints &=3D ~HV_X64_APIC_ACCESS_RECOMMENDED;
=20
 			if (!ms_hyperv.paravisor_present) {
+				hypercall_update(hv_tdx_hypercall);
 				/*
 				 * Mark the Hyper-V TSC page feature as disabled
 				 * in a TDX VM without paravisor so that the

