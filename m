Return-Path: <linux-tip-commits+bounces-2697-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 709B39B9E91
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3251F222C7
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCDC17166E;
	Sat,  2 Nov 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WXsfVjqf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="32IKwbZv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D57155741;
	Sat,  2 Nov 2024 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542214; cv=none; b=QzQ9aDWdc3IlPM/5NVs9AXBpyHr9GK1NVXuYpBpGpedY45F+r/gmkNcFnBV+KdMKeSkWafZ9/1O4rZxBfDZAM3G7Bfc95zyie0Ap3bpeEijs5at7zx2MWKWEjQSf8a9/BYT4lEvdhiMkK+TwWvzl9TPV3HxHmsMwDNe5P91cMq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542214; c=relaxed/simple;
	bh=ORwsT7HQ8G5ybh207fhpbFOEfNixb2W8K0jtaMIJLag=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Anl93cSr4NRs/NF8QH0P0bqlYa+KSrGEZt6F+fzX7PqdSallo0JwuOzAJ4hBqazR10HBFgZ8c5ZC7h/DkhQOdDJloeLFyulY2AIvGzzQ6G23mDtnDw0McriI+M4b1S6PgZoYYByouTqnBlZ9skGV808jFfmfWnQsK/u3CWM4DcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WXsfVjqf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=32IKwbZv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3e1FBbmKKYRSvbqKvoXgQ0IBuQTLn8LAmwxnuWkbboQ=;
	b=WXsfVjqfciVKa9AB06oLa6YWQVR4bka+kZc+ka8nm6JbdHWe2EkkhSqarMlcuy3ivbqe9n
	qd0ujVPutUYvzx2WZILaUma2TwEZm0UdvHxJJgtu28zezIHSFS9IB9/hE9yLHpvnsENIuL
	SYp3uknatXfWyR6LDzUsqs5mJ1ZBjczH96KF10DAoRXvTY2AFNEp7jYizTND/2ktgiTOAz
	uv2k7hsrD0g9y++crL7OSNQdhwttI1k0q4ZEzKqjxPvYRO9jJps/sG2GlyxlOtbSTVR6JF
	bC9P3ravIG74mvRXCtSrxoIJmc3Ym6r749hn/JcWDi7te0jG0TwMv/+cdiJI0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3e1FBbmKKYRSvbqKvoXgQ0IBuQTLn8LAmwxnuWkbboQ=;
	b=32IKwbZv6EvTnqbtJnLXjVO9c0mMOHctSK28AL9hiVQ0Oq67+0ato5FCt7CaBaNDBdTCe6
	qACyvE2oh3hiqHCg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] powerpc: Split systemcfg struct definitions out from vdso
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-27-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-27-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054220253.3137.261477231044072974.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     9d5f97ea44e5665494c1a9e287e9511ed741edf6
Gitweb:        https://git.kernel.org/tip/9d5f97ea44e5665494c1a9e287e9511ed74=
1edf6
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:29 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:16 +01:00

powerpc: Split systemcfg struct definitions out from vdso

The systemcfg data has nothing to do anymore with the vdso.
Split it into a dedicated header file.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-27-b64f0842d5=
12@linutronix.de

---
 arch/powerpc/include/asm/systemcfg.h         | 52 +++++++++++++++++++-
 arch/powerpc/include/asm/vdso_datapage.h     | 37 +--------------
 arch/powerpc/kernel/proc_powerpc.c           |  1 +-
 arch/powerpc/kernel/setup-common.c           |  1 +-
 arch/powerpc/kernel/smp.c                    |  1 +-
 arch/powerpc/kernel/time.c                   |  1 +-
 arch/powerpc/platforms/powernv/smp.c         |  1 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  1 +-
 8 files changed, 58 insertions(+), 37 deletions(-)
 create mode 100644 arch/powerpc/include/asm/systemcfg.h

diff --git a/arch/powerpc/include/asm/systemcfg.h b/arch/powerpc/include/asm/=
systemcfg.h
new file mode 100644
index 0000000..2f9b1d6
--- /dev/null
+++ b/arch/powerpc/include/asm/systemcfg.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _SYSTEMCFG_H
+#define _SYSTEMCFG_H
+
+/*
+ * Copyright (C) 2002 Peter Bergner <bergner@vnet.ibm.com>, IBM
+ * Copyright (C) 2005 Benjamin Herrenschmidy <benh@kernel.crashing.org>,
+ * 		      IBM Corp.
+ */
+
+#ifdef CONFIG_PPC64
+
+/*
+ * If the major version changes we are incompatible.
+ * Minor version changes are a hint.
+ */
+#define SYSTEMCFG_MAJOR 1
+#define SYSTEMCFG_MINOR 1
+
+#include <linux/types.h>
+
+struct systemcfg {
+	__u8  eye_catcher[16];		/* Eyecatcher: SYSTEMCFG:PPC64	0x00 */
+	struct {			/* Systemcfg version numbers	     */
+		__u32 major;		/* Major number			0x10 */
+		__u32 minor;		/* Minor number			0x14 */
+	} version;
+
+	/* Note about the platform flags: it now only contains the lpar
+	 * bit. The actual platform number is dead and buried
+	 */
+	__u32 platform;			/* Platform flags		0x18 */
+	__u32 processor;		/* Processor type		0x1C */
+	__u64 processorCount;		/* # of physical processors	0x20 */
+	__u64 physicalMemorySize;	/* Size of real memory(B)	0x28 */
+	__u64 tb_orig_stamp;		/* (NU) Timebase at boot	0x30 */
+	__u64 tb_ticks_per_sec;		/* Timebase tics / sec		0x38 */
+	__u64 tb_to_xs;			/* (NU) Inverse of TB to 2^20	0x40 */
+	__u64 stamp_xsec;		/* (NU)				0x48 */
+	__u64 tb_update_count;		/* (NU) Timebase atomicity ctr	0x50 */
+	__u32 tz_minuteswest;		/* (NU) Min. west of Greenwich	0x58 */
+	__u32 tz_dsttime;		/* (NU) Type of dst correction	0x5C */
+	__u32 dcache_size;		/* L1 d-cache size		0x60 */
+	__u32 dcache_line_size;		/* L1 d-cache line size		0x64 */
+	__u32 icache_size;		/* L1 i-cache size		0x68 */
+	__u32 icache_line_size;		/* L1 i-cache line size		0x6C */
+};
+
+extern struct systemcfg *systemcfg;
+
+#endif /* CONFIG_PPC64 */
+#endif /* _SYSTEMCFG_H */
diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/=
asm/vdso_datapage.h
index 8b91b1d..a968631 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -9,14 +9,6 @@
  * 		      IBM Corp.
  */
=20
-
-/*
- * If the major version changes we are incompatible.
- * Minor version changes are a hint.
- */
-#define SYSTEMCFG_MAJOR 1
-#define SYSTEMCFG_MINOR 1
-
 #ifndef __ASSEMBLY__
=20
 #include <linux/unistd.h>
@@ -27,35 +19,6 @@
=20
 #ifdef CONFIG_PPC64
=20
-struct systemcfg {
-	__u8  eye_catcher[16];		/* Eyecatcher: SYSTEMCFG:PPC64	0x00 */
-	struct {			/* Systemcfg version numbers	     */
-		__u32 major;		/* Major number			0x10 */
-		__u32 minor;		/* Minor number			0x14 */
-	} version;
-
-	/* Note about the platform flags: it now only contains the lpar
-	 * bit. The actual platform number is dead and buried
-	 */
-	__u32 platform;			/* Platform flags		0x18 */
-	__u32 processor;		/* Processor type		0x1C */
-	__u64 processorCount;		/* # of physical processors	0x20 */
-	__u64 physicalMemorySize;	/* Size of real memory(B)	0x28 */
-	__u64 tb_orig_stamp;		/* (NU) Timebase at boot	0x30 */
-	__u64 tb_ticks_per_sec;		/* Timebase tics / sec		0x38 */
-	__u64 tb_to_xs;			/* (NU) Inverse of TB to 2^20	0x40 */
-	__u64 stamp_xsec;		/* (NU)				0x48 */
-	__u64 tb_update_count;		/* (NU) Timebase atomicity ctr	0x50 */
-	__u32 tz_minuteswest;		/* (NU) Min. west of Greenwich	0x58 */
-	__u32 tz_dsttime;		/* (NU) Type of dst correction	0x5C */
-	__u32 dcache_size;		/* L1 d-cache size		0x60 */
-	__u32 dcache_line_size;		/* L1 d-cache line size		0x64 */
-	__u32 icache_size;		/* L1 i-cache size		0x68 */
-	__u32 icache_line_size;		/* L1 i-cache line size		0x6C */
-};
-
-extern struct systemcfg *systemcfg;
-
 struct vdso_arch_data {
 	__u64 tb_ticks_per_sec;			/* Timebase tics / sec */
 	__u32 dcache_block_size;		/* L1 d-cache block size     */
diff --git a/arch/powerpc/kernel/proc_powerpc.c b/arch/powerpc/kernel/proc_po=
werpc.c
index e8083e0..3816a2b 100644
--- a/arch/powerpc/kernel/proc_powerpc.c
+++ b/arch/powerpc/kernel/proc_powerpc.c
@@ -13,6 +13,7 @@
 #include <asm/machdep.h>
 #include <asm/vdso_datapage.h>
 #include <asm/rtas.h>
+#include <asm/systemcfg.h>
 #include <linux/uaccess.h>
=20
 #ifdef CONFIG_PPC64_PROC_SYSTEMCFG
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-c=
ommon.c
index d0b32ff..0b732d3 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -67,6 +67,7 @@
 #include <asm/cpu_has_feature.h>
 #include <asm/kasan.h>
 #include <asm/mce.h>
+#include <asm/systemcfg.h>
=20
 #include "setup.h"
=20
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 87ae45b..5ac7084 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -61,6 +61,7 @@
 #include <asm/ftrace.h>
 #include <asm/kup.h>
 #include <asm/fadump.h>
+#include <asm/systemcfg.h>
=20
 #include <trace/events/ipi.h>
=20
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 7d18eb8..0727332 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -71,6 +71,7 @@
 #include <asm/vdso_datapage.h>
 #include <asm/firmware.h>
 #include <asm/mce.h>
+#include <asm/systemcfg.h>
=20
 /* powerpc clocksource/clockevent code */
=20
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/po=
wernv/smp.c
index 6722094..2e9da58 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -36,6 +36,7 @@
 #include <asm/kexec.h>
 #include <asm/reg.h>
 #include <asm/powernv.h>
+#include <asm/systemcfg.h>
=20
 #include "powernv.h"
=20
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/plat=
forms/pseries/hotplug-cpu.c
index 7b80d35..bc6926d 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -33,6 +33,7 @@
 #include <asm/xive.h>
 #include <asm/plpar_wrappers.h>
 #include <asm/topology.h>
+#include <asm/systemcfg.h>
=20
 #include "pseries.h"
=20

