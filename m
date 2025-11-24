Return-Path: <linux-tip-commits+bounces-7487-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BA4C7F81B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5112F348FE7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EDF2F7AA7;
	Mon, 24 Nov 2025 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SM+LcnmU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ut7BE0ZW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7362F656A;
	Mon, 24 Nov 2025 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975507; cv=none; b=r6gNV5QqNCet6iPkv8WCuGB9nYwPf2g1R3rP6Rnea277jOCaU+OHJolm+x0qRrdOPcdhWd1kyMSO10iS3Co2HVIC22JLYkjPHc1S10fG1vAgfVmm+0KKITmkUJtBfGsrAplVKK7F7L1uUXO5akRuvPPiq9PzSiD8o5ajCMOwhZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975507; c=relaxed/simple;
	bh=gGWTDemuvm6OGLX3cJ0mzT9Cbyh6q3lbjLf/huj0HPg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d8eE4conFZiihExzckxDiH5yBVfBvSAs7Vo5GHTowy+W9yv+MRWltebdUQd1JUT6n9ksP3AhautoRkPXEPHbjN0uoXsn/GGtbI4J2qFB4bTDnOJYaQIKAZzPkSClOhRc8Y1uwiyOArx+ltoAeVwQH8M1NY+yP+Em55hAhgE+vFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SM+LcnmU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ut7BE0ZW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975504;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dadm5cGpllgpd2ZncQ4vVRukMHoNmkfllwju0SAxcvY=;
	b=SM+LcnmUCVbOVWZMy+zyF1r2ZvL+v3sznS+8/BH3qTdyxb9ft4ObnLvafFwx+m4U33ZNBx
	zCr23dVIQRYgZde6xs2VExIX8qSIr6YCy6gDqKA8UyY+VlrnVMBn0utTBNJiXt0ZQ60iIx
	ANRaDxuLCwKPI67hfmPYDustf/xlIDtouxFp9diu0PUZaKHJVrpA1XjRxeYnFdM5urzBX+
	x4albVUOmhAily5DzE1txEdEuyl5ymmm4qoGqA4wgi45FiMjU4pMCC9znkI6SHb2Rt8om/
	wbp8ysCvg7lcRylZ+46lb2GjyJIp2zJBCnau4/Afd/xojPWl76PorcIjEJdwWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975504;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dadm5cGpllgpd2ZncQ4vVRukMHoNmkfllwju0SAxcvY=;
	b=ut7BE0ZWxokAhLD4BXblKqisuiTrCMvgGgeTF7bchEQLZzUHIRDsFXajtyQ2SDi0DTBcDt
	WiqGcTRDL3HIK0Cw==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Print addresses with alternative instructions
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-22-alexandre.chartre@oracle.com>
References: <20251121095340.464045-22-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397550274.498.18033347265641476010.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     15e7ad8667b9d1fd4b6bdf06472812416453b7b2
Gitweb:        https://git.kernel.org/tip/15e7ad8667b9d1fd4b6bdf0647281241645=
3b7b2
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:31 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:13 +01:00

objtool: Print addresses with alternative instructions

All alternatives are disassemble side-by-side when using the --disas
option. However the address of each instruction is not printed because
instructions from different alternatives are not necessarily aligned.

Change this behavior to print the address of each instruction. Spaces
will appear between instructions from the same alternative when
instructions from different alternatives do not have the same alignment.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-22-alexandre.chartre@ora=
cle.com
---
 tools/objtool/disas.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index ae69bef..6083a64 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -47,7 +47,11 @@ struct disas_alt {
 	struct alternative *alt;		/* alternative or NULL if default code */
 	char *name;				/* name for this alternative */
 	int width;				/* formatting width */
-	char *insn[DISAS_ALT_INSN_MAX];		/* alternative instructions */
+	struct {
+		char *str;			/* instruction string */
+		int offset;			/* instruction offset */
+	} insn[DISAS_ALT_INSN_MAX];		/* alternative instructions */
+	int insn_idx;				/* index of the next instruction to print */
 };
=20
 #define DALT_DEFAULT(dalt)	(!(dalt)->alt)
@@ -361,10 +365,9 @@ char *disas_result(struct disas_context *dctx)
 	disas_print_insn(stdout, dctx, insn, depth, "\n")
=20
 /*
- * Print a message in the instruction flow. If insn is not NULL then
- * the instruction address is printed in addition of the message,
- * otherwise only the message is printed. In all cases, the instruction
- * itself is not printed.
+ * Print a message in the instruction flow. If sec is not NULL then the
+ * address at the section offset is printed in addition of the message,
+ * otherwise only the message is printed.
  */
 static int disas_vprint(FILE *stream, struct section *sec, unsigned long off=
set,
 			int depth, const char *format, va_list ap)
@@ -607,6 +610,7 @@ static int disas_alt_init(struct disas_alt *dalt,
 {
 	dalt->orig_insn =3D orig_insn;
 	dalt->alt =3D alt;
+	dalt->insn_idx =3D 0;
 	dalt->name =3D alt ? disas_alt_name(alt) : strdup("DEFAULT");
 	if (!dalt->name)
 		return -1;
@@ -615,7 +619,8 @@ static int disas_alt_init(struct disas_alt *dalt,
 	return 0;
 }
=20
-static int disas_alt_add_insn(struct disas_alt *dalt, int index, char *insn_=
str)
+static int disas_alt_add_insn(struct disas_alt *dalt, int index, char *insn_=
str,
+			      int offset)
 {
 	int len;
=20
@@ -626,7 +631,8 @@ static int disas_alt_add_insn(struct disas_alt *dalt, int=
 index, char *insn_str)
 	}
=20
 	len =3D strlen(insn_str);
-	dalt->insn[index] =3D insn_str;
+	dalt->insn[index].str =3D insn_str;
+	dalt->insn[index].offset =3D offset;
 	if (len > dalt->width)
 		dalt->width =3D len;
=20
@@ -641,12 +647,14 @@ static int disas_alt_group(struct disas_context *dctx, =
struct disas_alt *dalt)
 {
 	struct objtool_file *file;
 	struct instruction *insn;
+	int offset;
 	char *str;
 	int count;
 	int err;
=20
 	file =3D dctx->file;
 	count =3D 0;
+	offset =3D 0;
=20
 	alt_for_each_insn(file, DALT_GROUP(dalt), insn) {
=20
@@ -655,9 +663,10 @@ static int disas_alt_group(struct disas_context *dctx, s=
truct disas_alt *dalt)
 		if (!str)
 			return -1;
=20
-		err =3D disas_alt_add_insn(dalt, count, str);
+		err =3D disas_alt_add_insn(dalt, count, str, offset);
 		if (err)
 			break;
+		offset +=3D insn->len;
 		count++;
 	}
=20
@@ -685,7 +694,7 @@ static int disas_alt_default(struct disas_context *dctx, =
struct disas_alt *dalt)
 	str =3D strdup(disas_result(dctx));
 	if (!str)
 		return -1;
-	err =3D disas_alt_add_insn(dalt, 0, str);
+	err =3D disas_alt_add_insn(dalt, 0, str, 0);
 	if (err)
 		return -1;
=20
@@ -710,9 +719,11 @@ static void disas_alt_print_compact(char *alt_name, stru=
ct disas_alt *dalts,
 	for (i =3D 0; i < alt_count; i++) {
 		printf("%*s=3D %s\n", len, "", dalts[i].name);
 		for (j =3D 0; j < insn_count; j++) {
-			if (!dalts[i].insn[j])
+			if (!dalts[i].insn[j].str)
 				break;
-			printf("%*s| %s\n", len, "", dalts[i].insn[j]);
+			disas_print(stdout, orig_insn->sec,
+				    orig_insn->offset + dalts[i].insn[j].offset, 0,
+				    "| %s\n", dalts[i].insn[j].str);
 		}
 		printf("%*s|\n", len, "");
 	}
@@ -811,7 +822,7 @@ done:
 	for (i =3D 0; i < alt_count; i++) {
 		free(dalts[i].name);
 		for (j =3D 0; j < insn_count; j++)
-			free(dalts[i].insn[j]);
+			free(dalts[i].insn[j].str);
 	}
=20
 	free(alt_name);

