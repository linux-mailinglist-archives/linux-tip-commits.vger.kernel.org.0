Return-Path: <linux-tip-commits+bounces-7970-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E04AD1BD67
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 01:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EB5F302E876
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 00:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADCE224244;
	Wed, 14 Jan 2026 00:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tdF2Go2N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IOOgScZY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA3F1A08AF;
	Wed, 14 Jan 2026 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768351494; cv=none; b=KPbXSCBq+f+woIWXcQSvgiDiCZIWub6lG3//OQWcftpZ+MtiHtRd1bqUXEUfzW75aPQhiW6cKg+3zk0bDAZ7QE3JVIJU8NqTfjp2t1g7r3nFyufbtNYvJYy00T2YxbqpGqf6zudeAWi61AMsktmOFcpQFo6/E82Jdq18dKh+LCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768351494; c=relaxed/simple;
	bh=2AacHDbFAeAg1WEiPvE9ydDgdUOK9P3ajZPvlVEcxPI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WCF+FXB7QhF29pOnOPH2pr1LiGWzldT0De1WYaUMz192rDRKQpnryO3SfCc23NmKOlLdP/JlgTTsI0rPY9mRn/0ubgjCJrJoR7d+blqLVF7T9lktc5iiyJEQWJdBEcVLf0pfUlUAGdhP/3khCY1CxskALcReqEoRvgM5rWh7KzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tdF2Go2N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IOOgScZY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 00:44:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768351491;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eTddaMO9bH16WaFx6WPJil2o0JWJSUrzIjimuMy3uI=;
	b=tdF2Go2NwGB/H5OpPo7nriQ0+jRXtJKthTbExZ4dWRaf5p0IJZqr/rNcVpFYTdpWDILllY
	kZQlruis3RSGOA8MZwrommgX3cjtnnUAPP9CZ26PtN/UujMQQdEkyxn1OcBzpJOy/DO1fY
	iZ++9h2enV2NI+6HFlCxtZJLw0HH8nhlMrVWU01XhwJa0dk3OSE3gnpTWxbBfERiURopGN
	Orj5Sjy6GzwfXLGmuxNZgXCRjMOmPF2V5brrOAjh26zT5CLPyvVWWumrvdQmmT3kf1j0u1
	LkmM9f0EUFfWjCHkewxxtwQNlCqHw+jlwqMlnDhUbj2PA1WMGtUZL4NAk/7LuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768351491;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eTddaMO9bH16WaFx6WPJil2o0JWJSUrzIjimuMy3uI=;
	b=IOOgScZYGLx9ypcJDPp1UxODF0M4b3xsceS3wG3USS5gWF76uQ8O6mm4ss1V/vEcICvfh/
	rytbWpsmsxGGhlCw==
From: "tip-bot2 for H. Peter Anvin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/cpufeature: Replace X86_FEATURE_SYSENTER32 with
 X86_FEATURE_SYSFAST32
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251216212606.1325678-10-hpa@zytor.com>
References: <20251216212606.1325678-10-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176835148982.510.2296104108621235647.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     f49ecf5e110ab0ed255ddea5e321689faf4e50e6
Gitweb:        https://git.kernel.org/tip/f49ecf5e110ab0ed255ddea5e321689faf4=
e50e6
Author:        H. Peter Anvin <hpa@zytor.com>
AuthorDate:    Tue, 16 Dec 2025 13:26:03 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 13 Jan 2026 16:37:58 -08:00

x86/cpufeature: Replace X86_FEATURE_SYSENTER32 with X86_FEATURE_SYSFAST32

In most cases, the use of "fast 32-bit system call" depends either on
X86_FEATURE_SEP or X86_FEATURE_SYSENTER32 || X86_FEATURE_SYSCALL32.
However, nearly all the logic for both is identical.

Define X86_FEATURE_SYSFAST32 which indicates that *either* SYSENTER32 or
SYSCALL32 should be used, for either 32- or 64-bit kernels.  This
defaults to SYSENTER; use SYSCALL if the SYSCALL32 bit is also set.

As this removes ALL existing uses of X86_FEATURE_SYSENTER32, which is
a kernel-only synthetic feature bit, simply remove it and replace it
with X86_FEATURE_SYSFAST32.

This leaves an unused alternative for a true 32-bit kernel, but that
should really not matter in any way.

The clearing of X86_FEATURE_SYSCALL32 can be removed once the patches
for automatically clearing disabled features has been merged.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251216212606.1325678-10-hpa@zytor.com
---
 arch/x86/Kconfig.cpufeatures             |  8 +++++++-
 arch/x86/entry/vdso/vdso32/system_call.S |  8 +------
 arch/x86/include/asm/cpufeatures.h       |  2 +-
 arch/x86/kernel/cpu/centaur.c            |  3 +--
 arch/x86/kernel/cpu/common.c             |  8 +++++++-
 arch/x86/kernel/cpu/intel.c              |  4 +---
 arch/x86/kernel/cpu/zhaoxin.c            |  4 +---
 arch/x86/kernel/fred.c                   |  2 +-
 arch/x86/xen/setup.c                     | 28 ++++++++++++++---------
 arch/x86/xen/smp_pv.c                    |  5 +---
 arch/x86/xen/xen-ops.h                   |  1 +-
 11 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
index 733d5af..423ac79 100644
--- a/arch/x86/Kconfig.cpufeatures
+++ b/arch/x86/Kconfig.cpufeatures
@@ -56,6 +56,10 @@ config X86_REQUIRED_FEATURE_MOVBE
 	def_bool y
 	depends on MATOM
=20
+config X86_REQUIRED_FEATURE_SYSFAST32
+	def_bool y
+	depends on X86_64 && !X86_FRED
+
 config X86_REQUIRED_FEATURE_CPUID
 	def_bool y
 	depends on X86_64
@@ -120,6 +124,10 @@ config X86_DISABLED_FEATURE_CENTAUR_MCR
 	def_bool y
 	depends on X86_64
=20
+config X86_DISABLED_FEATURE_SYSCALL32
+	def_bool y
+	depends on !X86_64
+
 config X86_DISABLED_FEATURE_PCID
 	def_bool y
 	depends on !X86_64
diff --git a/arch/x86/entry/vdso/vdso32/system_call.S b/arch/x86/entry/vdso/v=
dso32/system_call.S
index 2a15634..7b1c0f1 100644
--- a/arch/x86/entry/vdso/vdso32/system_call.S
+++ b/arch/x86/entry/vdso/vdso32/system_call.S
@@ -52,13 +52,9 @@ __kernel_vsyscall:
 	#define SYSENTER_SEQUENCE	"movl %esp, %ebp; sysenter"
 	#define SYSCALL_SEQUENCE	"movl %ecx, %ebp; syscall"
=20
-#ifdef BUILD_VDSO32_64
 	/* If SYSENTER (Intel) or SYSCALL32 (AMD) is available, use it. */
-	ALTERNATIVE_2 "", SYSENTER_SEQUENCE, X86_FEATURE_SYSENTER32, \
-	                  SYSCALL_SEQUENCE,  X86_FEATURE_SYSCALL32
-#else
-	ALTERNATIVE "", SYSENTER_SEQUENCE, X86_FEATURE_SEP
-#endif
+	ALTERNATIVE_2 "", SYSENTER_SEQUENCE, X86_FEATURE_SYSFAST32, \
+			  SYSCALL_SEQUENCE,  X86_FEATURE_SYSCALL32
=20
 	/* Enter using int $0x80 */
 	int	$0x80
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufea=
tures.h
index c3b53be..63b0f9a 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -84,7 +84,7 @@
 #define X86_FEATURE_PEBS		( 3*32+12) /* "pebs" Precise-Event Based Sampling =
*/
 #define X86_FEATURE_BTS			( 3*32+13) /* "bts" Branch Trace Store */
 #define X86_FEATURE_SYSCALL32		( 3*32+14) /* syscall in IA32 userspace */
-#define X86_FEATURE_SYSENTER32		( 3*32+15) /* sysenter in IA32 userspace */
+#define X86_FEATURE_SYSFAST32		( 3*32+15) /* sysenter/syscall in IA32 usersp=
ace */
 #define X86_FEATURE_REP_GOOD		( 3*32+16) /* "rep_good" REP microcode works w=
ell */
 #define X86_FEATURE_AMD_LBR_V2		( 3*32+17) /* "amd_lbr_v2" AMD Last Branch R=
ecord Extension Version 2 */
 #define X86_FEATURE_CLEAR_CPU_BUF	( 3*32+18) /* Clear CPU buffers using VERW=
 */
diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index a3b55db..9833f83 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -102,9 +102,6 @@ static void early_init_centaur(struct cpuinfo_x86 *c)
 	    (c->x86 >=3D 7))
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
=20
-#ifdef CONFIG_X86_64
-	set_cpu_cap(c, X86_FEATURE_SYSENTER32);
-#endif
 	if (c->x86_power & (1 << 8)) {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index e7ab22f..1c3261c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1068,6 +1068,9 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 	init_scattered_cpuid_features(c);
 	init_speculation_control(c);
=20
+	if (IS_ENABLED(CONFIG_X86_64) || cpu_has(c, X86_FEATURE_SEP))
+		set_cpu_cap(c, X86_FEATURE_SYSFAST32);
+
 	/*
 	 * Clear/Set all flags overridden by options, after probe.
 	 * This needs to happen each time we re-probe, which may happen
@@ -1813,6 +1816,11 @@ static void __init early_identify_cpu(struct cpuinfo_x=
86 *c)
 	 * that it can't be enabled in 32-bit mode.
 	 */
 	setup_clear_cpu_cap(X86_FEATURE_PCID);
+
+	/*
+	 * Never use SYSCALL on a 32-bit kernel
+	 */
+	setup_clear_cpu_cap(X86_FEATURE_SYSCALL32);
 #endif
=20
 	/*
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 98ae4c3..646ff33 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -236,9 +236,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 		clear_cpu_cap(c, X86_FEATURE_PSE);
 	}
=20
-#ifdef CONFIG_X86_64
-	set_cpu_cap(c, X86_FEATURE_SYSENTER32);
-#else
+#ifndef CONFIG_X86_64
 	/* Netburst reports 64 bytes clflush size, but does IO in 128 bytes */
 	if (c->x86 =3D=3D 15 && c->x86_cache_alignment =3D=3D 64)
 		c->x86_cache_alignment =3D 128;
diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
index 89b1c8a..031379b 100644
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -59,9 +59,7 @@ static void early_init_zhaoxin(struct cpuinfo_x86 *c)
 {
 	if (c->x86 >=3D 0x6)
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
-#ifdef CONFIG_X86_64
-	set_cpu_cap(c, X86_FEATURE_SYSENTER32);
-#endif
+
 	if (c->x86_power & (1 << 8)) {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
diff --git a/arch/x86/kernel/fred.c b/arch/x86/kernel/fred.c
index 816187d..e736b19 100644
--- a/arch/x86/kernel/fred.c
+++ b/arch/x86/kernel/fred.c
@@ -68,7 +68,7 @@ void cpu_init_fred_exceptions(void)
 	idt_invalidate();
=20
 	/* Use int $0x80 for 32-bit system calls in FRED mode */
-	setup_clear_cpu_cap(X86_FEATURE_SYSENTER32);
+	setup_clear_cpu_cap(X86_FEATURE_SYSFAST32);
 	setup_clear_cpu_cap(X86_FEATURE_SYSCALL32);
 }
=20
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index 3823e52..ac8021c 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -990,13 +990,6 @@ static int register_callback(unsigned type, const void *=
func)
 	return HYPERVISOR_callback_op(CALLBACKOP_register, &callback);
 }
=20
-void xen_enable_sysenter(void)
-{
-	if (cpu_feature_enabled(X86_FEATURE_SYSENTER32) &&
-	    register_callback(CALLBACKTYPE_sysenter, xen_entry_SYSENTER_compat))
-		setup_clear_cpu_cap(X86_FEATURE_SYSENTER32);
-}
-
 void xen_enable_syscall(void)
 {
 	int ret;
@@ -1008,11 +1001,27 @@ void xen_enable_syscall(void)
 		   mechanism for syscalls. */
 	}
=20
-	if (cpu_feature_enabled(X86_FEATURE_SYSCALL32) &&
-	    register_callback(CALLBACKTYPE_syscall32, xen_entry_SYSCALL_compat))
+	if (!cpu_feature_enabled(X86_FEATURE_SYSFAST32))
+		return;
+
+	if (cpu_feature_enabled(X86_FEATURE_SYSCALL32)) {
+		/* Use SYSCALL32 */
+		ret =3D register_callback(CALLBACKTYPE_syscall32,
+					xen_entry_SYSCALL_compat);
+
+	} else {
+		/* Use SYSENTER32 */
+		ret =3D register_callback(CALLBACKTYPE_sysenter,
+					xen_entry_SYSENTER_compat);
+	}
+
+	if (ret) {
 		setup_clear_cpu_cap(X86_FEATURE_SYSCALL32);
+		setup_clear_cpu_cap(X86_FEATURE_SYSFAST32);
+	}
 }
=20
+
 static void __init xen_pvmmu_arch_setup(void)
 {
 	HYPERVISOR_vm_assist(VMASST_CMD_enable, VMASST_TYPE_writable_pagetables);
@@ -1022,7 +1031,6 @@ static void __init xen_pvmmu_arch_setup(void)
 	    register_callback(CALLBACKTYPE_failsafe, xen_failsafe_callback))
 		BUG();
=20
-	xen_enable_sysenter();
 	xen_enable_syscall();
 }
=20
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 9bb8ff8..c40f326 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -65,10 +65,9 @@ static void cpu_bringup(void)
 	touch_softlockup_watchdog();
=20
 	/* PVH runs in ring 0 and allows us to do native syscalls. Yay! */
-	if (!xen_feature(XENFEAT_supervisor_mode_kernel)) {
-		xen_enable_sysenter();
+	if (!xen_feature(XENFEAT_supervisor_mode_kernel))
 		xen_enable_syscall();
-	}
+
 	cpu =3D smp_processor_id();
 	identify_secondary_cpu(cpu);
 	set_cpu_sibling_map(cpu);
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 090349b..f6c331b 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -60,7 +60,6 @@ phys_addr_t __init xen_find_free_area(phys_addr_t size);
 char * __init xen_memory_setup(void);
 void __init xen_arch_setup(void);
 void xen_banner(void);
-void xen_enable_sysenter(void);
 void xen_enable_syscall(void);
 void xen_vcpu_restore(void);
=20

