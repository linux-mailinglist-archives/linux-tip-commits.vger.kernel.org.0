Return-Path: <linux-tip-commits+bounces-6825-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92030BE2683
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6829B1A611C6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EE33191AB;
	Thu, 16 Oct 2025 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yG+caBVd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fE0n5Cjl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6B33191B7;
	Thu, 16 Oct 2025 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607198; cv=none; b=qO5zxeoQwkvnGNR0CalBanLEin1m6JjgNEGNY1rrKDXKuDaH6rux4UWiyJZTKa0dOBhZv6jhxbnsHciyZTIvrZzVLhRTlP70ppxJLb2eqR42313E7Ac4JsmjzUaueI0LRKO+LwY8PlPo7/8Rp24OkvCrRoZUFkNI8h4bwnwyNl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607198; c=relaxed/simple;
	bh=8Db3SmyBnNcRr3O8RMQ0it/B2qBCiRHLKXaJweH7IzE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Ooqlj5Vy4M++D5p1JJQoNM4GLJYu4J/D6C6dxAkCQFsNo2tUE6Cfffqs2/Ua0NwYXYFHpvDhuLsE09QOh99VLzGbPSAqGNCFHhn5LJOPaw8VUYUuBoRKuobK4wOKyMXCLpXTn7R9tzwtPwPR5271dmo6LaQrvf6OBy7wK2bTXpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yG+caBVd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fE0n5Cjl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607194;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=syBbUaEZCZCNtkstUyTP9nU7UJf9TOt8rA87Ljmi6Bc=;
	b=yG+caBVddepTKjuT5AvOlONL30KBY2eGEr8y+6AD/mIy8hHQl4lP6CBeXtmSrZT01TVxNf
	Zd+DxlqN/Y8qTnyBQG2wtnBKgZ2q3AtvqZiNyn+T5rUJXrShw889mi1thxDBnXmrZGuD6D
	mrIvPO8FwSgbak0TG2AbteWH85dfr+VsYE+gmWp7j/6ud13Yqu6ghA6zdAjfezBg3UDswH
	Rhj4FW+Jb0TBlSQwIdgXB9EtrN1x5ygGYqtDlHpk7lV+v391NnMXFiaaK+nkv1oTuU5JOb
	vIIx/J54FLM/IqZXKBHBvWRWQrAFIHQRAMEPv4N+Dc8ODEaNpzGgy+ekXfMgxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607194;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=syBbUaEZCZCNtkstUyTP9nU7UJf9TOt8rA87Ljmi6Bc=;
	b=fE0n5CjlzsFUFOOI1FghClzSEx3oiVbyjRTQmAGJTqsd993CDtmdQY32iGMOe5rLOu75Yg
	veXjbnj20Jl080Aw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/insn,uprobes,alternative: Unify insn_is_nop()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060719311.709179.13267555539890490488.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8a5c6cbfe4a35c6a22d2f8bbaf49b8cc3f45fcc6
Gitweb:        https://git.kernel.org/tip/8a5c6cbfe4a35c6a22d2f8bbaf49b8cc3f4=
5fcc6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 05 Sep 2025 10:24:47 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:47 +02:00

x86/insn,uprobes,alternative: Unify insn_is_nop()

Both uprobes and alternatives have insn_is_nop() variants, unify them
and make sure insn_is_nop() works for both x86_64 and i386.

Specifically, uprobe must not compare userspace instructions to kernel
nops as that does not work right in the compat case.

For the uprobe case we therefore must recognise common 32bit and 64bit
nops. Because uprobe will consume the instruction as a nop, it must
not mistakenly claim a non-nop instruction to be a nop. Eg. 'REX.b3
NOP' is 'xchg %r8,%rax' - not a nop.

For the kernel case similar constraints apply, is it used to optimize
NOPs by replacing strings of short(er) nops with longer nops. Must not
claim an instruction is a nop if it really isn't. Not recognising a
nop is non-fatal.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/insn-eval.h |   2 +-
 arch/x86/kernel/alternative.c    |  20 +----
 arch/x86/kernel/uprobes.c        |  32 +-------
 arch/x86/lib/insn-eval.c         | 145 ++++++++++++++++++++++++++++++-
 4 files changed, 151 insertions(+), 48 deletions(-)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eva=
l.h
index 54368a4..4733e90 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -44,4 +44,6 @@ enum insn_mmio_type {
=20
 enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
=20
+bool insn_is_nop(struct insn *insn);
+
 #endif /* _ASM_X86_INSN_EVAL_H */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8ee5ff5..58ce2bd 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -9,6 +9,7 @@
=20
 #include <asm/text-patching.h>
 #include <asm/insn.h>
+#include <asm/insn-eval.h>
 #include <asm/ibt.h>
 #include <asm/set_memory.h>
 #include <asm/nmi.h>
@@ -346,25 +347,6 @@ static void add_nop(u8 *buf, unsigned int len)
 }
=20
 /*
- * Matches NOP and NOPL, not any of the other possible NOPs.
- */
-static bool insn_is_nop(struct insn *insn)
-{
-	/* Anything NOP, but no REP NOP */
-	if (insn->opcode.bytes[0] =3D=3D 0x90 &&
-	    (!insn->prefixes.nbytes || insn->prefixes.bytes[0] !=3D 0xF3))
-		return true;
-
-	/* NOPL */
-	if (insn->opcode.bytes[0] =3D=3D 0x0F && insn->opcode.bytes[1] =3D=3D 0x1F)
-		return true;
-
-	/* TODO: more nops */
-
-	return false;
-}
-
-/*
  * Find the offset of the first non-NOP instruction starting at @offset
  * but no further than @len.
  */
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 845aeaf..6318898 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -17,6 +17,7 @@
 #include <linux/kdebug.h>
 #include <asm/processor.h>
 #include <asm/insn.h>
+#include <asm/insn-eval.h>
 #include <asm/mmu_context.h>
 #include <asm/nops.h>
=20
@@ -1158,35 +1159,12 @@ unlock:
 	mmap_write_unlock(mm);
 }
=20
-static bool insn_is_nop(struct insn *insn)
-{
-	return insn->opcode.nbytes =3D=3D 1 && insn->opcode.bytes[0] =3D=3D 0x90;
-}
-
-static bool insn_is_nopl(struct insn *insn)
-{
-	if (insn->opcode.nbytes !=3D 2)
-		return false;
-
-	if (insn->opcode.bytes[0] !=3D 0x0f || insn->opcode.bytes[1] !=3D 0x1f)
-		return false;
-
-	if (!insn->modrm.nbytes)
-		return false;
-
-	if (X86_MODRM_REG(insn->modrm.bytes[0]) !=3D 0)
-		return false;
-
-	/* 0f 1f /0 - NOPL */
-	return true;
-}
-
 static bool can_optimize(struct insn *insn, unsigned long vaddr)
 {
 	if (!insn->x86_64 || insn->length !=3D 5)
 		return false;
=20
-	if (!insn_is_nop(insn) && !insn_is_nopl(insn))
+	if (!insn_is_nop(insn))
 		return false;
=20
 	/* We can't do cross page atomic writes yet. */
@@ -1428,17 +1406,13 @@ static int branch_setup_xol_ops(struct arch_uprobe *a=
uprobe, struct insn *insn)
 	insn_byte_t p;
 	int i;
=20
-	/* x86_nops[insn->length]; same as jmp with .offs =3D 0 */
-	if (insn->length <=3D ASM_NOP_MAX &&
-	    !memcmp(insn->kaddr, x86_nops[insn->length], insn->length))
+	if (insn_is_nop(insn))
 		goto setup;
=20
 	switch (opc1) {
 	case 0xeb:	/* jmp 8 */
 	case 0xe9:	/* jmp 32 */
 		break;
-	case 0x90:	/* prefix* + nop; same as jmp with .offs =3D 0 */
-		goto setup;
=20
 	case 0xe8:	/* call relative */
 		branch_clear_offset(auprobe, insn);
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 4e385cb..c991dac 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1676,3 +1676,148 @@ enum insn_mmio_type insn_decode_mmio(struct insn *ins=
n, int *bytes)
=20
 	return type;
 }
+
+/*
+ * Recognise typical NOP patterns for both 32bit and 64bit.
+ *
+ * Notably:
+ *  - NOP, but not: REP NOP aka PAUSE
+ *  - NOPL
+ *  - MOV %reg, %reg
+ *  - LEA 0(%reg),%reg
+ *  - JMP +0
+ *
+ * Must not have false-positives; instructions identified as a NOP might be
+ * emulated as a NOP (uprobe) or Run Length Encoded in a larger NOP
+ * (alternatives).
+ *
+ * False-negatives are fine; need not be exhaustive.
+ */
+bool insn_is_nop(struct insn *insn)
+{
+	u8 b3 =3D 0, x3 =3D 0, r3 =3D 0;
+	u8 b4 =3D 0, x4 =3D 0, r4 =3D 0, m =3D 0;
+	u8 modrm, modrm_mod, modrm_reg, modrm_rm;
+	u8 sib =3D 0, sib_scale, sib_index, sib_base;
+	u8 nrex, rex;
+	u8 p, rep =3D 0;
+	int i;
+
+	if ((nrex =3D insn->rex_prefix.nbytes)) {
+		rex =3D insn->rex_prefix.bytes[nrex-1];
+
+		r3 =3D !!X86_REX_R(rex);
+		x3 =3D !!X86_REX_X(rex);
+		b3 =3D !!X86_REX_B(rex);
+		if (nrex > 1) {
+			r4 =3D !!X86_REX2_R(rex);
+			x4 =3D !!X86_REX2_X(rex);
+			b4 =3D !!X86_REX2_B(rex);
+			m  =3D !!X86_REX2_M(rex);
+		}
+
+	} else if (insn->vex_prefix.nbytes) {
+		/*
+		 * Ignore VEX encoded NOPs
+		 */
+		return false;
+	}
+
+	if (insn->modrm.nbytes) {
+		modrm =3D insn->modrm.bytes[0];
+		modrm_mod =3D X86_MODRM_MOD(modrm);
+		modrm_reg =3D X86_MODRM_REG(modrm) + 8*r3 + 16*r4;
+		modrm_rm  =3D X86_MODRM_RM(modrm)  + 8*b3 + 16*b4;
+		modrm =3D 1;
+	}
+
+	if (insn->sib.nbytes) {
+		sib =3D insn->sib.bytes[0];
+		sib_scale =3D X86_SIB_SCALE(sib);
+		sib_index =3D X86_SIB_INDEX(sib) + 8*x3 + 16*x4;
+		sib_base  =3D X86_SIB_BASE(sib)  + 8*b3 + 16*b4;
+		sib =3D 1;
+
+		modrm_rm =3D sib_base;
+	}
+
+	for_each_insn_prefix(insn, i, p) {
+		if (p =3D=3D 0xf3) /* REPE */
+			rep =3D 1;
+	}
+
+	/*
+	 * Opcode map munging:
+	 *
+	 * REX2: 0 - single byte opcode
+	 *       1 - 0f second byte opcode
+	 */
+	switch (m) {
+	case 0: break;
+	case 1: insn->opcode.value <<=3D 8;
+		insn->opcode.value |=3D 0x0f;
+		break;
+	default:
+		return false;
+	}
+
+	switch (insn->opcode.bytes[0]) {
+	case 0x0f: /* 2nd byte */
+		break;
+
+	case 0x89: /* MOV */
+		if (modrm_mod !=3D 3) /* register-direct */
+			return false;
+
+		/* native size */
+		if (insn->opnd_bytes !=3D 4 * (1 + insn->x86_64))
+			return false;
+
+		return modrm_reg =3D=3D modrm_rm; /* MOV %reg, %reg */
+
+	case 0x8d: /* LEA */
+		if (modrm_mod =3D=3D 0 || modrm_mod =3D=3D 3) /* register-indirect with di=
sp */
+			return false;
+
+		/* native size */
+		if (insn->opnd_bytes !=3D 4 * (1 + insn->x86_64))
+			return false;
+
+		if (insn->displacement.value !=3D 0)
+			return false;
+
+		if (sib && (sib_scale !=3D 0 || sib_index !=3D 4)) /* (%reg, %eiz, 1) */
+			return false;
+
+		for_each_insn_prefix(insn, i, p) {
+			if (p !=3D 0x3e) /* DS */
+				return false;
+		}
+
+		return modrm_reg =3D=3D modrm_rm; /* LEA 0(%reg), %reg */
+
+	case 0x90: /* NOP */
+		if (b3 || b4) /* XCHG %r{8,16,24},%rax */
+			return false;
+
+		if (rep) /* REP NOP :=3D PAUSE */
+			return false;
+
+		return true;
+
+	case 0xe9: /* JMP.d32 */
+	case 0xeb: /* JMP.d8 */
+		return insn->immediate.value =3D=3D 0; /* JMP +0 */
+
+	default:
+		return false;
+	}
+
+	switch (insn->opcode.bytes[1]) {
+	case 0x1f:
+		return modrm_reg =3D=3D 0; /* 0f 1f /0 -- NOPL */
+
+	default:
+		return false;
+	}
+}

