Return-Path: <linux-tip-commits+bounces-6547-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FD6B52A1F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 09:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD8F18871D2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 07:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4C6266580;
	Thu, 11 Sep 2025 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="poKKfTfi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SVXItIt3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE851DE2A7;
	Thu, 11 Sep 2025 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576096; cv=none; b=VJCzw3h67bbsDhpdjiGqXQTyO+8Kk6xSUmYz7p6trz5Vw0QwYADdf6d2zlkkk/9ct5AQjOT4ZX8KITkcaIrJ2xc9hSfmtjI1StssiP91M1KWHZVHJq6e/qhn3RElD+t76uejMG2cPtP7zkJB+yW2EW1arBBTsjIYgdjwuv3MjB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576096; c=relaxed/simple;
	bh=YnD6SEI1WZh0MYhUwCS/gp1b+rKJdRKxBtvCBIyavic=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=MWlQSuCkqyC1D85dzAs09kPTt1/mVvPxIwvGfFBfu5yX6Pd7nCrzvS4DTd0l7JzIlsmbGBKIPL3mCXfUVn6VVDsXAxdZneQok/I8RCnXk5QI+HGjBZ3l9sExTsTVis+yfHUcf2IjZGAnDvC9gLXud+BJuBCAqnjfiqzt6EQY6v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=poKKfTfi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SVXItIt3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 07:34:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757576093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YWHBnsNjpPGHygAgft+7DXTnZEKTgju0iT/ahBDc6rQ=;
	b=poKKfTfi3R535Bvf6xMZoiE03NUEXrVO0BrFl6UWNBkVofJEJ8sMaEtz3ayWgNeoJhHDbe
	5qonr8apqUvfwXtkxehIZe04MYz1FVk2jtMGzKICm2XnYLzThxd5lU4lYjm9TUpuUNyoXU
	aI8nGFv9fSco73OH6oeXI3f4hDDzf3HyRbxhbHPmQO0Z3ue5GSTSKeK7LY7i/B4W8mwDUL
	pLasvzXkbTG69F50LqQeidQcetZX/ZBw0vp3f77DiLEmHXS3FEwDbsZjuLVjbBJnoKMnWH
	qe6D9JXievxBwMuyhjXLhQFb3gBzT5XuweapmaPfQjAKmsJlG69Hx8mwMGD5zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757576093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YWHBnsNjpPGHygAgft+7DXTnZEKTgju0iT/ahBDc6rQ=;
	b=SVXItIt3Zs8ojCkcM5B//HxZzFMQLl1JAixq/NQpDjTNFsaluUX+8mkx8gYMxjKJwj/gHd
	1eid+toj/wdmgMCQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86,retpoline: Optimize patch_retpoline()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175757609204.709179.6413279343921603547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     4a1e02b15ac174c3c6d5e358e67c4ba980e7b336
Gitweb:        https://git.kernel.org/tip/4a1e02b15ac174c3c6d5e358e67c4ba980e=
7b336
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 02 Sep 2025 11:20:35 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Sep 2025 21:59:09 +02:00

x86,retpoline: Optimize patch_retpoline()

Currently the very common retpoline: "CS CALL __x86_indirect_thunk_r11"
is transformed into "CALL *R11; NOP3" for eIBRS/BHI_NO parts.

Similarly, paranoid fineibt has: "CALL *R11; NOP".

Recognise that CS stuffing can avoid the extra NOP. However, due to
prefix decode penalties, make sure to not emit too many CS prefixes.
Notably: "CS CALL __x86_indirect_thunk_rax" must not become "CS CS CS
CS CALL *RAX". Prefix decode penalties are typically many more cycles
than decoding an extra NOP.

Additionally, if the retpoline is a tail-call, the "JMP *%\reg" should
be followed by INT3 for straight-line-speculation mitigation, since
emit_indirect() now has a length argument, move this into
emit_indirect() such that other users (paranoid-fineibt) also do this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250902104627.GM4068168@noisy.programming.ki=
cks-ass.net
---
 arch/x86/kernel/alternative.c | 42 +++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 3d6a884..69fb818 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -713,20 +713,33 @@ static inline bool is_jcc32(struct insn *insn)
 #if defined(CONFIG_MITIGATION_RETPOLINE) && defined(CONFIG_OBJTOOL)
=20
 /*
- * CALL/JMP *%\reg
+ * [CS]{,3} CALL/JMP *%\reg [INT3]*
  */
-static int emit_indirect(int op, int reg, u8 *bytes)
+static int emit_indirect(int op, int reg, u8 *bytes, int len)
 {
+	int cs =3D 0, bp =3D 0;
 	int i =3D 0;
 	u8 modrm;
=20
+	/*
+	 * Set @len to the excess bytes after writing the instruction.
+	 */
+	len -=3D 2 + (reg >=3D 8);
+	WARN_ON_ONCE(len < 0);
+
 	switch (op) {
 	case CALL_INSN_OPCODE:
 		modrm =3D 0x10; /* Reg =3D 2; CALL r/m */
+		/*
+		 * Additional NOP is better than prefix decode penalty.
+		 */
+		if (len <=3D 3)
+			cs =3D len;
 		break;
=20
 	case JMP32_INSN_OPCODE:
 		modrm =3D 0x20; /* Reg =3D 4; JMP r/m */
+		bp =3D len;
 		break;
=20
 	default:
@@ -734,6 +747,9 @@ static int emit_indirect(int op, int reg, u8 *bytes)
 		return -1;
 	}
=20
+	while (cs--)
+		bytes[i++] =3D 0x2e; /* CS-prefix */
+
 	if (reg >=3D 8) {
 		bytes[i++] =3D 0x41; /* REX.B prefix */
 		reg -=3D 8;
@@ -745,6 +761,9 @@ static int emit_indirect(int op, int reg, u8 *bytes)
 	bytes[i++] =3D 0xff; /* opcode */
 	bytes[i++] =3D modrm;
=20
+	while (bp--)
+		bytes[i++] =3D 0xcc; /* INT3 */
+
 	return i;
 }
=20
@@ -918,20 +937,11 @@ static int patch_retpoline(void *addr, struct insn *ins=
n, u8 *bytes)
 		return emit_its_trampoline(addr, insn, reg, bytes);
 #endif
=20
-	ret =3D emit_indirect(op, reg, bytes + i);
+	ret =3D emit_indirect(op, reg, bytes + i, insn->length - i);
 	if (ret < 0)
 		return ret;
 	i +=3D ret;
=20
-	/*
-	 * The compiler is supposed to EMIT an INT3 after every unconditional
-	 * JMP instruction due to AMD BTC. However, if the compiler is too old
-	 * or MITIGATION_SLS isn't enabled, we still need an INT3 after
-	 * indirect JMPs even on Intel.
-	 */
-	if (op =3D=3D JMP32_INSN_OPCODE && i < insn->length)
-		bytes[i++] =3D INT3_INSN_OPCODE;
-
 	for (; i < insn->length;)
 		bytes[i++] =3D BYTES_NOP1;
=20
@@ -1421,8 +1431,7 @@ asm(	".pushsection .rodata				\n"
 	"#fineibt_caller_size:                          \n"
 	"	jne	fineibt_paranoid_start+0xd	\n"
 	"fineibt_paranoid_ind:				\n"
-	"	call	*%r11				\n"
-	"	nop					\n"
+	"	cs call	*%r11				\n"
 	"fineibt_paranoid_end:				\n"
 	".popsection					\n"
 );
@@ -1724,8 +1733,9 @@ static int cfi_rewrite_callers(s32 *start, s32 *end)
 			emit_paranoid_trampoline(addr + fineibt_caller_size,
 						 &insn, 11, bytes + fineibt_caller_size);
 		} else {
-			ret =3D emit_indirect(op, 11, bytes + fineibt_paranoid_ind);
-			if (WARN_ON_ONCE(ret !=3D 3))
+			int len =3D fineibt_paranoid_size - fineibt_paranoid_ind;
+			ret =3D emit_indirect(op, 11, bytes + fineibt_paranoid_ind, len);
+			if (WARN_ON_ONCE(ret !=3D len))
 				continue;
 		}
=20

