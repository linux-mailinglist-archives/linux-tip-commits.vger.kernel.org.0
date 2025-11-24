Return-Path: <linux-tip-commits+bounces-7478-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3608EC7F7CD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5BF3734774B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218362F4A12;
	Mon, 24 Nov 2025 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ThHxSqgb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ru+ML8K9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B972F49E3;
	Mon, 24 Nov 2025 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975468; cv=none; b=s+PYxKOafxGxbfkvWeTsMSleQqefQPqb9AJ1h4hc/MLh0yt00HMgWRNYN1B+sWfqvVLrFVUemAGeCjHjgg18dejxdSkGtEuwyIKoD9Ho7i+kUwedDPFGhlZkZ8RTlrMKcf5yaWJgYivb9CfyXgvpIm/ZRXSBXxUmR92lSwDTy/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975468; c=relaxed/simple;
	bh=sp7l35yqm+vARRP4Na4EXeRtBeFhqL2dpH4zWL+0t4w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oEmc+YPeft+DEZSbBrDOqFycw6spfIHV7ktJog6415NraYoizV6nQYubuomER04BzvnIr0ymy+WNOP+konwXMvvjzUMXOPoL/iRpeao6gOSXTTcicBlNM9lWxYc3IetShiHH/nX8x5FvwM5i6GQGJYkQiXvRgB73GyAEXtAa1TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ThHxSqgb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ru+ML8K9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:10:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975463;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIN96ntcx3Zxlvq+FtCOHu6UiRLGtOTYzYoxgvei7gs=;
	b=ThHxSqgb3sK4sidY89Rf41tLFCYaqxjfeofzE+35zHXYkuglRn25J0g6+1iQGcANwipgpo
	+S/LvhYaCi5Voc3ReM0mY/A5NrlNOHOtrL0EKza0DKsqkNp7hmLEU0vgZo+0QwbHwSxKVX
	zqBtZLVHiBhHa60BO64ss3vXCNxKKa0Q8oqmySGl5sEX9LcFmrsQ+EORuuhu5cOkMJYWYl
	IVcYXvQU/O5noflLVGIy2fQnZ4ecxlWZr1WSqI3j56yY6ZuJ6nLOmBXFualut/gTgN8pG/
	K4OgHKC4pxXepZE05lyNGQURnDOCczOk0EU+A6z8tE4P4Li3wZn7vD+Wa65kbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975463;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIN96ntcx3Zxlvq+FtCOHu6UiRLGtOTYzYoxgvei7gs=;
	b=ru+ML8K9a4c3pAdfG2kcuQl+T788QBESyh5bsKuCSCEi1Cd/1vfQfHf2kGUBEb5QF+BESa
	0IOJOWWngiv90FCw==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Trim trailing NOPs in alternative
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-31-alexandre.chartre@oracle.com>
References: <20251121095340.464045-31-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397545859.498.4932407457783600909.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     5cabd49ced8a968e200397715477d7c563009d3e
Gitweb:        https://git.kernel.org/tip/5cabd49ced8a968e200397715477d7c5630=
09d3e
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:40 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:16 +01:00

objtool: Trim trailing NOPs in alternative

When disassembling alternatives replace trailing NOPs with a single
indication of the number of bytes covered with NOPs.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-31-alexandre.chartre@ora=
cle.com
---
 tools/objtool/disas.c | 78 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index f04bc14..441b930 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -52,6 +52,7 @@ struct disas_alt {
 	struct {
 		char *str;			/* instruction string */
 		int offset;			/* instruction offset */
+		int nops;			/* number of nops */
 	} insn[DISAS_ALT_INSN_MAX];		/* alternative instructions */
 	int insn_idx;				/* index of the next instruction to print */
 };
@@ -727,7 +728,7 @@ static int disas_alt_init(struct disas_alt *dalt,
 }
=20
 static int disas_alt_add_insn(struct disas_alt *dalt, int index, char *insn_=
str,
-			      int offset)
+			      int offset, int nops)
 {
 	int len;
=20
@@ -740,6 +741,7 @@ static int disas_alt_add_insn(struct disas_alt *dalt, int=
 index, char *insn_str,
 	len =3D strlen(insn_str);
 	dalt->insn[index].str =3D insn_str;
 	dalt->insn[index].offset =3D offset;
+	dalt->insn[index].nops =3D nops;
 	if (len > dalt->width)
 		dalt->width =3D len;
=20
@@ -752,6 +754,7 @@ static int disas_alt_jump(struct disas_alt *dalt)
 	struct instruction *dest_insn;
 	char suffix[2] =3D { 0 };
 	char *str;
+	int nops;
=20
 	orig_insn =3D dalt->orig_insn;
 	dest_insn =3D dalt->alt->insn;
@@ -762,14 +765,16 @@ static int disas_alt_jump(struct disas_alt *dalt)
 		str =3D strfmt("jmp%-3s %lx <%s+0x%lx>", suffix,
 			     dest_insn->offset, dest_insn->sym->name,
 			     dest_insn->offset - dest_insn->sym->offset);
+		nops =3D 0;
 	} else {
 		str =3D strfmt("nop%d", orig_insn->len);
+		nops =3D orig_insn->len;
 	}
=20
 	if (!str)
 		return -1;
=20
-	disas_alt_add_insn(dalt, 0, str, 0);
+	disas_alt_add_insn(dalt, 0, str, 0, nops);
=20
 	return 1;
 }
@@ -789,7 +794,7 @@ static int disas_alt_extable(struct disas_alt *dalt)
 	if (!str)
 		return -1;
=20
-	disas_alt_add_insn(dalt, 0, str, 0);
+	disas_alt_add_insn(dalt, 0, str, 0, 0);
=20
 	return 1;
 }
@@ -805,11 +810,13 @@ static int disas_alt_group(struct disas_context *dctx, =
struct disas_alt *dalt)
 	int offset;
 	char *str;
 	int count;
+	int nops;
 	int err;
=20
 	file =3D dctx->file;
 	count =3D 0;
 	offset =3D 0;
+	nops =3D 0;
=20
 	alt_for_each_insn(file, DALT_GROUP(dalt), insn) {
=20
@@ -818,7 +825,8 @@ static int disas_alt_group(struct disas_context *dctx, st=
ruct disas_alt *dalt)
 		if (!str)
 			return -1;
=20
-		err =3D disas_alt_add_insn(dalt, count, str, offset);
+		nops =3D insn->type =3D=3D INSN_NOP ? insn->len : 0;
+		err =3D disas_alt_add_insn(dalt, count, str, offset, nops);
 		if (err)
 			break;
 		offset +=3D insn->len;
@@ -834,6 +842,7 @@ static int disas_alt_group(struct disas_context *dctx, st=
ruct disas_alt *dalt)
 static int disas_alt_default(struct disas_context *dctx, struct disas_alt *d=
alt)
 {
 	char *str;
+	int nops;
 	int err;
=20
 	if (DALT_GROUP(dalt))
@@ -849,7 +858,8 @@ static int disas_alt_default(struct disas_context *dctx, =
struct disas_alt *dalt)
 	str =3D strdup(disas_result(dctx));
 	if (!str)
 		return -1;
-	err =3D disas_alt_add_insn(dalt, 0, str, 0);
+	nops =3D dalt->orig_insn->type =3D=3D INSN_NOP ? dalt->orig_insn->len : 0;
+	err =3D disas_alt_add_insn(dalt, 0, str, 0, nops);
 	if (err)
 		return -1;
=20
@@ -996,6 +1006,62 @@ static void disas_alt_print_compact(char *alt_name, str=
uct disas_alt *dalts,
 }
=20
 /*
+ * Trim NOPs in alternatives. This replaces trailing NOPs in alternatives
+ * with a single indication of the number of bytes covered with NOPs.
+ *
+ * Return the maximum numbers of instructions in all alternatives after
+ * trailing NOPs have been trimmed.
+ */
+static int disas_alt_trim_nops(struct disas_alt *dalts, int alt_count,
+			       int insn_count)
+{
+	struct disas_alt *dalt;
+	int nops_count;
+	const char *s;
+	int offset;
+	int count;
+	int nops;
+	int i, j;
+
+	count =3D 0;
+	for (i =3D 0; i < alt_count; i++) {
+		offset =3D 0;
+		nops =3D 0;
+		nops_count =3D 0;
+		dalt =3D &dalts[i];
+		for (j =3D insn_count - 1; j >=3D 0; j--) {
+			if (!dalt->insn[j].str || !dalt->insn[j].nops)
+				break;
+			offset =3D dalt->insn[j].offset;
+			free(dalt->insn[j].str);
+			dalt->insn[j].offset =3D 0;
+			dalt->insn[j].str =3D NULL;
+			nops +=3D dalt->insn[j].nops;
+			nops_count++;
+		}
+
+		/*
+		 * All trailing NOPs have been removed. If there was a single
+		 * NOP instruction then re-add it. If there was a block of
+		 * NOPs then indicate the number of bytes than the block
+		 * covers (nop*<number-of-bytes>).
+		 */
+		if (nops_count) {
+			s =3D nops_count =3D=3D 1 ? "" : "*";
+			dalt->insn[j + 1].str =3D strfmt("nop%s%d", s, nops);
+			dalt->insn[j + 1].offset =3D offset;
+			dalt->insn[j + 1].nops =3D nops;
+			j++;
+		}
+
+		if (j > count)
+			count =3D j;
+	}
+
+	return count + 1;
+}
+
+/*
  * Disassemble an alternative.
  *
  * Return the last instruction in the default alternative so that
@@ -1083,6 +1149,8 @@ static void *disas_alt(struct disas_context *dctx,
 	 * Print default and non-default alternatives.
 	 */
=20
+	insn_count =3D disas_alt_trim_nops(dalts, alt_count, insn_count);
+
 	if (opts.wide)
 		disas_alt_print_wide(alt_name, dalts, alt_count, insn_count);
 	else

