Return-Path: <linux-tip-commits+bounces-8003-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F39D1F63D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 15:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C7143019BB2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 14:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24AB21D585;
	Wed, 14 Jan 2026 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xUNCybJC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="30OZa91h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B5825F7A5;
	Wed, 14 Jan 2026 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400556; cv=none; b=HcoK1LgbbAbgqC9rqsHglszrXOiEQipMMm4zk4MRIZApabfnG6UAiCEzES/bYbfhwZ15iYnefzFkDJ95Crnv0GM8YgIfLZ/uMbj3dSV3nXXG5+JSor7x/x3x3EiEVidAWNuWfcM0U8WU8Xp6YL3aMI36jhOqqx+wLiAhiWV+3dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400556; c=relaxed/simple;
	bh=+E0x/IMVmrxp9364nLh4bkKCwG89KEviPiHAOaSDqAc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r8D/kVeMYhZXX06gKKuGVZBvNL9uc2lutvaMz7Wo2A1e7S5tMZDwWz1iKSeyBPuYSUIFIoyKW/YD9LtlJ67xwYyK+fekzSGDk/z9AwsLyIIvX/W+NyITR4WpOr37wcnE8q+zUwFQfZJuEP/v88Y3mdacGLj+TRSLhP0llzIDX8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xUNCybJC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=30OZa91h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 14:22:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768400553;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v97oomNKnFdioYkxj6J29Y0LeFt5LmnJ3tKmC8dwYF0=;
	b=xUNCybJCY+Aljw1yfqrDhl7Rqb3GFO2ZCwLop59brD7PGeSZtbMkeP8FCrFuDPOTxanuo9
	I1AoM2CxIX0kOiMkcqnStPnNGT+YjOeYxeih9KffzUHOPoIED4jZX8/t/AWt4tZI7aBFO+
	QLSPh7U1dUNKCma4IuzxojorD9n8ONDZ+5pLhGbnWAFEyaktyJtJiZqFQ4equp1W7fNkIi
	H7ypN2cjLZmyjeX3qLgIYHCz2K9fjv/LoI9my+LRRnkIy4IN1n6RaM7AfZoKpgNNoQ8/4H
	TV6B1b95Xe2M8rUIEvnAOLU/Wn/lR9IEpf9q7HuaGTbClYJDd3t15vDKaE5BDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768400553;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v97oomNKnFdioYkxj6J29Y0LeFt5LmnJ3tKmC8dwYF0=;
	b=30OZa91h2rsnZdbOyBi5qSXnp++0neCLVrwaC31jfTYpY2sdR45YNx9ol19MVAYEyFjvCx
	KQbtD8ZbufV3pJBg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Allow loader debugging to be
 enabled on baremetal too
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260108165028.27417-1-bp@kernel.org>
References: <20260108165028.27417-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176840055231.510.5594008026440508174.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     ac44a110c18ad7bd9de0b809e861479ba97157d2
Gitweb:        https://git.kernel.org/tip/ac44a110c18ad7bd9de0b809e861479ba97=
157d2
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 06 Oct 2025 17:50:10 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 14 Jan 2026 14:46:44 +01:00

x86/microcode/AMD: Allow loader debugging to be enabled on baremetal too

Debugging the loader on baremetal does make sense, so enable it there
too.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20260108165028.27417-1-bp@kernel.org
---
 arch/x86/Kconfig                         |  8 +++++---
 arch/x86/kernel/cpu/microcode/amd.c      |  4 ++--
 arch/x86/kernel/cpu/microcode/core.c     | 16 ++++++++++++----
 arch/x86/kernel/cpu/microcode/internal.h |  1 +
 4 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8052729..c105937 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1366,10 +1366,12 @@ config MICROCODE_DBG
 	default n
 	depends on MICROCODE
 	help
-	  Enable code which allows for debugging the microcode loader in
-	  a guest. Meaning the patch loading is simulated but everything else
+	  Enable code which allows to debug the microcode loader. When running
+	  in a guest the patch loading is simulated but everything else
 	  related to patch parsing and handling is done as on baremetal with
-	  the purpose of debugging solely the software side of things.
+	  the purpose of debugging solely the software side of things. On
+	  baremetal, it simply dumps additional debugging information during
+	  normal operation.
=20
 	  You almost certainly want to say n here.
=20
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microc=
ode/amd.c
index 4667353..caa0f59 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -322,7 +322,7 @@ static u32 get_patch_level(void)
 {
 	u32 rev, dummy __always_unused;
=20
-	if (IS_ENABLED(CONFIG_MICROCODE_DBG)) {
+	if (IS_ENABLED(CONFIG_MICROCODE_DBG) && hypervisor_present) {
 		int cpu =3D smp_processor_id();
=20
 		if (!microcode_rev[cpu]) {
@@ -714,7 +714,7 @@ static bool __apply_microcode_amd(struct microcode_amd *m=
c, u32 *cur_rev,
 			invlpg(p_addr_end);
 	}
=20
-	if (IS_ENABLED(CONFIG_MICROCODE_DBG))
+	if (IS_ENABLED(CONFIG_MICROCODE_DBG) && hypervisor_present)
 		microcode_rev[smp_processor_id()] =3D mc->hdr.patch_id;
=20
 	/* verify patch application was successful */
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/micro=
code/core.c
index 68049f1..651202e 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -57,6 +57,8 @@ bool force_minrev =3D IS_ENABLED(CONFIG_MICROCODE_LATE_FORC=
E_MINREV);
 u32 base_rev;
 u32 microcode_rev[NR_CPUS] =3D {};
=20
+bool hypervisor_present;
+
 /*
  * Synchronization.
  *
@@ -117,7 +119,13 @@ bool __init microcode_loader_disabled(void)
 	 * Disable when:
 	 *
 	 * 1) The CPU does not support CPUID.
-	 *
+	 */
+	if (!cpuid_feature()) {
+		dis_ucode_ldr =3D true;
+		return dis_ucode_ldr;
+	}
+
+	/*
 	 * 2) Bit 31 in CPUID[1]:ECX is clear
 	 *    The bit is reserved for hypervisor use. This is still not
 	 *    completely accurate as XEN PV guests don't see that CPUID bit
@@ -127,9 +135,9 @@ bool __init microcode_loader_disabled(void)
 	 * 3) Certain AMD patch levels are not allowed to be
 	 *    overwritten.
 	 */
-	if (!cpuid_feature() ||
-	    ((native_cpuid_ecx(1) & BIT(31)) &&
-	      !IS_ENABLED(CONFIG_MICROCODE_DBG)) ||
+	hypervisor_present =3D native_cpuid_ecx(1) & BIT(31);
+
+	if ((hypervisor_present && !IS_ENABLED(CONFIG_MICROCODE_DBG)) ||
 	    amd_check_current_patch_level())
 		dis_ucode_ldr =3D true;
=20
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/m=
icrocode/internal.h
index a10b547..3b93c06 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -48,6 +48,7 @@ extern struct early_load_data early_data;
 extern struct ucode_cpu_info ucode_cpu_info[];
 extern u32 microcode_rev[NR_CPUS];
 extern u32 base_rev;
+extern bool hypervisor_present;
=20
 struct cpio_data find_microcode_in_initrd(const char *path);
=20

