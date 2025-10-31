Return-Path: <linux-tip-commits+bounces-7113-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83467C24F95
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 13:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B5764F3D2F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 12:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5362A2E1743;
	Fri, 31 Oct 2025 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PoUbVdH+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GE9FmwtF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DF02DC766;
	Fri, 31 Oct 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913335; cv=none; b=s4+UrFi4WO0P9w7xaMVOOjza7z9lg8DSKpGAqT9sED9hdD1bP69uC4Owk2pfwBQPS4B3vC+V9gVDNfyHnn/YqvvLMwTQU9nnPogSIgk4CnANKrhKkmJJ2SmbAVJ1WmbSZ4tpPulbCJm39g2UM/IgApeWkoU4ZSbS1e8NGNcf+08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913335; c=relaxed/simple;
	bh=z0zBi3+7SH/Wnnd0JdF7VJhTCKVDyatMN5djH1jVb3g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S3Nmu91FkkBCC+WHPg4w/9xRSWsGcoVAvA9coxPFJnql/LHSehw/LFgH7YBryqS5nv7QrwnAERGDq8tK/FskjPzMPZigvRne4qtgS2pwCFJrBFF9sx3hvsXx4zwposJY4yo0Rgk/P1wN1fyibb08xMzEOh2KOJT8VAgWWfggD9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PoUbVdH+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GE9FmwtF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 Oct 2025 12:22:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761913331;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWyGw1CFs4uK/bZTEE9ZzpWi8Nsn5K/oYIbI3eTSIns=;
	b=PoUbVdH+QXKSIBLN//enW956KMACy9CDnAVKqiuqacEy7337Ca0Yc4wIBlwphNYmzeTQNi
	nT69xZAR/hAYYZKzWuGRI6CEzPdg2FHT9L7rvi4ao+jpm9gTxVCW8aa2Lel/S4cS+pEB8I
	3dFv/RbgdVLR0iw5TeMLgC9yWxKJxB4uXGgls59FM8IcYq2ZgUSGYlUB5RNe2Q/EztJWGN
	3TP46wNWiznToXNrSDJBEFXXWpWwOl2ELiDiqfEu+6iH+EsZVDPUHx7RA4CTTyJjjc8w5p
	CFgC62XOZntNAgGwohCu50VXJjCjmokIgMYcjkZwUnFZ73Qkxn9GdJS3ghi7+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761913331;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWyGw1CFs4uK/bZTEE9ZzpWi8Nsn5K/oYIbI3eTSIns=;
	b=GE9FmwtF5Tvgn4j0MNU9sQq0PaREXe6Z5672lN8/NBsQP6CrJiAbjJVjxzr1z52626fIl/
	uCaa1mmOQipOu7Ag==
From: "tip-bot2 for John Allen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/boot: Move boot_*msr helpers to asm/shared/msr.h
Cc: John Allen <john.allen@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250924200852.4452-2-john.allen@amd.com>
References: <20250924200852.4452-2-john.allen@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176191333027.2601451.11257491536675159729.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     9249bcdea0c6db4f450a9267aa6da5b4dd4153ca
Gitweb:        https://git.kernel.org/tip/9249bcdea0c6db4f450a9267aa6da5b4dd4=
153ca
Author:        John Allen <john.allen@amd.com>
AuthorDate:    Wed, 24 Sep 2025 20:08:51=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 30 Oct 2025 16:29:53 +01:00

x86/boot: Move boot_*msr helpers to asm/shared/msr.h

The boot_{rdmsr,wrmsr}() helpers are *just* the barebones MSR access
functionality, without any tracing or exception handling glue as it is done in
kernel proper.

Move these helpers to asm/shared/msr.h and rename to raw_{rdmsr,wrmsr}() to
indicate what they are.

  [ bp: Correct the reason why those helpers exist. I should've caught that in
    the original patch that added them:
      176db622573f ("x86/boot: Introduce helpers for MSR reads/writes"
    but oh well...
    - fixup include path delimiters to <> ]

Signed-off-by: John Allen <john.allen@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://patch.msgid.link/all/20250924200852.4452-2-john.allen@amd.com
---
 arch/x86/boot/compressed/sev.c    |  7 ++++---
 arch/x86/boot/compressed/sev.h    |  6 +++---
 arch/x86/boot/cpucheck.c          | 16 ++++++++--------
 arch/x86/boot/msr.h               | 26 --------------------------
 arch/x86/include/asm/shared/msr.h | 15 +++++++++++++++
 5 files changed, 30 insertions(+), 40 deletions(-)
 delete mode 100644 arch/x86/boot/msr.h

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 6e5c32a..c8c1464 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -14,6 +14,7 @@
=20
 #include <asm/bootparam.h>
 #include <asm/pgtable_types.h>
+#include <asm/shared/msr.h>
 #include <asm/sev.h>
 #include <asm/trapnr.h>
 #include <asm/trap_pf.h>
@@ -397,7 +398,7 @@ void sev_enable(struct boot_params *bp)
 	}
=20
 	/* Set the SME mask if this is an SEV guest. */
-	boot_rdmsr(MSR_AMD64_SEV, &m);
+	raw_rdmsr(MSR_AMD64_SEV, &m);
 	sev_status =3D m.q;
 	if (!(sev_status & MSR_AMD64_SEV_ENABLED))
 		return;
@@ -446,7 +447,7 @@ u64 sev_get_status(void)
 	if (sev_check_cpu_support() < 0)
 		return 0;
=20
-	boot_rdmsr(MSR_AMD64_SEV, &m);
+	raw_rdmsr(MSR_AMD64_SEV, &m);
 	return m.q;
 }
=20
@@ -496,7 +497,7 @@ bool early_is_sevsnp_guest(void)
 			struct msr m;
=20
 			/* Obtain the address of the calling area to use */
-			boot_rdmsr(MSR_SVSM_CAA, &m);
+			raw_rdmsr(MSR_SVSM_CAA, &m);
 			boot_svsm_caa_pa =3D m.q;
=20
 			/*
diff --git a/arch/x86/boot/compressed/sev.h b/arch/x86/boot/compressed/sev.h
index 92f79c2..22637b4 100644
--- a/arch/x86/boot/compressed/sev.h
+++ b/arch/x86/boot/compressed/sev.h
@@ -10,7 +10,7 @@
=20
 #ifdef CONFIG_AMD_MEM_ENCRYPT
=20
-#include "../msr.h"
+#include <asm/shared/msr.h>
=20
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 sev_get_status(void);
@@ -20,7 +20,7 @@ static inline u64 sev_es_rd_ghcb_msr(void)
 {
 	struct msr m;
=20
-	boot_rdmsr(MSR_AMD64_SEV_ES_GHCB, &m);
+	raw_rdmsr(MSR_AMD64_SEV_ES_GHCB, &m);
=20
 	return m.q;
 }
@@ -30,7 +30,7 @@ static inline void sev_es_wr_ghcb_msr(u64 val)
 	struct msr m;
=20
 	m.q =3D val;
-	boot_wrmsr(MSR_AMD64_SEV_ES_GHCB, &m);
+	raw_wrmsr(MSR_AMD64_SEV_ES_GHCB, &m);
 }
=20
 #else
diff --git a/arch/x86/boot/cpucheck.c b/arch/x86/boot/cpucheck.c
index f82de8d..2e1bb93 100644
--- a/arch/x86/boot/cpucheck.c
+++ b/arch/x86/boot/cpucheck.c
@@ -26,9 +26,9 @@
 #include <asm/intel-family.h>
 #include <asm/processor-flags.h>
 #include <asm/msr-index.h>
+#include <asm/shared/msr.h>
=20
 #include "string.h"
-#include "msr.h"
=20
 static u32 err_flags[NCAPINTS];
=20
@@ -134,9 +134,9 @@ int check_cpu(int *cpu_level_ptr, int *req_level_ptr, u32=
 **err_flags_ptr)
=20
 		struct msr m;
=20
-		boot_rdmsr(MSR_K7_HWCR, &m);
+		raw_rdmsr(MSR_K7_HWCR, &m);
 		m.l &=3D ~(1 << 15);
-		boot_wrmsr(MSR_K7_HWCR, &m);
+		raw_wrmsr(MSR_K7_HWCR, &m);
=20
 		get_cpuflags();	/* Make sure it really did something */
 		err =3D check_cpuflags();
@@ -148,9 +148,9 @@ int check_cpu(int *cpu_level_ptr, int *req_level_ptr, u32=
 **err_flags_ptr)
=20
 		struct msr m;
=20
-		boot_rdmsr(MSR_VIA_FCR, &m);
+		raw_rdmsr(MSR_VIA_FCR, &m);
 		m.l |=3D (1 << 1) | (1 << 7);
-		boot_wrmsr(MSR_VIA_FCR, &m);
+		raw_wrmsr(MSR_VIA_FCR, &m);
=20
 		set_bit(X86_FEATURE_CX8, cpu.flags);
 		err =3D check_cpuflags();
@@ -160,14 +160,14 @@ int check_cpu(int *cpu_level_ptr, int *req_level_ptr, u=
32 **err_flags_ptr)
 		struct msr m, m_tmp;
 		u32 level =3D 1;
=20
-		boot_rdmsr(0x80860004, &m);
+		raw_rdmsr(0x80860004, &m);
 		m_tmp =3D m;
 		m_tmp.l =3D ~0;
-		boot_wrmsr(0x80860004, &m_tmp);
+		raw_wrmsr(0x80860004, &m_tmp);
 		asm("cpuid"
 		    : "+a" (level), "=3Dd" (cpu.flags[0])
 		    : : "ecx", "ebx");
-		boot_wrmsr(0x80860004, &m);
+		raw_wrmsr(0x80860004, &m);
=20
 		err =3D check_cpuflags();
 	} else if (err =3D=3D 0x01 &&
diff --git a/arch/x86/boot/msr.h b/arch/x86/boot/msr.h
deleted file mode 100644
index aed66f7..0000000
--- a/arch/x86/boot/msr.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Helpers/definitions related to MSR access.
- */
-
-#ifndef BOOT_MSR_H
-#define BOOT_MSR_H
-
-#include <asm/shared/msr.h>
-
-/*
- * The kernel proper already defines rdmsr()/wrmsr(), but they are not for t=
he
- * boot kernel since they rely on tracepoint/exception handling infrastructu=
re
- * that's not available here.
- */
-static inline void boot_rdmsr(unsigned int reg, struct msr *m)
-{
-	asm volatile("rdmsr" : "=3Da" (m->l), "=3Dd" (m->h) : "c" (reg));
-}
-
-static inline void boot_wrmsr(unsigned int reg, const struct msr *m)
-{
-	asm volatile("wrmsr" : : "c" (reg), "a"(m->l), "d" (m->h) : "memory");
-}
-
-#endif /* BOOT_MSR_H */
diff --git a/arch/x86/include/asm/shared/msr.h b/arch/x86/include/asm/shared/=
msr.h
index 1e6ec10..a20b1c0 100644
--- a/arch/x86/include/asm/shared/msr.h
+++ b/arch/x86/include/asm/shared/msr.h
@@ -12,4 +12,19 @@ struct msr {
 	};
 };
=20
+/*
+ * The kernel proper already defines rdmsr()/wrmsr(), but they are not for t=
he
+ * boot kernel since they rely on tracepoint/exception handling infrastructu=
re
+ * that's not available here.
+ */
+static inline void raw_rdmsr(unsigned int reg, struct msr *m)
+{
+	asm volatile("rdmsr" : "=3Da" (m->l), "=3Dd" (m->h) : "c" (reg));
+}
+
+static inline void raw_wrmsr(unsigned int reg, const struct msr *m)
+{
+	asm volatile("wrmsr" : : "c" (reg), "a"(m->l), "d" (m->h) : "memory");
+}
+
 #endif /* _ASM_X86_SHARED_MSR_H */

