Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEA61FF3C6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jun 2020 15:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgFRNvD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Jun 2020 09:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgFRNvC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Jun 2020 09:51:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A428BC06174E;
        Thu, 18 Jun 2020 06:51:01 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jluwT-0002im-TC; Thu, 18 Jun 2020 15:50:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E67A31C0489;
        Thu, 18 Jun 2020 15:50:56 +0200 (CEST)
Date:   Thu, 18 Jun 2020 13:50:56 -0000
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fsgsbase] x86/entry/64: Introduce the FIND_PERCPU_BASE macro
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1557309753-24073-12-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-12-git-send-email-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <159248825673.16989.7101416393032677108.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fsgsbase branch of tip:

Commit-ID:     eaad981291ee36efee15a5e515d4598ae94ace07
Gitweb:        https://git.kernel.org/tip/eaad981291ee36efee15a5e515d4598ae94ace07
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 28 May 2020 16:13:56 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jun 2020 15:47:04 +02:00

x86/entry/64: Introduce the FIND_PERCPU_BASE macro

GSBASE is used to find per-CPU data in the kernel. But when GSBASE is
unknown, the per-CPU base can be found from the per_cpu_offset table with a
CPU NR.  The CPU NR is extracted from the limit field of the CPUNODE entry
in GDT, or by the RDPID instruction. This is a prerequisite for using
FSGSBASE in the low level entry code.

Also, add the GAS-compatible RDPID macro as binutils 2.23 do not support
it. Support is added in version 2.27.

[ tglx: Massaged changelog ]

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1557309753-24073-12-git-send-email-chang.seok.bae@intel.com
Link: https://lkml.kernel.org/r/20200528201402.1708239-11-sashal@kernel.org


---
 arch/x86/entry/calling.h    | 34 ++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/inst.h | 15 +++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 4208c1e..5c0cbb4 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -6,6 +6,7 @@
 #include <asm/percpu.h>
 #include <asm/asm-offsets.h>
 #include <asm/processor-flags.h>
+#include <asm/inst.h>
 
 /*
 
@@ -351,3 +352,36 @@ For 32-bit we have the following conventions - kernel is built with
 	call stackleak_erase
 #endif
 .endm
+
+#ifdef CONFIG_SMP
+
+/*
+ * CPU/node NR is loaded from the limit (size) field of a special segment
+ * descriptor entry in GDT.
+ */
+.macro LOAD_CPU_AND_NODE_SEG_LIMIT reg:req
+	movq	$__CPUNODE_SEG, \reg
+	lsl	\reg, \reg
+.endm
+
+/*
+ * Fetch the per-CPU GSBASE value for this processor and put it in @reg.
+ * We normally use %gs for accessing per-CPU data, but we are setting up
+ * %gs here and obviously can not use %gs itself to access per-CPU data.
+ */
+.macro GET_PERCPU_BASE reg:req
+	ALTERNATIVE \
+		"LOAD_CPU_AND_NODE_SEG_LIMIT \reg", \
+		"RDPID	\reg", \
+		X86_FEATURE_RDPID
+	andq	$VDSO_CPUNODE_MASK, \reg
+	movq	__per_cpu_offset(, \reg, 8), \reg
+.endm
+
+#else
+
+.macro GET_PERCPU_BASE reg:req
+	movq	pcpu_unit_offsets(%rip), \reg
+.endm
+
+#endif /* CONFIG_SMP */
diff --git a/arch/x86/include/asm/inst.h b/arch/x86/include/asm/inst.h
index f5a796d..d063841 100644
--- a/arch/x86/include/asm/inst.h
+++ b/arch/x86/include/asm/inst.h
@@ -306,6 +306,21 @@
 	.endif
 	MODRM 0xc0 movq_r64_xmm_opd1 movq_r64_xmm_opd2
 	.endm
+
+.macro RDPID opd
+	REG_TYPE rdpid_opd_type \opd
+	.if rdpid_opd_type == REG_TYPE_R64
+	R64_NUM rdpid_opd \opd
+	.else
+	R32_NUM rdpid_opd \opd
+	.endif
+	.byte 0xf3
+	.if rdpid_opd > 7
+	PFX_REX rdpid_opd 0
+	.endif
+	.byte 0x0f, 0xc7
+	MODRM 0xc0 rdpid_opd 0x7
+.endm
 #endif
 
 #endif
