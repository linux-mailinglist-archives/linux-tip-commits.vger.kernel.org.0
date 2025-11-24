Return-Path: <linux-tip-commits+bounces-7488-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D0930C7F82B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49EC53431AE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492192F8BC3;
	Mon, 24 Nov 2025 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cGn0MbEa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LHHJjPf1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A02F7475;
	Mon, 24 Nov 2025 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975509; cv=none; b=dzMRVzVNKfKPXQdBG268M6pKLS3OWHJr6kTM398VkR/+Pa2a6+wpDZ4pn7kABDN1y7zPYXUSSXH2GBGe6LAE8NLFSYb7jWn9brjNOX5DwJdPAwFHB8SwDGHqD+B7WimR0n5cjkzW5sOQJz6sNGbxrp9EemwHXuI4COiQun1nm6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975509; c=relaxed/simple;
	bh=5G8K+IeSxLKYCBlbaNLSAf5/5z9KMCO0rH/VS5mP3t8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=myWzflIDw0AniAhgD1ezEbzp8QhfBubhzRyPqiR3AtwnLvTs2ot/EexIVWB6oKGHEfhPutZOZyYMa2Y5Wv+8E36DqkP+RQgHaDiwuO9nmsnmXHpe0kGkkphyu2HqbhXcfFjDKtLqq5tKaYazows1w2qAKZDiEMDnuTC68NPaz/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cGn0MbEa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LHHJjPf1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975505;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yvhPNXIztxPTdHyaFfje42BUZSJ1VFuhvH/Wi/GR83w=;
	b=cGn0MbEaIkEhB7U1pZaH9g6ebPgYwVp+cDdlo1akD8M5HWwp3BJsbbHVun306b9t/hoyJZ
	aoG1GePB2RDZWgJGQ9YUXXcamQnsShDIP3T9G7SdadT4ncVx80lHn6sFQYFStj9GUtQKnl
	8qxXXipp3qT8z+9OR7C/tCJqImx6CPSDFf+c+V0t7i/3zrsekodgwZKZwG/x9gBWunNtud
	XQrhgJPLtYP5VLH+Q6CHTyso1/cBOdVuFGpYPAt5Iv9WN72jIMULd+N3U4HtDXmOKk0/2d
	alvkhR/6SAtRWM2Qo1ROPfPjWgMXod10Idn4ueOSLJlNyUmHAso7lvRg469wpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975505;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yvhPNXIztxPTdHyaFfje42BUZSJ1VFuhvH/Wi/GR83w=;
	b=LHHJjPf1bJ5NeuMY3gw1NdMaXJCqHnr/Ot4FIi+MreDXwi/WoCKWOqcqfUzl9iFeqstznf
	P2ghQwmMu/uCR5Bw==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Disassemble group alternatives
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-21-alexandre.chartre@oracle.com>
References: <20251121095340.464045-21-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397550385.498.3455436802889028468.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     a4f1599672e7bf494d79928a38fd6aa873e2e50c
Gitweb:        https://git.kernel.org/tip/a4f1599672e7bf494d79928a38fd6aa873e=
2e50c
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:30 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:13 +01:00

objtool: Disassemble group alternatives

When using the --disas option, disassemble all group alternatives.
Jump tables and exception tables (which are handled as alternatives)
are not disassembled at the moment.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-21-alexandre.chartre@ora=
cle.com
---
 tools/objtool/disas.c | 166 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 149 insertions(+), 17 deletions(-)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index f9b13d5..ae69bef 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -47,8 +47,14 @@ struct disas_alt {
 	struct alternative *alt;		/* alternative or NULL if default code */
 	char *name;				/* name for this alternative */
 	int width;				/* formatting width */
+	char *insn[DISAS_ALT_INSN_MAX];		/* alternative instructions */
 };
=20
+#define DALT_DEFAULT(dalt)	(!(dalt)->alt)
+#define DALT_INSN(dalt)		(DALT_DEFAULT(dalt) ? (dalt)->orig_insn : (dalt)->a=
lt->insn)
+#define DALT_GROUP(dalt)	(DALT_INSN(dalt)->alt_group)
+#define DALT_ALTID(dalt)	((dalt)->orig_insn->offset)
+
 /*
  * Wrapper around asprintf() to allocate and format a string.
  * Return the allocated string or NULL on error.
@@ -506,6 +512,21 @@ size_t disas_insn(struct disas_context *dctx, struct ins=
truction *insn)
 	return disasm(insn->offset, &dctx->info);
 }
=20
+static struct instruction *next_insn_same_alt(struct objtool_file *file,
+					      struct alt_group *alt_grp,
+					      struct instruction *insn)
+{
+	if (alt_grp->last_insn =3D=3D insn || alt_grp->nop =3D=3D insn)
+		return NULL;
+
+	return next_insn_same_sec(file, insn);
+}
+
+#define alt_for_each_insn(file, alt_grp, insn)			\
+	for (insn =3D alt_grp->first_insn; 			\
+	     insn;						\
+	     insn =3D next_insn_same_alt(file, alt_grp, insn))
+
 /*
  * Provide a name for the type of alternatives present at the
  * specified instruction.
@@ -594,23 +615,107 @@ static int disas_alt_init(struct disas_alt *dalt,
 	return 0;
 }
=20
+static int disas_alt_add_insn(struct disas_alt *dalt, int index, char *insn_=
str)
+{
+	int len;
+
+	if (index >=3D DISAS_ALT_INSN_MAX) {
+		WARN("Alternative %lx.%s has more instructions than supported",
+		     DALT_ALTID(dalt), dalt->name);
+		return -1;
+	}
+
+	len =3D strlen(insn_str);
+	dalt->insn[index] =3D insn_str;
+	if (len > dalt->width)
+		dalt->width =3D len;
+
+	return 0;
+}
+
+/*
+ * Disassemble an alternative and store instructions in the disas_alt
+ * structure. Return the number of instructions in the alternative.
+ */
+static int disas_alt_group(struct disas_context *dctx, struct disas_alt *dal=
t)
+{
+	struct objtool_file *file;
+	struct instruction *insn;
+	char *str;
+	int count;
+	int err;
+
+	file =3D dctx->file;
+	count =3D 0;
+
+	alt_for_each_insn(file, DALT_GROUP(dalt), insn) {
+
+		disas_insn(dctx, insn);
+		str =3D strdup(disas_result(dctx));
+		if (!str)
+			return -1;
+
+		err =3D disas_alt_add_insn(dalt, count, str);
+		if (err)
+			break;
+		count++;
+	}
+
+	return count;
+}
+
+/*
+ * Disassemble the default alternative.
+ */
+static int disas_alt_default(struct disas_context *dctx, struct disas_alt *d=
alt)
+{
+	char *str;
+	int err;
+
+	if (DALT_GROUP(dalt))
+		return disas_alt_group(dctx, dalt);
+
+	/*
+	 * Default alternative with no alt_group: this is the default
+	 * code associated with either a jump table or an exception
+	 * table and no other instruction alternatives. In that case
+	 * the default alternative is made of a single instruction.
+	 */
+	disas_insn(dctx, dalt->orig_insn);
+	str =3D strdup(disas_result(dctx));
+	if (!str)
+		return -1;
+	err =3D disas_alt_add_insn(dalt, 0, str);
+	if (err)
+		return -1;
+
+	return 1;
+}
+
 /*
  * Print all alternatives one above the other.
  */
 static void disas_alt_print_compact(char *alt_name, struct disas_alt *dalts,
-				    int alt_count)
+				    int alt_count, int insn_count)
 {
 	struct instruction *orig_insn;
+	int i, j;
 	int len;
-	int i;
=20
 	orig_insn =3D dalts[0].orig_insn;
=20
 	len =3D disas_print(stdout, orig_insn->sec, orig_insn->offset, 0, NULL);
 	printf("%s\n", alt_name);
=20
-	for (i =3D 0; i < alt_count; i++)
+	for (i =3D 0; i < alt_count; i++) {
 		printf("%*s=3D %s\n", len, "", dalts[i].name);
+		for (j =3D 0; j < insn_count; j++) {
+			if (!dalts[i].insn[j])
+				break;
+			printf("%*s| %s\n", len, "", dalts[i].insn[j]);
+		}
+		printf("%*s|\n", len, "");
+	}
 }
=20
 /*
@@ -624,11 +729,15 @@ static void *disas_alt(struct disas_context *dctx,
 		       struct instruction *orig_insn)
 {
 	struct disas_alt dalts[DISAS_ALT_MAX] =3D { 0 };
+	struct instruction *last_insn =3D NULL;
 	struct alternative *alt;
+	struct disas_alt *dalt;
+	int insn_count =3D 0;
 	int alt_count =3D 0;
 	char *alt_name;
+	int count;
+	int i, j;
 	int err;
-	int i;
=20
 	alt_name =3D strfmt("<%s.%lx>", disas_alt_type_name(orig_insn),
 			  orig_insn->offset);
@@ -639,7 +748,7 @@ static void *disas_alt(struct disas_context *dctx,
 	}
=20
 	/*
-	 * Initialize the default alternative.
+	 * Initialize and disassemble the default alternative.
 	 */
 	err =3D disas_alt_init(&dalts[0], orig_insn, NULL);
 	if (err) {
@@ -647,8 +756,14 @@ static void *disas_alt(struct disas_context *dctx,
 		goto done;
 	}
=20
+	insn_count =3D disas_alt_default(dctx, &dalts[0]);
+	if (insn_count < 0) {
+		WARN("%s: failed to disassemble default alternative", alt_name);
+		goto done;
+	}
+
 	/*
-	 * Initialize all other alternatives.
+	 * Initialize and disassemble all other alternatives.
 	 */
 	i =3D 1;
 	for (alt =3D orig_insn->alts; alt; alt =3D alt->next) {
@@ -656,35 +771,52 @@ static void *disas_alt(struct disas_context *dctx,
 			WARN("%s has more alternatives than supported", alt_name);
 			break;
 		}
-		err =3D disas_alt_init(&dalts[i], orig_insn, alt);
+		dalt =3D &dalts[i];
+		err =3D disas_alt_init(dalt, orig_insn, alt);
 		if (err) {
 			WARN("%s: failed to disassemble alternative", alt_name);
 			goto done;
 		}
=20
+		/*
+		 * Only group alternatives are supported at the moment.
+		 */
+		switch (dalt->alt->type) {
+		case ALT_TYPE_INSTRUCTIONS:
+			count =3D disas_alt_group(dctx, dalt);
+			break;
+		default:
+			count =3D 0;
+		}
+		if (count < 0) {
+			WARN("%s: failed to disassemble alternative %s",
+			     alt_name, dalt->name);
+			goto done;
+		}
+
+		insn_count =3D count > insn_count ? count : insn_count;
 		i++;
 	}
 	alt_count =3D i;
=20
 	/*
 	 * Print default and non-default alternatives.
-	 *
-	 * At the moment, this just prints an header for each alternative.
 	 */
-	disas_alt_print_compact(alt_name, dalts, alt_count);
+	disas_alt_print_compact(alt_name, dalts, alt_count, insn_count);
+
+	last_insn =3D orig_insn->alt_group ? orig_insn->alt_group->last_insn :
+		orig_insn;
=20
 done:
-	for (i =3D 0; i < alt_count; i++)
+	for (i =3D 0; i < alt_count; i++) {
 		free(dalts[i].name);
+		for (j =3D 0; j < insn_count; j++)
+			free(dalts[i].insn[j]);
+	}
=20
 	free(alt_name);
=20
-	/*
-	 * Currently we are not disassembling any alternative but just
-	 * printing alternative names. Return NULL to have disas_func()
-	 * resume the disassembly with the default alternative.
-	 */
-	return NULL;
+	return last_insn;
 }
=20
 /*

