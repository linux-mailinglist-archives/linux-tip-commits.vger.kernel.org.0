Return-Path: <linux-tip-commits+bounces-7479-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5298DC7F7D3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C939E3A6798
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5282F49EC;
	Mon, 24 Nov 2025 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="loJWjPEG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tl5ZJA0p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C2F2F5468;
	Mon, 24 Nov 2025 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975499; cv=none; b=UMXcpF1do6VqN3E2L5kiMFhww9aZU7WODfZYmY6ww0wROJqv0kedqFKtJamjcD6LR20hwdtVgrbz1oJfi0qhnriGzeqpzogah55h0qhZ81of5L5PKipf5UKTVGYSuVENPtWzbaqm/ocwjQPGD7ZMgVHzq9+/P2UvLXzQ0xeqMcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975499; c=relaxed/simple;
	bh=ox2ozl2mtwjiBWRMOpz4xyaBrfW0aAQfydL8x4r4ee0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OHAPkhLoQfzCXln/N6EQeA13R17AwFSKSplgvsYblqkJTmhYxhfWWU14YKMjf4NaCPGKpyOZ6P5t1/tCHmUolWA84Wxwc88YQYm+Tf3OPc6RYkJq+337hUgQv6atpDSqr3Ia8/1L14zFZpznU8rpuadbmTCkffugrSyr9SsPagY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=loJWjPEG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tl5ZJA0p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975495;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh4HT9RceQq/GJqaLknCBqXf6ZH8fFXrv5uKDLEtyh8=;
	b=loJWjPEGZ7s565ZZGTmOb6GNPa6GIxTLjzQor2UkVLrxcei9M9wtwca7Oua76YyUJDzvVj
	F58tTZ6AxIXQnZ0B2fiu2FDloVIb2CyRO/C+JaJbL8unMEuGRGC+qy9PPj0PlZnYIQwrdT
	dpi5l/4GbFMfLgjXFtyaGdgtM93stoOHCrLfMdjflJBTVkwRiDOrg1et/pBqiwtu9WQ+dz
	6K3QMdwgDPg0zFvhDMgMtxXrydPLTRiNnU11q1q1a6t4D4wCa9bV2WbUOx+6sQXwNNLLKx
	VYRGLipVK8SsbaAPuUDuZaTZCJ4v/+EMqt2dPklI3lE2BZQXIGoM71cgLANJLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975495;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh4HT9RceQq/GJqaLknCBqXf6ZH8fFXrv5uKDLEtyh8=;
	b=Tl5ZJA0pUZRffF3jgGeOO4gAWCo9IEzM0nfNQ6Ki00b4icBn9G0lGkwelqAQiPfWO/EyW8
	Q+IdoKk2mirV0ZDw==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add wide output for disassembly
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-30-alexandre.chartre@oracle.com>
References: <20251121095340.464045-30-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397546313.498.10121207509346681972.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     9979be81c0c2d4f71f6dc9793fa08db0261beac7
Gitweb:        https://git.kernel.org/tip/9979be81c0c2d4f71f6dc9793fa08db0261=
beac7
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:39 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:15 +01:00

objtool: Add wide output for disassembly

Add the --wide option to provide a wide output when disassembling.
With this option, the disassembly of alternatives is displayed
side-by-side instead of one above the other.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-30-alexandre.chartre@ora=
cle.com
---
 tools/objtool/builtin-check.c           |  1 +-
 tools/objtool/disas.c                   | 95 +++++++++++++++++++++++-
 tools/objtool/include/objtool/builtin.h |  1 +-
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index a037131..b780df5 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -107,6 +107,7 @@ static const struct option check_options[] =3D {
 	OPT_STRING(0,		 "trace", &opts.trace, "func", "trace function validation"),
 	OPT_BOOLEAN('v',	 "verbose", &opts.verbose, "verbose warnings"),
 	OPT_BOOLEAN(0,		 "werror", &opts.werror, "return error on warnings"),
+	OPT_BOOLEAN(0,		 "wide", &opts.wide, "wide output"),
=20
 	OPT_END(),
 };
diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index a4f905e..f04bc14 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -857,6 +857,95 @@ static int disas_alt_default(struct disas_context *dctx,=
 struct disas_alt *dalt)
 }
=20
 /*
+ * For each alternative, if there is an instruction at the specified
+ * offset then print this instruction, otherwise print a blank entry.
+ * The offset is an offset from the start of the alternative.
+ *
+ * Return the offset for the next instructions to print, or -1 if all
+ * instructions have been printed.
+ */
+static int disas_alt_print_insn(struct disas_alt *dalts, int alt_count,
+				int insn_count, int offset)
+{
+	struct disas_alt *dalt;
+	int offset_next;
+	char *str;
+	int i, j;
+
+	offset_next =3D -1;
+
+	for (i =3D 0; i < alt_count; i++) {
+		dalt =3D &dalts[i];
+		j =3D dalt->insn_idx;
+		if (j =3D=3D -1) {
+			printf("| %-*s ", dalt->width, "");
+			continue;
+		}
+
+		if (dalt->insn[j].offset =3D=3D offset) {
+			str =3D dalt->insn[j].str;
+			printf("| %-*s ", dalt->width, str ?: "");
+			if (++j < insn_count) {
+				dalt->insn_idx =3D j;
+			} else {
+				dalt->insn_idx =3D -1;
+				continue;
+			}
+		} else {
+			printf("| %-*s ", dalt->width, "");
+		}
+
+		if (dalt->insn[j].offset > 0 &&
+		    (offset_next =3D=3D -1 ||
+		     (dalt->insn[j].offset < offset_next)))
+			offset_next =3D dalt->insn[j].offset;
+	}
+	printf("\n");
+
+	return offset_next;
+}
+
+/*
+ * Print all alternatives side-by-side.
+ */
+static void disas_alt_print_wide(char *alt_name, struct disas_alt *dalts, in=
t alt_count,
+				 int insn_count)
+{
+	struct instruction *orig_insn;
+	int offset_next;
+	int offset;
+	int i;
+
+	orig_insn =3D dalts[0].orig_insn;
+
+	/*
+	 * Print an header with the name of each alternative.
+	 */
+	disas_print_info(stdout, orig_insn, -2, NULL);
+
+	if (strlen(alt_name) > dalts[0].width)
+		dalts[0].width =3D strlen(alt_name);
+	printf("| %-*s ", dalts[0].width, alt_name);
+
+	for (i =3D 1; i < alt_count; i++)
+		printf("| %-*s ", dalts[i].width, dalts[i].name);
+
+	printf("\n");
+
+	/*
+	 * Print instructions for each alternative.
+	 */
+	offset_next =3D 0;
+	do {
+		offset =3D offset_next;
+		disas_print(stdout, orig_insn->sec, orig_insn->offset + offset,
+			    -2, NULL);
+		offset_next =3D disas_alt_print_insn(dalts, alt_count, insn_count,
+						   offset);
+	} while (offset_next > offset);
+}
+
+/*
  * Print all alternatives one above the other.
  */
 static void disas_alt_print_compact(char *alt_name, struct disas_alt *dalts,
@@ -993,7 +1082,11 @@ static void *disas_alt(struct disas_context *dctx,
 	/*
 	 * Print default and non-default alternatives.
 	 */
-	disas_alt_print_compact(alt_name, dalts, alt_count, insn_count);
+
+	if (opts.wide)
+		disas_alt_print_wide(alt_name, dalts, alt_count, insn_count);
+	else
+		disas_alt_print_compact(alt_name, dalts, alt_count, insn_count);
=20
 	last_insn =3D orig_insn->alt_group ? orig_insn->alt_group->last_insn :
 		orig_insn;
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/=
objtool/builtin.h
index e3af664..b9e229e 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -45,6 +45,7 @@ struct opts {
 	const char *trace;
 	bool verbose;
 	bool werror;
+	bool wide;
 };
=20
 extern struct opts opts;

