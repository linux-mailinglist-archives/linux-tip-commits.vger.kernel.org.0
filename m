Return-Path: <linux-tip-commits+bounces-7496-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A1FC7F86C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C220D3A8727
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7812FCBEA;
	Mon, 24 Nov 2025 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VdIXQGbG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IQI2wrXU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9782FBE1D;
	Mon, 24 Nov 2025 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975517; cv=none; b=so02ljGkotqSoFIDZdaDnDdU36gDuTuM2oJE01Qgzfrp4cH0Yi14U4sW3AwiU3BDJ1JT3X/slfzyjklAyAeNW6g2sSKjaYxsT/AOQ7g8c21HdE083zWFKzmw6FVLgXqc8WS0nhWV1ya+0R5/TwzLCIDnvozk1t0JsJ6Yu9CR5Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975517; c=relaxed/simple;
	bh=uQUG5/ZWHhQMVZ0Laf3TKk6piRVjy8lZU91n2iX5djo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tGs4CZFv9DF0cDTrY5Zsn5PGhRfNISZfm28g2FZ5rCwoVuReBMpHxiIPZ/468LRx6Pbe3dlDgUuJAQc7qO3tZbND2xzobWh38xaj/0hFZmFHxFMTr6fWFDk3vRN7BBOCrLo5UBK6PEdKAF/Os9/wGjXWRpXoBQkhm7P2rWXRqKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VdIXQGbG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IQI2wrXU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975513;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vMVqfCch6IQxRMabVQk3M3+4p8tMteJ8D3OdXEAQ3Ds=;
	b=VdIXQGbGmCHGznLcXWVofE7mihTjDRoKz09uHj71mcocNhxQObSpsEyRsHsrgYaAcnMM41
	oUcf5N4bl33FG1wPfhnxA36PGHrYrxb0dmi5J5018zvemzutlIs0IEMpbxBqpmpf4OhIOS
	iemWeoJPGZ0ECR+gnMqNFYda4nlUpE/ZNUwdafifSp0Eje+y9IaPsm1Ryuu31NNaq7XVrM
	en/xhDKzHweHN9zvWIW4AbPLxo4t7aUo6WQyMCaCiRVRZodhtvHevVfNgrI2EUzHcClZ4W
	ZC63R9J0v383bhXlmgBE273ttj6qHRijfHtI+RO8kQ5yMl2n5U1vYWS8Cj31VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975513;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vMVqfCch6IQxRMabVQk3M3+4p8tMteJ8D3OdXEAQ3Ds=;
	b=IQI2wrXUvi1BwVzi5u2kdI78O+CTQJ2hyTnsWQkoZ67BHkm1JdVyEnVgfEY2MCorokkf9x
	mVJSRnd6x3o1YoAA==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Improve register reporting during
 function validation
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-13-alexandre.chartre@oracle.com>
References: <20251121095340.464045-13-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397551203.498.77947080837146316.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     26a453fb5637907a538d6ea5ef23651142811e15
Gitweb:        https://git.kernel.org/tip/26a453fb5637907a538d6ea5ef236511428=
11e15
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:22 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:10 +01:00

objtool: Improve register reporting during function validation

When tracing function validation, instruction state changes can
report changes involving registers. These registers are reported
with the name "r<num>" (e.g. "r3"). Print the CPU specific register
name instead of a generic name (e.g. print "rbx" instead of "r3"
on x86).

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-13-alexandre.chartre@ora=
cle.com
---
 tools/objtool/arch/loongarch/decode.c | 11 +++++++++++
 tools/objtool/arch/powerpc/decode.c   | 12 ++++++++++++
 tools/objtool/arch/x86/decode.c       |  8 ++++++++
 tools/objtool/include/objtool/arch.h  |  2 ++
 tools/objtool/trace.c                 |  7 +++++++
 5 files changed, 40 insertions(+)

diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loong=
arch/decode.c
index 1de86eb..6cd2881 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -8,6 +8,17 @@
 #include <linux/objtool_types.h>
 #include <arch/elf.h>
=20
+const char *arch_reg_name[CFI_NUM_REGS] =3D {
+	"zero", "ra", "tp", "sp",
+	"a0", "a1", "a2", "a3",
+	"a4", "a5", "a6", "a7",
+	"t0", "t1", "t2", "t3",
+	"t4", "t5", "t6", "t7",
+	"t8", "u0", "fp", "s0",
+	"s1", "s2", "s3", "s4",
+	"s5", "s6", "s7", "s8"
+};
+
 int arch_ftrace_match(const char *name)
 {
 	return !strcmp(name, "_mcount");
diff --git a/tools/objtool/arch/powerpc/decode.c b/tools/objtool/arch/powerpc=
/decode.c
index 4f68b40..e534ac1 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -9,6 +9,18 @@
 #include <objtool/warn.h>
 #include <objtool/builtin.h>
=20
+const char *arch_reg_name[CFI_NUM_REGS] =3D {
+	"r0",  "sp",  "r2",  "r3",
+	"r4",  "r5",  "r6",  "r7",
+	"r8",  "r9",  "r10", "r11",
+	"r12", "r13", "r14", "r15",
+	"r16", "r17", "r18", "r19",
+	"r20", "r21", "r22", "r23",
+	"r24", "r25", "r26", "r27",
+	"r28", "r29", "r30", "r31",
+	"ra"
+};
+
 int arch_ftrace_match(const char *name)
 {
 	return !strcmp(name, "_mcount");
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 83e9c60..f4af825 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -23,6 +23,14 @@
 #include <objtool/builtin.h>
 #include <arch/elf.h>
=20
+const char *arch_reg_name[CFI_NUM_REGS] =3D {
+	"rax", "rcx", "rdx", "rbx",
+	"rsp", "rbp", "rsi", "rdi",
+	"r8",  "r9",  "r10", "r11",
+	"r12", "r13", "r14", "r15",
+	"ra"
+};
+
 int arch_ftrace_match(const char *name)
 {
 	return !strcmp(name, "__fentry__");
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/obj=
tool/arch.h
index 18c0e69..8866158 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -103,6 +103,8 @@ bool arch_absolute_reloc(struct elf *elf, struct reloc *r=
eloc);
 unsigned int arch_reloc_size(struct reloc *reloc);
 unsigned long arch_jump_table_sym_offset(struct reloc *reloc, struct reloc *=
table);
=20
+extern const char *arch_reg_name[CFI_NUM_REGS];
+
 #ifdef DISAS
=20
 #include <bfd.h>
diff --git a/tools/objtool/trace.c b/tools/objtool/trace.c
index 12bbad0..d70d470 100644
--- a/tools/objtool/trace.c
+++ b/tools/objtool/trace.c
@@ -34,6 +34,7 @@ int trace_depth;
 static const char *cfi_reg_name(unsigned int reg)
 {
 	static char rname_buffer[CFI_REG_NAME_MAXLEN];
+	const char *rname;
=20
 	switch (reg) {
 	case CFI_UNDEFINED:
@@ -46,6 +47,12 @@ static const char *cfi_reg_name(unsigned int reg)
 		return "(bp)";
 	}
=20
+	if (reg < CFI_NUM_REGS) {
+		rname =3D arch_reg_name[reg];
+		if (rname)
+			return rname;
+	}
+
 	if (snprintf(rname_buffer, CFI_REG_NAME_MAXLEN, "r%d", reg) =3D=3D -1)
 		return "<error>";
=20

