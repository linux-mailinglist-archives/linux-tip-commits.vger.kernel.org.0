Return-Path: <linux-tip-commits+bounces-7484-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13029C7F7F1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4855D3A262A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1A02F616A;
	Mon, 24 Nov 2025 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YPpSstD2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QV8crf0J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BBB2F5A1D;
	Mon, 24 Nov 2025 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975504; cv=none; b=IFFYgwQGFtz0SWYB5q+6eHc9oKu3X9RYK+ThsTSe59zQ1H1yEFsoV1UbK2HBy2UJo+AWyTDUq/t3cYRVKNxbaat6f1cZn6nXCWXTPrRYGvP/PFqrZoQzxfGbpsxdPm2AH8BtZ5lHBCio0ZF8JIPEulpKK62zrnJ3/Vhyak4DB+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975504; c=relaxed/simple;
	bh=Vg3uoPPWk9NtCudmpGtlGNHWIhsgRKCPbRBL9iIiVpA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hqiQJtxD7OJoYFN9szDVkVgz6DF3hHf6NcVXS22L+JXsmytYVU5UbmNs8/FF1DR3BDpLyPXsi8rcku1Ljm5ru4ujMnOlC2DOMb/W72Xqyfcbxx1iUUKX4CGZT3OBYCuq73LJfuFmp0ry3V6+bBeSnSGQ5u5eVstPSXy4n9xQH1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YPpSstD2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QV8crf0J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975500;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LUb9N3sXnYXx2EUeUWfg9U1f2dqbj7hnH8TdQwLkh0Y=;
	b=YPpSstD2c9sQedOXQtfS74lwGFMi789u0RH+yLc34K0ZRroHgF1arcbxOsK8tHq1FmvjoF
	/AN+LxeV0KWqMXEckba8v37OsZLksTy+qVpqLL8klqv6SGPtGOHe2uQJ+A58fq3pmQQ8KQ
	T8c3Mrvh8sYLp+TFi99eZ9RQNJbkpIwZ8FmGlK7ViL7oflChXVt2Jd7mPUHZlFfRqGC8f3
	PSmZFNc8zpP2NIGhqNmuuQoJigBxQOw0svLm2zUECahISYYMmV1V88kNfJrgVD7jIoYZAV
	lh63S5I3Ih9BB+PGXnSW5hz+eDMOuEou9fifPIB4KljEwQXyt678HvqMoeH/0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975500;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LUb9N3sXnYXx2EUeUWfg9U1f2dqbj7hnH8TdQwLkh0Y=;
	b=QV8crf0JDewP85MmvGrMR3Rz1edX2+8LR6Yk/vZ33sKTOdMWQ0CWkndIzPz/S8xjxghThV
	ybA/+5VQwM4UZBAg==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix address references in alternatives
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-25-alexandre.chartre@oracle.com>
References: <20251121095340.464045-25-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397549963.498.9122903777502961500.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     4aae0d3f77b1104e55847870d15c3749ca575fcf
Gitweb:        https://git.kernel.org/tip/4aae0d3f77b1104e55847870d15c3749ca5=
75fcf
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:34 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:14 +01:00

objtool: Fix address references in alternatives

When using the --disas option, alternatives are disassembled but
address references in non-default alternatives can be incorrect.

The problem is that alternatives are shown as if they were replacing the
original code of the alternative. So if an alternative is referencing
an address inside the alternative then the reference has to be
adjusted to the location of the original code.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-25-alexandre.chartre@ora=
cle.com
---
 tools/objtool/disas.c | 70 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 326e16c..f8917c8 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -24,6 +24,7 @@
 struct disas_context {
 	struct objtool_file *file;
 	struct instruction *insn;
+	bool alt_applied;
 	char result[DISAS_RESULT_SIZE];
 	disassembler_ftype disassembler;
 	struct disassemble_info info;
@@ -160,6 +161,43 @@ static void disas_print_addr_sym(struct section *sec, st=
ruct symbol *sym,
 	}
 }
=20
+static bool disas_print_addr_alt(bfd_vma addr, struct disassemble_info *dinf=
o)
+{
+	struct disas_context *dctx =3D dinfo->application_data;
+	struct instruction *orig_first_insn;
+	struct alt_group *alt_group;
+	unsigned long offset;
+	struct symbol *sym;
+
+	/*
+	 * Check if we are processing an alternative at the original
+	 * instruction address (i.e. if alt_applied is true) and if
+	 * we are referencing an address inside the alternative.
+	 *
+	 * For example, this happens if there is a branch inside an
+	 * alternative. In that case, the address should be updated
+	 * to a reference inside the original instruction flow.
+	 */
+	if (!dctx->alt_applied)
+		return false;
+
+	alt_group =3D dctx->insn->alt_group;
+	if (!alt_group || !alt_group->orig_group ||
+	    addr < alt_group->first_insn->offset ||
+	    addr > alt_group->last_insn->offset)
+		return false;
+
+	orig_first_insn =3D alt_group->orig_group->first_insn;
+	offset =3D addr - alt_group->first_insn->offset;
+
+	addr =3D orig_first_insn->offset + offset;
+	sym =3D orig_first_insn->sym;
+
+	disas_print_addr_sym(orig_first_insn->sec, sym, addr, dinfo);
+
+	return true;
+}
+
 static void disas_print_addr_noreloc(bfd_vma addr,
 				     struct disassemble_info *dinfo)
 {
@@ -167,6 +205,9 @@ static void disas_print_addr_noreloc(bfd_vma addr,
 	struct instruction *insn =3D dctx->insn;
 	struct symbol *sym =3D NULL;
=20
+	if (disas_print_addr_alt(addr, dinfo))
+		return;
+
 	if (insn->sym && addr >=3D insn->sym->offset &&
 	    addr < insn->sym->offset + insn->sym->len) {
 		sym =3D insn->sym;
@@ -232,8 +273,9 @@ static void disas_print_address(bfd_vma addr, struct disa=
ssemble_info *dinfo)
 	 */
 	jump_dest =3D insn->jump_dest;
 	if (jump_dest && jump_dest->sym && jump_dest->offset =3D=3D addr) {
-		disas_print_addr_sym(jump_dest->sec, jump_dest->sym,
-				     addr, dinfo);
+		if (!disas_print_addr_alt(addr, dinfo))
+			disas_print_addr_sym(jump_dest->sec, jump_dest->sym,
+					     addr, dinfo);
 		return;
 	}
=20
@@ -490,13 +532,22 @@ void disas_print_insn(FILE *stream, struct disas_contex=
t *dctx,
=20
 /*
  * Disassemble a single instruction. Return the size of the instruction.
+ *
+ * If alt_applied is true then insn should be an instruction from of an
+ * alternative (i.e. insn->alt_group !=3D NULL), and it is disassembled
+ * at the location of the original code it is replacing. When the
+ * instruction references any address inside the alternative then
+ * these references will be re-adjusted to replace the original code.
  */
-size_t disas_insn(struct disas_context *dctx, struct instruction *insn)
+static size_t disas_insn_common(struct disas_context *dctx,
+				struct instruction *insn,
+				bool alt_applied)
 {
 	disassembler_ftype disasm =3D dctx->disassembler;
 	struct disassemble_info *dinfo =3D &dctx->info;
=20
 	dctx->insn =3D insn;
+	dctx->alt_applied =3D alt_applied;
 	dctx->result[0] =3D '\0';
=20
 	if (insn->type =3D=3D INSN_NOP) {
@@ -515,6 +566,17 @@ size_t disas_insn(struct disas_context *dctx, struct ins=
truction *insn)
 	return disasm(insn->offset, &dctx->info);
 }
=20
+size_t disas_insn(struct disas_context *dctx, struct instruction *insn)
+{
+	return disas_insn_common(dctx, insn, false);
+}
+
+static size_t disas_insn_alt(struct disas_context *dctx,
+			     struct instruction *insn)
+{
+	return disas_insn_common(dctx, insn, true);
+}
+
 static struct instruction *next_insn_same_alt(struct objtool_file *file,
 					      struct alt_group *alt_grp,
 					      struct instruction *insn)
@@ -706,7 +768,7 @@ static int disas_alt_group(struct disas_context *dctx, st=
ruct disas_alt *dalt)
=20
 	alt_for_each_insn(file, DALT_GROUP(dalt), insn) {
=20
-		disas_insn(dctx, insn);
+		disas_insn_alt(dctx, insn);
 		str =3D strdup(disas_result(dctx));
 		if (!str)
 			return -1;

