Return-Path: <linux-tip-commits+bounces-6795-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52715BD83E9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 10:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19E314E3638
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 08:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A241C31076C;
	Tue, 14 Oct 2025 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HBzDMGVe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dwa7YSwT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C901430FC2C;
	Tue, 14 Oct 2025 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431360; cv=none; b=uMhesCSe+/yq7KVFCci/1MPrD1McY5b+um9Eab5xs1G/x9z3gQHm4Mmh0wR3NSwITxap3HF3q1ExBaTjJj+NW0KooLAEYOhYIiaONWirDzpBdAgwW/h/wP6JhDkmi2FjD4w6JyQvrjAbZToyW1Pa9HKaWIH/+dViLhQl8Ayx8S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431360; c=relaxed/simple;
	bh=kVhvOv4HQB55yfpTiXaG6J/q6JHEzukVPdcBOiz1YD0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GUVmmj0rLMQ81ieyTfvTxau+SGIgoHVzcpQpaRdFxczDDGM11gMbdogjfmlpCuMAkmQqWvNfp2S9uZAO2Oj8FJ5JSrBu0Jm3sV5ToeJrrcA0LhmxlXIVBqldYDu/UtRuAtCzEsOkOPNvNAPKREWNUI88z/9v/VFAMZOPbD8L31Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HBzDMGVe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dwa7YSwT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 Oct 2025 08:42:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760431357;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5D/5DkrLWN6Zy8CmWUQeLfnDv6qGUq7pbUvhyssgDI=;
	b=HBzDMGVetIMHPvNOWgSSuU8CL8mJfHiJShOW6moPtI1uE176uA9xeGE7HPOyd431V0fiNT
	CAyojUg2GkLnFYd+u9BlPlpENoSLdri3hyAFH2w4uOiCjxmYLUKFGVsUXZQvzeoxQmnL/4
	KpU6G1khaXNoA5fcZQmnTX7vxIN9BuCeSdjBYbQ/GPESbyT0UmE2HOzMpwrJAzb581m64I
	irz/3U9uPZZ/qbGX1uD5d4dUZHdjSK5sRmzVd46kG9g37qxN/qQa+/yg37Mrr4+dI7q5KI
	ANSv346/AzysI8J+K2rMJEdhdAQTws8x0dD9IWNijp2dxonn6DATVms1G7RVRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760431357;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5D/5DkrLWN6Zy8CmWUQeLfnDv6qGUq7pbUvhyssgDI=;
	b=dwa7YSwTUQIc9EoAxCSHEDPdLGXDTIYGUx+v/YuMU9hEzuJSu/6T+9eyKMlsP7nXvQpyfj
	hKqzedlZ9vqfRyCA==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/alternative: Refactor apply_alternatives()
Cc: Juergen Gross <jgross@suse.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250929112947.27267-3-jgross@suse.com>
References: <20250929112947.27267-3-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176043135576.709179.11168250550408236671.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     9f6a53b4ecc6800b0db5463071ce95a0afab6746
Gitweb:        https://git.kernel.org/tip/9f6a53b4ecc6800b0db5463071ce95a0afa=
b6746
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 29 Sep 2025 13:29:46 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 14 Oct 2025 10:38:11 +02:00

x86/alternative: Refactor apply_alternatives()

Refactor apply_alternatives() by splitting out patching of a single
alt_instr instance into a sub-function.

Keep the final text_poke_early() call in apply_alternatives() in
order to prepare merging multiple alternative patching instances of
the same location.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c | 60 ++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 4f3ea50..d86a012 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -604,6 +604,34 @@ static inline u8 * instr_va(struct alt_instr *i)
 	return (u8 *)&i->instr_offset + i->instr_offset;
 }
=20
+static void __init_or_module apply_one_alternative(u8 *instr, u8 *insn_buff,
+						   struct alt_instr *a)
+{
+	u8 *replacement =3D (u8 *)&a->repl_offset + a->repl_offset;
+	unsigned int insn_buff_sz;
+
+	DPRINTK(ALT, "feat: %d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d=
) flags: 0x%x",
+		a->cpuid >> 5,
+		a->cpuid & 0x1f,
+		instr, instr, a->instrlen,
+		replacement, a->replacementlen, a->flags);
+
+	memcpy(insn_buff, replacement, a->replacementlen);
+	insn_buff_sz =3D a->replacementlen;
+
+	if (a->flags & ALT_FLAG_DIRECT_CALL)
+		insn_buff_sz =3D alt_replace_call(instr, insn_buff, a);
+
+	for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
+		insn_buff[insn_buff_sz] =3D 0x90;
+
+	text_poke_apply_relocation(insn_buff, instr, a->instrlen, replacement, a->r=
eplacementlen);
+
+	DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
+	DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", replac=
ement);
+	DUMP_BYTES(ALT, insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
+}
+
 /*
  * Replace instructions with better alternatives for this CPU type. This runs
  * before SMP is initialized to avoid SMP problems with self modifying code.
@@ -618,7 +646,7 @@ void __init_or_module noinline apply_alternatives(struct =
alt_instr *start,
 						  struct alt_instr *end)
 {
 	u8 insn_buff[MAX_PATCH_LEN];
-	u8 *instr, *replacement;
+	u8 *instr;
 	struct alt_instr *a, *b;
=20
 	DPRINTK(ALT, "alt table %px, -> %px", start, end);
@@ -643,8 +671,6 @@ void __init_or_module noinline apply_alternatives(struct =
alt_instr *start,
 	 * order.
 	 */
 	for (a =3D start; a < end; a++) {
-		unsigned int insn_buff_sz =3D 0;
-
 		/*
 		 * In case of nested ALTERNATIVE()s the outer alternative might
 		 * add more padding. To ensure consistent patching find the max
@@ -657,7 +683,6 @@ void __init_or_module noinline apply_alternatives(struct =
alt_instr *start,
 		}
=20
 		instr =3D instr_va(a);
-		replacement =3D (u8 *)&a->repl_offset + a->repl_offset;
 		BUG_ON(a->instrlen > sizeof(insn_buff));
 		BUG_ON(a->cpuid >=3D (NCAPINTS + NBUGINTS) * 32);
=20
@@ -670,32 +695,11 @@ void __init_or_module noinline apply_alternatives(struc=
t alt_instr *start,
 		if (!boot_cpu_has(a->cpuid) =3D=3D !(a->flags & ALT_FLAG_NOT)) {
 			memcpy(insn_buff, instr, a->instrlen);
 			optimize_nops(instr, insn_buff, a->instrlen);
-			text_poke_early(instr, insn_buff, a->instrlen);
-			continue;
+		} else {
+			apply_one_alternative(instr, insn_buff, a);
 		}
=20
-		DPRINTK(ALT, "feat: %d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %=
d) flags: 0x%x",
-			a->cpuid >> 5,
-			a->cpuid & 0x1f,
-			instr, instr, a->instrlen,
-			replacement, a->replacementlen, a->flags);
-
-		memcpy(insn_buff, replacement, a->replacementlen);
-		insn_buff_sz =3D a->replacementlen;
-
-		if (a->flags & ALT_FLAG_DIRECT_CALL)
-			insn_buff_sz =3D alt_replace_call(instr, insn_buff, a);
-
-		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
-			insn_buff[insn_buff_sz] =3D 0x90;
-
-		text_poke_apply_relocation(insn_buff, instr, a->instrlen, replacement, a->=
replacementlen);
-
-		DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
-		DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", repla=
cement);
-		DUMP_BYTES(ALT, insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
-
-		text_poke_early(instr, insn_buff, insn_buff_sz);
+		text_poke_early(instr, insn_buff, a->instrlen);
 	}
=20
 	kasan_enable_current();

