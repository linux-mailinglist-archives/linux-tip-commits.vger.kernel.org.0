Return-Path: <linux-tip-commits+bounces-6280-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4244FB2A976
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 16:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1051B678A3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 14:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965411F4177;
	Mon, 18 Aug 2025 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kYgyCtw0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+BkghXQa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36983218C0;
	Mon, 18 Aug 2025 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525513; cv=none; b=UOEB7RZN6vtuvr1SuyWa4xOdLngRUk8HpoisXuEAjRmV/A5sjy116N3TkL8BZ/BbwblcEBoAYyOXX9SOyC+39D61PnTmhD98xHqulKwrkjDGe0GkbyYERSIZQ+Pj0f/ZZhQxorxikoz9I5m402eKraWzOexMocAxOwzXFYiwiZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525513; c=relaxed/simple;
	bh=e1hglYPW8NUeeJXsmZbwHPx0sk+mI8NBr8vpZq6hj0M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SzSIIKvh2qLaC596v6I9xroNIbfz9OrT8qKoBVb2ZCWCqWuRSB6A+rqbEdoRgmCtlTR997fjXndAp5xLRkgAcDsoBxCnHbfTysCBRrm5mk8ENLMH20Gs+6VJvbAUCfY38Bh6RqyfWeTwHNxH2e+xe3FzHTQ0SbchpfWTn60R0SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kYgyCtw0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+BkghXQa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 13:58:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755525510;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wpBWEbntYPDnsYwC2DAvDETWCVLWAMWzVGyQyCTilXM=;
	b=kYgyCtw0lxdW+/cM6OkkUOtrVy35Pd9hWddy7r8zn7yeXCqD71j6EhjrOwKlMOYeWXs9zh
	kA4FFiZNEHu5BdSlz3pMqJ9Wr3Uc4kfCNy6S3tLGuB8CuQzccdtQkHXz/KaSP/Ssdunb1r
	UjF0Qpg4uxpB4WwKnqfmZjS7IlCZ/rsk1XOj/YKrbLOmZkOQlmclxtYzS2LHVhZm2NSzcg
	AyXx2c9qG83tKuvNduyCk3UNoEj9eSuQtdvrHBJlcI7RfUuxPDOAyHxKcSX4DlaI4MzQSt
	j5UxtPGFbLOv76b6IXoUXPzKWcZ3EkR1BWhL01eIw+LZVMNyDOWnDo7yun4W/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755525510;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wpBWEbntYPDnsYwC2DAvDETWCVLWAMWzVGyQyCTilXM=;
	b=+BkghXQaAZXHLTlCYMEMbp7m3kb4ERGTIaj9Aqx0zDUHGcrbsTPRXrkwiBC0N5PVX44UqI
	adg9tWhEMFYMx4AA==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Detect FreeBSD Bhyve hypervisor
Cc: David Woodhouse <dwmw@amazon.co.uk>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <03802f6f7f5b5cf8c5e8adfe123c397ca8e21093.camel@infradead.org>
References: <03802f6f7f5b5cf8c5e8adfe123c397ca8e21093.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175552550854.1420.12254414366709516837.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     215596ddc33f20945e8d1188a7e682831f0ef050
Gitweb:        https://git.kernel.org/tip/215596ddc33f20945e8d1188a7e682831f0=
ef050
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Sat, 16 Aug 2025 11:06:32 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 18 Aug 2025 15:49:07 +02:00

x86/cpu: Detect FreeBSD Bhyve hypervisor

Detect the Bhyve hypervisor and enable 15-bit MSI support if available.

Detecting Bhyve used to be a purely cosmetic issue of the kernel printing
'Hypervisor detected: Bhyve' at boot time.

But FreeBSD 15.0 will support=C2=B9 the 15-bit MSI enlightenment to support
more than 255 vCPUs (http://david.woodhou.se/ExtDestId.pdf) which means
there's now actually some functional reason to do so.

  =C2=B9 https://github.com/freebsd/freebsd-src/commit/313a68ea20b4

  [ bp: Massage, move tail comment ontop. ]

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Ahmed S. Darwish <darwi@linutronix.de>
Link: https://lore.kernel.org/03802f6f7f5b5cf8c5e8adfe123c397ca8e21093.camel@=
infradead.org
---
 arch/x86/Kconfig                  |  9 ++++-
 arch/x86/include/asm/hypervisor.h |  2 +-
 arch/x86/kernel/cpu/Makefile      |  1 +-
 arch/x86/kernel/cpu/bhyve.c       | 66 ++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/hypervisor.c  |  3 +-
 5 files changed, 81 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/bhyve.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890f..ac1c6df 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -879,6 +879,15 @@ config ACRN_GUEST
 	  IOT with small footprint and real-time features. More details can be
 	  found in https://projectacrn.org/.
=20
+config BHYVE_GUEST
+	bool "Bhyve (BSD Hypervisor) Guest support"
+	depends on X86_64
+	help
+	  This option allows to run Linux to recognise when it is running as a
+	  guest in the Bhyve hypervisor, and to support more than 255 vCPUs when
+	  when doing so. More details about Bhyve can be found at https://bhyve.org
+	  and https://wiki.freebsd.org/bhyve/.
+
 config INTEL_TDX_GUEST
 	bool "Intel TDX (Trust Domain Extensions) - Guest Support"
 	depends on X86_64 && CPU_SUP_INTEL
diff --git a/arch/x86/include/asm/hypervisor.h b/arch/x86/include/asm/hypervi=
sor.h
index e41cbf2..9ad86a7 100644
--- a/arch/x86/include/asm/hypervisor.h
+++ b/arch/x86/include/asm/hypervisor.h
@@ -30,6 +30,7 @@ enum x86_hypervisor_type {
 	X86_HYPER_KVM,
 	X86_HYPER_JAILHOUSE,
 	X86_HYPER_ACRN,
+	X86_HYPER_BHYVE,
 };
=20
 #ifdef CONFIG_HYPERVISOR_GUEST
@@ -64,6 +65,7 @@ extern const struct hypervisor_x86 x86_hyper_xen_pv;
 extern const struct hypervisor_x86 x86_hyper_kvm;
 extern const struct hypervisor_x86 x86_hyper_jailhouse;
 extern const struct hypervisor_x86 x86_hyper_acrn;
+extern const struct hypervisor_x86 x86_hyper_bhyve;
 extern struct hypervisor_x86 x86_hyper_xen_hvm;
=20
 extern bool nopv;
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 1e26179..2f8a58e 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_X86_SGX)			+=3D sgx/
 obj-$(CONFIG_X86_LOCAL_APIC)		+=3D perfctr-watchdog.o
=20
 obj-$(CONFIG_HYPERVISOR_GUEST)		+=3D vmware.o hypervisor.o mshyperv.o
+obj-$(CONFIG_BHYVE_GUEST)		+=3D bhyve.o
 obj-$(CONFIG_ACRN_GUEST)		+=3D acrn.o
=20
 obj-$(CONFIG_DEBUG_FS)			+=3D debugfs.o
diff --git a/arch/x86/kernel/cpu/bhyve.c b/arch/x86/kernel/cpu/bhyve.c
new file mode 100644
index 0000000..f1a8ca3
--- /dev/null
+++ b/arch/x86/kernel/cpu/bhyve.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FreeBSD Bhyve guest enlightenments
+ *
+ * Copyright =C2=A9 2025 Amazon.com, Inc. or its affiliates.
+ *
+ * Author: David Woodhouse <dwmw2@infradead.org>
+ */
+
+#include <linux/init.h>
+#include <linux/export.h>
+#include <asm/processor.h>
+#include <asm/hypervisor.h>
+
+static uint32_t bhyve_cpuid_base;
+static uint32_t bhyve_cpuid_max;
+
+#define BHYVE_SIGNATURE			"bhyve bhyve "
+
+#define CPUID_BHYVE_FEATURES		0x40000001
+
+/* Features advertised in CPUID_BHYVE_FEATURES %eax */
+
+/* MSI Extended Dest ID */
+#define CPUID_BHYVE_FEAT_EXT_DEST_ID	(1UL << 0)
+
+static uint32_t __init bhyve_detect(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+                return 0;
+
+	bhyve_cpuid_base =3D cpuid_base_hypervisor(BHYVE_SIGNATURE, 0);
+	if (!bhyve_cpuid_base)
+		return 0;
+
+	bhyve_cpuid_max =3D cpuid_eax(bhyve_cpuid_base);
+	return bhyve_cpuid_max;
+}
+
+static uint32_t bhyve_features(void)
+{
+	unsigned int cpuid_leaf =3D bhyve_cpuid_base | CPUID_BHYVE_FEATURES;
+
+	if (bhyve_cpuid_max < cpuid_leaf)
+		return 0;
+
+	return cpuid_eax(cpuid_leaf);
+}
+
+static bool __init bhyve_ext_dest_id(void)
+{
+	return !!(bhyve_features() & CPUID_BHYVE_FEAT_EXT_DEST_ID);
+}
+
+static bool __init bhyve_x2apic_available(void)
+{
+	return true;
+}
+
+const struct hypervisor_x86 x86_hyper_bhyve __refconst =3D {
+	.name			=3D "Bhyve",
+	.detect			=3D bhyve_detect,
+	.init.init_platform	=3D x86_init_noop,
+	.init.x2apic_available	=3D bhyve_x2apic_available,
+	.init.msi_ext_dest_id	=3D bhyve_ext_dest_id,
+};
diff --git a/arch/x86/kernel/cpu/hypervisor.c b/arch/x86/kernel/cpu/hyperviso=
r.c
index 553bfbf..f3e9219 100644
--- a/arch/x86/kernel/cpu/hypervisor.c
+++ b/arch/x86/kernel/cpu/hypervisor.c
@@ -45,6 +45,9 @@ static const __initconst struct hypervisor_x86 * const hype=
rvisors[] =3D
 #ifdef CONFIG_ACRN_GUEST
 	&x86_hyper_acrn,
 #endif
+#ifdef CONFIG_BHYVE_GUEST
+	&x86_hyper_bhyve,
+#endif
 };
=20
 enum x86_hypervisor_type x86_hyper_type;

