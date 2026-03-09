Return-Path: <linux-tip-commits+bounces-8411-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJXJKs4mr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8411-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 21:00:14 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 588AC240836
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 21:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06532302924B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717BD41C0BC;
	Mon,  9 Mar 2026 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dJ3Cvl6W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eRAIicTo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5063ECBDB;
	Mon,  9 Mar 2026 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086390; cv=none; b=u1g6YIlcwyHzaLJe7xjCMJXRKAHhcFZOQC3KksJd0aP1onsh7cpwwYiWNN33+UVRTTy/IGPqn/d0zJ8Xi98MFlfTJm79MxzByPnssnavsG6M18oQf8HZC3MH5ZoBMur6YN1g2eMp7guL2Xngh3//l6kC5/HDl83PbhwVJ/4rnjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086390; c=relaxed/simple;
	bh=Nq7ydHrFgIYzLhrfDaeQOJqm1AHB/gB1k/1ox1hT0SY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qtAE5x9r00OglP5frTuj2eIc3P34WjsLfdchXBcK2VgHJ8l1y70BWAH99mAGeE1QtFKUPNOaSOoVSfXxuRN3SwfYfIdjLR5UEMnO3fVDY2/wepsHF7y5L4MdhUIJzYsaxYVBbuMBZUZJfJ5g0qc2QthatIfT2MKWXF9XP1tXwlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dJ3Cvl6W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eRAIicTo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:59:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773086387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dr9F3/p0v9uKLOpmodD6RPT6O/D6lqN9R4CffHM3an8=;
	b=dJ3Cvl6WMUEkehoyZTiFb2BgLzhlD4IM/XvQO9TD8zA3l4vW3Adu/HJfAhJ66zQXq/8FqJ
	JBdT3GOE1GXaLqPSgyxDjbqj2K1+jU6f0LzpSlRfW/tUrW/suqO++pOJQ3H3D/VXlZePUs
	rcSDYhxoN3xBQD10g7x8/cKPP2qskzlkhufe9w/f6rWgERC5mPIfO2P38277hVZPITzPq/
	EKHGPtM4sGP6DD9/1dch34x4YUzYToJA1/rHmb/gE3ACGPRegESiOXKKQB/UEnNjboK4hd
	GILIwUt80CVkIuGJZD/rQvN4HTzJrTKvP2fgL65dPHFUIcamc1m29+BIKf3LWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773086387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dr9F3/p0v9uKLOpmodD6RPT6O/D6lqN9R4CffHM3an8=;
	b=eRAIicToQlLBcFufc6tsmbpz2PxqPzaL+SNsUmSiUlPY6QIgAImN/3tHe7LVnnF//olkoC
	FvfazvYYiyfQpzBQ==
From: "tip-bot2 for Song Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool/klp: Match symbols based on
 demangled_name for global variables
Cc: Song Liu <song@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260305231531.3847295-7-song@kernel.org>
References: <20260305231531.3847295-7-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308638614.1647592.8771797324355816035.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 588AC240836
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8411-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,vger.kernel.org:replyto,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     cdea5cadb0ca403b1929f8d29929c0eda0f715d6
Gitweb:        https://git.kernel.org/tip/cdea5cadb0ca403b1929f8d29929c0eda0f=
715d6
Author:        Song Liu <song@kernel.org>
AuthorDate:    Thu, 05 Mar 2026 15:15:30 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Fri, 06 Mar 2026 08:08:33 -08:00

objtool/klp: Match symbols based on demangled_name for global variables

correlate_symbols() will always try to match full name first. If there is
no match, try match only demangled_name.

In very rare cases, it is possible to have multiple foo.llvm.<hash> in
the same kernel. Whenever there is ambiguity like this, fail the klp diff.

Signed-off-by: Song Liu <song@kernel.org>
Link: https://patch.msgid.link/20260305231531.3847295-7-song@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 | 13 ++++++-
 tools/objtool/include/objtool/elf.h |  3 +-
 tools/objtool/klp-diff.c            | 57 ++++++++++++++++++++++++++++-
 3 files changed, 73 insertions(+)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index feaec45..8122c5f 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -323,6 +323,19 @@ struct symbol *find_global_symbol_by_name(const struct e=
lf *elf, const char *nam
 	return NULL;
 }
=20
+void iterate_global_symbol_by_demangled_name(const struct elf *elf,
+					     const char *demangled_name,
+					     void (*process)(struct symbol *sym, void *data),
+					     void *data)
+{
+	struct symbol *sym;
+
+	elf_hash_for_each_possible(symbol_name, sym, name_hash, str_hash(demangled_=
name)) {
+		if (!strcmp(sym->demangled_name, demangled_name) && !is_local_sym(sym))
+			process(sym, data);
+	}
+}
+
 struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section=
 *sec,
 				     unsigned long offset, unsigned int len)
 {
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objt=
ool/elf.h
index e12c516..25573e5 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -186,6 +186,9 @@ struct symbol *find_func_by_offset(struct section *sec, u=
nsigned long offset);
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offs=
et);
 struct symbol *find_symbol_by_name(const struct elf *elf, const char *name);
 struct symbol *find_global_symbol_by_name(const struct elf *elf, const char =
*name);
+void iterate_global_symbol_by_demangled_name(const struct elf *elf, const ch=
ar *demangled_name,
+					     void (*process)(struct symbol *sym, void *data),
+					     void *data);
 struct symbol *find_symbol_containing(const struct section *sec, unsigned lo=
ng offset);
 int find_symbol_hole_containing(const struct section *sec, unsigned long off=
set);
 struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec,=
 unsigned long offset);
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 639bdd3..46afbf4 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -355,6 +355,46 @@ static bool dont_correlate(struct symbol *sym)
 	       strstarts(sym->name, "__initcall__");
 }
=20
+struct process_demangled_name_data {
+	struct symbol *ret;
+	int count;
+};
+
+static void process_demangled_name(struct symbol *sym, void *d)
+{
+	struct process_demangled_name_data *data =3D d;
+
+	if (sym->twin)
+		return;
+
+	data->count++;
+	data->ret =3D sym;
+}
+
+/*
+ * When there is no full name match, try match demangled_name. This would
+ * match original foo.llvm.123 to patched foo.llvm.456.
+ *
+ * Note that, in very rare cases, it is possible to have multiple
+ * foo.llvm.<hash> in the same kernel. When this happens, report error and
+ * fail the diff.
+ */
+static int find_global_symbol_by_demangled_name(struct elf *elf, struct symb=
ol *sym,
+						struct symbol **out_sym)
+{
+	struct process_demangled_name_data data =3D {};
+
+	iterate_global_symbol_by_demangled_name(elf, sym->demangled_name,
+						process_demangled_name,
+						&data);
+	if (data.count > 1) {
+		ERROR("Multiple (%d) correlation candidates for %s", data.count, sym->name=
);
+		return -1;
+	}
+	*out_sym =3D data.ret;
+	return 0;
+}
+
 /*
  * For each symbol in the original kernel, find its corresponding "twin" in =
the
  * patched kernel.
@@ -453,6 +493,23 @@ static int correlate_symbols(struct elfs *e)
 			continue;
=20
 		sym2 =3D find_global_symbol_by_name(e->patched, sym1->name);
+		if (sym2 && !sym2->twin) {
+			sym1->twin =3D sym2;
+			sym2->twin =3D sym1;
+		}
+	}
+
+	/*
+	 * Correlate globals with demangled_name.
+	 * A separate loop is needed because we want to finish all the
+	 * full name correlations first.
+	 */
+	for_each_sym(e->orig, sym1) {
+		if (sym1->bind =3D=3D STB_LOCAL || sym1->twin)
+			continue;
+
+		if (find_global_symbol_by_demangled_name(e->patched, sym1, &sym2))
+			return -1;
=20
 		if (sym2 && !sym2->twin) {
 			sym1->twin =3D sym2;

