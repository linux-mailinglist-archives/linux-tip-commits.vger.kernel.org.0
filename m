Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F6E4363DC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 16:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJUORD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 10:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhJUORC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 10:17:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E86FC0613B9;
        Thu, 21 Oct 2021 07:14:46 -0700 (PDT)
Date:   Thu, 21 Oct 2021 14:14:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634825685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SFJzu+Ks/3WJM2Jez+2xcKKzEu/19R76zxM4Rp0hsfU=;
        b=yXFduNL79cNk4vn427nOMIPvEjsXzSLLGOIAfHORlNQGOr+dMBS0o6Tm5Xg5NHcBgzLmp8
        eHR/mKCrzX1lbRirNP1yUpT8G7zU5OVBDiiFvxR334QNspc0mH1UiWXY5rW7yzfDKgzSmn
        D98c0j40txJg1ndPbAfN53WS7LprAi27lW+kLRmRjrZmjdoP+OKspqmTQTWIhEjOtrGQpp
        GfamQf0W0XX17ivgufGnVeZtyQAsBWP+wgoI9iEU0jrH17QJZgX3X9hSWXyFpxZf82a05k
        Ayz9Z/2S6rjmTCkSdEJwK4NVOstdIVKlmVjsVGQmFv5BCQT6vLuVlmGbdDmAXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634825685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SFJzu+Ks/3WJM2Jez+2xcKKzEu/19R76zxM4Rp0hsfU=;
        b=Kt12gmNSE74jNb3+AXojVuBZclgIVGpobh12SxxPXpUDpKnFhjhlpK1Hmz5Nb5Np6Wlf64
        elQeABrV4jZxG5CQ==
From:   "tip-bot2 for Marcos Del Sol Vives" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU: Add support for Vortex CPUs
Cc:     Marcos Del Sol Vives <marcos@orca.pet>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211017094408.1512158-1-marcos@orca.pet>
References: <20211017094408.1512158-1-marcos@orca.pet>
MIME-Version: 1.0
Message-ID: <163482568381.25758.16061887926860812766.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     639475d434b88b58827e1aae601ed1853803f5be
Gitweb:        https://git.kernel.org/tip/639475d434b88b58827e1aae601ed185380=
3f5be
Author:        Marcos Del Sol Vives <marcos@orca.pet>
AuthorDate:    Sun, 17 Oct 2021 11:44:10 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Oct 2021 15:49:07 +02:00

x86/CPU: Add support for Vortex CPUs

DM&P devices were not being properly identified, which resulted in
unneeded Spectre/Meltdown mitigations being applied.

The manufacturer states that these devices execute always in-order and
don't support either speculative execution or branch prediction, so
they are not vulnerable to this class of attack. [1]

This is something I've personally tested by a simple timing analysis
on my Vortex86MX CPU, and can confirm it is true.

Add identification for some devices that lack the CPUID product name
call, so they appear properly on /proc/cpuinfo.

=C2=B9https://www.ssv-embedded.de/doks/infos/DMP_Ann_180108_Meltdown.pdf

 [ bp: Massage commit message. ]

Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211017094408.1512158-1-marcos@orca.pet
---
 arch/x86/Kconfig.cpu             | 13 ++++++++++-
 arch/x86/include/asm/processor.h |  3 +-
 arch/x86/kernel/cpu/Makefile     |  1 +-
 arch/x86/kernel/cpu/common.c     |  2 ++-
 arch/x86/kernel/cpu/vortex.c     | 39 +++++++++++++++++++++++++++++++-
 5 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/cpu/vortex.c

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 814fe0d..eefc434 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -508,3 +508,16 @@ config CPU_SUP_ZHAOXIN
 	  CPU might render the kernel unbootable.
=20
 	  If unsure, say N.
+
+config CPU_SUP_VORTEX_32
+	default y
+	bool "Support Vortex processors" if PROCESSOR_SELECT
+	depends on X86_32
+	help
+	  This enables detection, tunings and quirks for Vortex processors
+
+	  You need this enabled if you want your kernel to run on a
+	  Vortex CPU. Disabling this option on other types of CPUs
+	  makes the kernel a tiny bit smaller.
+
+	  If unsure, say N.
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processo=
r.h
index 9ad2aca..64e5290 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -164,7 +164,8 @@ enum cpuid_regs_idx {
 #define X86_VENDOR_NSC		8
 #define X86_VENDOR_HYGON	9
 #define X86_VENDOR_ZHAOXIN	10
-#define X86_VENDOR_NUM		11
+#define X86_VENDOR_VORTEX	11
+#define X86_VENDOR_NUM		12
=20
 #define X86_VENDOR_UNKNOWN	0xff
=20
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 637b499..9661e3e 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_CPU_SUP_CENTAUR)		+=3D centaur.o
 obj-$(CONFIG_CPU_SUP_TRANSMETA_32)	+=3D transmeta.o
 obj-$(CONFIG_CPU_SUP_UMC_32)		+=3D umc.o
 obj-$(CONFIG_CPU_SUP_ZHAOXIN)		+=3D zhaoxin.o
+obj-$(CONFIG_CPU_SUP_VORTEX_32)		+=3D vortex.o
=20
 obj-$(CONFIG_X86_MCE)			+=3D mce/
 obj-$(CONFIG_MTRR)			+=3D mtrr/
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0f88859..325d602 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1044,6 +1044,8 @@ static const __initconst struct x86_cpu_id cpu_vuln_whi=
telist[] =3D {
 	VULNWL(CENTAUR,	5, X86_MODEL_ANY,	NO_SPECULATION),
 	VULNWL(INTEL,	5, X86_MODEL_ANY,	NO_SPECULATION),
 	VULNWL(NSC,	5, X86_MODEL_ANY,	NO_SPECULATION),
+	VULNWL(VORTEX,	5, X86_MODEL_ANY,	NO_SPECULATION),
+	VULNWL(VORTEX,	6, X86_MODEL_ANY,	NO_SPECULATION),
=20
 	/* Intel Family 6 */
 	VULNWL_INTEL(ATOM_SALTWELL,		NO_SPECULATION | NO_ITLB_MULTIHIT),
diff --git a/arch/x86/kernel/cpu/vortex.c b/arch/x86/kernel/cpu/vortex.c
new file mode 100644
index 0000000..e268547
--- /dev/null
+++ b/arch/x86/kernel/cpu/vortex.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <asm/processor.h>
+#include "cpu.h"
+
+/*
+ * No special init required for Vortex processors.
+ */
+
+static const struct cpu_dev vortex_cpu_dev =3D {
+	.c_vendor	=3D "Vortex",
+	.c_ident	=3D { "Vortex86 SoC" },
+	.legacy_models	=3D {
+		{
+			.family =3D 5,
+			.model_names =3D {
+				[2] =3D "Vortex86DX",
+				[8] =3D "Vortex86MX",
+			},
+		},
+		{
+			.family =3D 6,
+			.model_names =3D {
+				/*
+				 * Both the Vortex86EX and the Vortex86EX2
+				 * have the same family and model id.
+				 *
+				 * However, the -EX2 supports the product name
+				 * CPUID call, so this name will only be used
+				 * for the -EX, which does not.
+				 */
+				[0] =3D "Vortex86EX",
+			},
+		},
+	},
+	.c_x86_vendor	=3D X86_VENDOR_VORTEX,
+};
+
+cpu_dev_register(vortex_cpu_dev);
