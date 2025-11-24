Return-Path: <linux-tip-commits+bounces-7485-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A68C7F7F4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEE0D4E3E4B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1452F6199;
	Mon, 24 Nov 2025 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nkKu8QHw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6JyyqF7F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607ED2F5A39;
	Mon, 24 Nov 2025 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975505; cv=none; b=XfoPPFdTwGrEw6HqyOP5lRqCeq9j7OCBPv9jPshe2oOjBSDGQTMlllISRZeX8vXPRq7KD2oSuhs/VZu5iR95nCGOIBSzCtA0jZt42bakXQd2mG2hcRn/GJ4vs9i8RmDKCdNQimbdB0qOTOAVFO32D3LKDdqRdxkOUH7O02Spkjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975505; c=relaxed/simple;
	bh=ebwkFI5SNMyPqiThkNITvywhzsAdnOB+tDTLsZusWdc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=vAkbyfAKf8Kk3f15RIjQ0E6z3cC8dX4ZVHqAc58WIP7NfSxFpSAH2vQ1DUQOURr4JV5SMC/rLkg4O14nD8w/zge1GN3ZPrlHuDxmlygJeXuDo1nGXgiqq9HqDo0B/CNP+4X9p/lqnkGMD2FayfZ4cMga/R5I/P7RjWAWyw90qEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nkKu8QHw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6JyyqF7F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975501;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyikQ4kIFcCo1CLKS3bPZxDWm5K20D23zVFPNieNJXs=;
	b=nkKu8QHwwkvCq2SPubzW9rpsutC4/T+t2jntDpzDvQGnYEo+7B1VZAeYnuyCrhSm2qI4i7
	WdeEvSqhuXukwztOqQNe02u+t/CrIj9HT/uuVhriEkKPYUa9jE3Z3sdbjbFU2RNmjKLSWB
	yZBFGw/1JSW42TP51YSBd0W9pVXxcjlh5q65HTbweD7gIPFHT6ab2roz2CILyl7CJ54LQ5
	91AbA8BV4KxMoJmrxUele3HWhHgjWtkLcfQdYof9GPOmG3Vfmsqf2YNos3Uhc18t0vyC9G
	pNdlTjeH5FzPPkostLiZ+rr0775zz6k+/Pf/DdC/1ZtfPtllnxRtfXXV/3zOpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975501;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyikQ4kIFcCo1CLKS3bPZxDWm5K20D23zVFPNieNJXs=;
	b=6JyyqF7Fl10RIOroBJQJC9W8MaxlLejOjrovzaiQ4ysczNt8ai5OgdK+tgbp2nEfp4Plj2
	Pnh6SsPkpL1AP/BA==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Disassemble jump table alternatives
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-24-alexandre.chartre@oracle.com>
References: <20251121095340.464045-24-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397550061.498.1666291751871643598.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     7e017720aae87dc2ca2471ac295e34e2b240e5f5
Gitweb:        https://git.kernel.org/tip/7e017720aae87dc2ca2471ac295e34e2b24=
0e5f5
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:33 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:14 +01:00

objtool: Disassemble jump table alternatives

When using the --disas option, also disassemble jump tables.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-24-alexandre.chartre@ora=
cle.com
---
 tools/objtool/disas.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 018aba3..326e16c 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -639,6 +639,34 @@ static int disas_alt_add_insn(struct disas_alt *dalt, in=
t index, char *insn_str,
 	return 0;
 }
=20
+static int disas_alt_jump(struct disas_alt *dalt)
+{
+	struct instruction *orig_insn;
+	struct instruction *dest_insn;
+	char suffix[2] =3D { 0 };
+	char *str;
+
+	orig_insn =3D dalt->orig_insn;
+	dest_insn =3D dalt->alt->insn;
+
+	if (orig_insn->type =3D=3D INSN_NOP) {
+		if (orig_insn->len =3D=3D 5)
+			suffix[0] =3D 'q';
+		str =3D strfmt("jmp%-3s %lx <%s+0x%lx>", suffix,
+			     dest_insn->offset, dest_insn->sym->name,
+			     dest_insn->offset - dest_insn->sym->offset);
+	} else {
+		str =3D strfmt("nop%d", orig_insn->len);
+	}
+
+	if (!str)
+		return -1;
+
+	disas_alt_add_insn(dalt, 0, str, 0);
+
+	return 1;
+}
+
 /*
  * Disassemble an exception table alternative.
  */
@@ -809,10 +837,7 @@ static void *disas_alt(struct disas_context *dctx,
 			goto done;
 		}
=20
-		/*
-		 * Only group alternatives and exception tables are
-		 * supported at the moment.
-		 */
+		count =3D -1;
 		switch (dalt->alt->type) {
 		case ALT_TYPE_INSTRUCTIONS:
 			count =3D disas_alt_group(dctx, dalt);
@@ -820,8 +845,9 @@ static void *disas_alt(struct disas_context *dctx,
 		case ALT_TYPE_EX_TABLE:
 			count =3D disas_alt_extable(dalt);
 			break;
-		default:
-			count =3D 0;
+		case ALT_TYPE_JUMP_TABLE:
+			count =3D disas_alt_jump(dalt);
+			break;
 		}
 		if (count < 0) {
 			WARN("%s: failed to disassemble alternative %s",

