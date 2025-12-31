Return-Path: <linux-tip-commits+bounces-7779-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A4DCEBF97
	for <lists+linux-tip-commits@lfdr.de>; Wed, 31 Dec 2025 13:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1DD3305D13C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 31 Dec 2025 12:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041B9328B61;
	Wed, 31 Dec 2025 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="atnDtXxR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r4jP4jxw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017D632863B;
	Wed, 31 Dec 2025 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183946; cv=none; b=imAmr0PGmBkfQEZH2lzja+9Zoh8E5/zc0zTKp4+Il6fwWcIjBY3mToruqTpuI0NwlUCGT1fj9AhYY2dycvcg+sXC00lu/jJv7ZgCsMQ+zMFM/M24xOvy7zD+0mw/Me3Sdnekqcz+uwn5HlH5vJzfRqbMXOr0iBBbE1pzp04g9sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183946; c=relaxed/simple;
	bh=i4I2ZcgQpNh3Rk6W4Dz0+TqmDaasJ6D8wGzQK207mgU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=lu3Of2ISE4fm9v7d6tbo6IlTDxMwzQqvxls3kKkiCpNxuOhMOMo5vSTlJTBbnToIGVgSrsl9FyGg4aDJAfjWfu9XVhlT9bvgnzAgW3l7XNcRaXqF74Ur+vERJMpyr8T8Ym9OAzgWaH8d6LKcnBve+vAXVh7LkflT+UDw7NwJrzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=atnDtXxR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r4jP4jxw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Dec 2025 12:25:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767183936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=CXfGbcQ13IgXB6y/1IwuvSz1oFPU+YWbrODXv5XzJwI=;
	b=atnDtXxRN3Og6NzH0dqHUDvckhgPiFvgq1GrdW2QSYRLOOeo8fPQx0fi12ukla9MGVSLD4
	21HBDQtDmwGxB2/uvY+PXCBw491dqreaskQwswE7bTB11C1M8qQR/bt43CO7GFZZBzoV3G
	t52VDBnNXtLVc97WsMDmLlyxoffBHNo2abKj6uWQLi7ecl8D2e9oXW9jUKsD/1vbFhlRG2
	raozop9iEqPyFi7hERE23GD8VApjXuzjAk8r+XduaeboKBO0YNRtZX/0HKKJH4O8TeSfBN
	XJqfhs48p88bKvnsisH4u3/YljNV8ibgo6XF7gzTn3YsB4mUwC5tuKbp7QRhqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767183936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=CXfGbcQ13IgXB6y/1IwuvSz1oFPU+YWbrODXv5XzJwI=;
	b=r4jP4jxwKSiKqnL4JCtxsX0klGlLdGiob/nLQ7dHxb8HPrOb1JFPHYi+e92m4rxWUCHkso
	BkF9DA5TLRZmoaDA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Move the internal header
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176718393561.510.11929434458502004260.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     c1e8980fabf5d0106992a430284fac28bba053a6
Gitweb:        https://git.kernel.org/tip/c1e8980fabf5d0106992a430284fac28bba=
053a6
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 04 Dec 2025 13:48:06 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 Dec 2025 13:05:40 +01:00

x86/sev: Move the internal header

Move the internal header out of the usual include/asm/ include path
because having an "internal" header there doesn't really make it
internal - quite the opposite - that's the normal arch include path.

So move where it belongs and make it really internal.

No functional changes.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20251204145716.GDaTGhTEHNOtSdTkEe@fat_crate.l=
ocal
---
 arch/x86/boot/startup/sev-startup.c |  3 +-
 arch/x86/coco/sev/core.c            |  3 +-
 arch/x86/coco/sev/internal.h        | 87 ++++++++++++++++++++++++++++-
 arch/x86/coco/sev/noinstr.c         |  3 +-
 arch/x86/coco/sev/vc-handle.c       |  3 +-
 arch/x86/include/asm/sev-internal.h | 87 +----------------------------
 6 files changed, 95 insertions(+), 91 deletions(-)
 create mode 100644 arch/x86/coco/sev/internal.h
 delete mode 100644 arch/x86/include/asm/sev-internal.h

diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-=
startup.c
index 0972542..789e99d 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -27,7 +27,6 @@
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
 #include <asm/sev.h>
-#include <asm/sev-internal.h>
 #include <asm/insn-eval.h>
 #include <asm/fpu/xcr.h>
 #include <asm/processor.h>
@@ -41,6 +40,8 @@
 #include <asm/cpuid/api.h>
 #include <asm/cmdline.h>
=20
+#include "../../coco/sev/internal.h"
+
 /* Include code shared with pre-decompression boot stage */
 #include "sev-shared.c"
=20
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 9ae3b11..4e618e5 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -31,7 +31,6 @@
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
 #include <asm/sev.h>
-#include <asm/sev-internal.h>
 #include <asm/insn-eval.h>
 #include <asm/fpu/xcr.h>
 #include <asm/processor.h>
@@ -46,6 +45,8 @@
 #include <asm/cmdline.h>
 #include <asm/msr.h>
=20
+#include "internal.h"
+
 /* Bitmap of SEV features supported by the hypervisor */
 u64 sev_hv_features __ro_after_init;
 SYM_PIC_ALIAS(sev_hv_features);
diff --git a/arch/x86/coco/sev/internal.h b/arch/x86/coco/sev/internal.h
new file mode 100644
index 0000000..c58c47c
--- /dev/null
+++ b/arch/x86/coco/sev/internal.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define DR7_RESET_VALUE        0x400
+
+extern u64 sev_hv_features;
+extern u64 sev_secrets_pa;
+
+/* #VC handler runtime per-CPU data */
+struct sev_es_runtime_data {
+	struct ghcb ghcb_page;
+
+	/*
+	 * Reserve one page per CPU as backup storage for the unencrypted GHCB.
+	 * It is needed when an NMI happens while the #VC handler uses the real
+	 * GHCB, and the NMI handler itself is causing another #VC exception. In
+	 * that case the GHCB content of the first handler needs to be backed up
+	 * and restored.
+	 */
+	struct ghcb backup_ghcb;
+
+	/*
+	 * Mark the per-cpu GHCBs as in-use to detect nested #VC exceptions.
+	 * There is no need for it to be atomic, because nothing is written to
+	 * the GHCB between the read and the write of ghcb_active. So it is safe
+	 * to use it when a nested #VC exception happens before the write.
+	 *
+	 * This is necessary for example in the #VC->NMI->#VC case when the NMI
+	 * happens while the first #VC handler uses the GHCB. When the NMI code
+	 * raises a second #VC handler it might overwrite the contents of the
+	 * GHCB written by the first handler. To avoid this the content of the
+	 * GHCB is saved and restored when the GHCB is detected to be in use
+	 * already.
+	 */
+	bool ghcb_active;
+	bool backup_ghcb_active;
+
+	/*
+	 * Cached DR7 value - write it on DR7 writes and return it on reads.
+	 * That value will never make it to the real hardware DR7 as debugging
+	 * is currently unsupported in SEV-ES guests.
+	 */
+	unsigned long dr7;
+};
+
+struct ghcb_state {
+	struct ghcb *ghcb;
+};
+
+extern struct svsm_ca boot_svsm_ca_page;
+
+struct ghcb *__sev_get_ghcb(struct ghcb_state *state);
+void __sev_put_ghcb(struct ghcb_state *state);
+
+DECLARE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
+DECLARE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
+
+void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
+			   unsigned long npages, const struct psc_desc *desc);
+
+DECLARE_PER_CPU(struct svsm_ca *, svsm_caa);
+DECLARE_PER_CPU(u64, svsm_caa_pa);
+
+extern u64 boot_svsm_caa_pa;
+
+enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt *c=
txt);
+void vc_forward_exception(struct es_em_ctxt *ctxt);
+
+static inline u64 sev_es_rd_ghcb_msr(void)
+{
+	return native_rdmsrq(MSR_AMD64_SEV_ES_GHCB);
+}
+
+static __always_inline void sev_es_wr_ghcb_msr(u64 val)
+{
+	u32 low, high;
+
+	low  =3D (u32)(val);
+	high =3D (u32)(val >> 32);
+
+	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
+}
+
+enum es_result sev_es_ghcb_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *=
ctxt, bool write);
+
+u64 get_hv_features(void);
+
+const struct snp_cpuid_table *snp_cpuid_get_table(void);
diff --git a/arch/x86/coco/sev/noinstr.c b/arch/x86/coco/sev/noinstr.c
index b527eaf..9d94aca 100644
--- a/arch/x86/coco/sev/noinstr.c
+++ b/arch/x86/coco/sev/noinstr.c
@@ -16,7 +16,8 @@
 #include <asm/msr.h>
 #include <asm/ptrace.h>
 #include <asm/sev.h>
-#include <asm/sev-internal.h>
+
+#include "internal.h"
=20
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
index f08c750..43f264a 100644
--- a/arch/x86/coco/sev/vc-handle.c
+++ b/arch/x86/coco/sev/vc-handle.c
@@ -23,7 +23,6 @@
 #include <asm/init.h>
 #include <asm/stacktrace.h>
 #include <asm/sev.h>
-#include <asm/sev-internal.h>
 #include <asm/insn-eval.h>
 #include <asm/fpu/xcr.h>
 #include <asm/processor.h>
@@ -35,6 +34,8 @@
 #include <asm/apic.h>
 #include <asm/cpuid/api.h>
=20
+#include "internal.h"
+
 static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_c=
txt *ctxt,
 					   unsigned long vaddr, phys_addr_t *paddr)
 {
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-i=
nternal.h
deleted file mode 100644
index c58c47c..0000000
--- a/arch/x86/include/asm/sev-internal.h
+++ /dev/null
@@ -1,87 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#define DR7_RESET_VALUE        0x400
-
-extern u64 sev_hv_features;
-extern u64 sev_secrets_pa;
-
-/* #VC handler runtime per-CPU data */
-struct sev_es_runtime_data {
-	struct ghcb ghcb_page;
-
-	/*
-	 * Reserve one page per CPU as backup storage for the unencrypted GHCB.
-	 * It is needed when an NMI happens while the #VC handler uses the real
-	 * GHCB, and the NMI handler itself is causing another #VC exception. In
-	 * that case the GHCB content of the first handler needs to be backed up
-	 * and restored.
-	 */
-	struct ghcb backup_ghcb;
-
-	/*
-	 * Mark the per-cpu GHCBs as in-use to detect nested #VC exceptions.
-	 * There is no need for it to be atomic, because nothing is written to
-	 * the GHCB between the read and the write of ghcb_active. So it is safe
-	 * to use it when a nested #VC exception happens before the write.
-	 *
-	 * This is necessary for example in the #VC->NMI->#VC case when the NMI
-	 * happens while the first #VC handler uses the GHCB. When the NMI code
-	 * raises a second #VC handler it might overwrite the contents of the
-	 * GHCB written by the first handler. To avoid this the content of the
-	 * GHCB is saved and restored when the GHCB is detected to be in use
-	 * already.
-	 */
-	bool ghcb_active;
-	bool backup_ghcb_active;
-
-	/*
-	 * Cached DR7 value - write it on DR7 writes and return it on reads.
-	 * That value will never make it to the real hardware DR7 as debugging
-	 * is currently unsupported in SEV-ES guests.
-	 */
-	unsigned long dr7;
-};
-
-struct ghcb_state {
-	struct ghcb *ghcb;
-};
-
-extern struct svsm_ca boot_svsm_ca_page;
-
-struct ghcb *__sev_get_ghcb(struct ghcb_state *state);
-void __sev_put_ghcb(struct ghcb_state *state);
-
-DECLARE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
-DECLARE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
-
-void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
-			   unsigned long npages, const struct psc_desc *desc);
-
-DECLARE_PER_CPU(struct svsm_ca *, svsm_caa);
-DECLARE_PER_CPU(u64, svsm_caa_pa);
-
-extern u64 boot_svsm_caa_pa;
-
-enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt *c=
txt);
-void vc_forward_exception(struct es_em_ctxt *ctxt);
-
-static inline u64 sev_es_rd_ghcb_msr(void)
-{
-	return native_rdmsrq(MSR_AMD64_SEV_ES_GHCB);
-}
-
-static __always_inline void sev_es_wr_ghcb_msr(u64 val)
-{
-	u32 low, high;
-
-	low  =3D (u32)(val);
-	high =3D (u32)(val >> 32);
-
-	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
-}
-
-enum es_result sev_es_ghcb_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *=
ctxt, bool write);
-
-u64 get_hv_features(void);
-
-const struct snp_cpuid_table *snp_cpuid_get_table(void);

