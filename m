Return-Path: <linux-tip-commits+bounces-8410-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPfPKOQnr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8410-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 21:04:52 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA302409A5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 21:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2129630996BC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD3441B371;
	Mon,  9 Mar 2026 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J9Ahi9Bk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aXzQFpM0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97A441322E;
	Mon,  9 Mar 2026 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086389; cv=none; b=iMBtJTmN/YJwrbL2GmF7WzkwJ6uHxAkxqpnLrL3YtOKf+R4FhMn7w47DmuDft+3G4ULPze0bVo4drZY49AIcNoQZVlE/mPxWDu6cSx7e72yaxOlFtSW/WUhPFdbKKXtNvuKyQXF/iklDrpSc3B5LlwdNAQbl0Bjujvo/aoZ7J6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086389; c=relaxed/simple;
	bh=if196jVDtF3Ud34IOMV4PVJRxdbNjDv7klvcWCbTZW4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OEHyMX6/Cqg/xjWZawXvwtr567jypobC54eQ96TLP7rKXirgDe/tr2SZXb5l+oMivcGjnq4sekSmWfMPQdwT2VF2kpgCS6P4zP3eYqOkkNHRdcv74sQsw1qyDIeyvT3Qk7sH8rXlkVPC4pLOX26RfRZ97GtgVvsXLqox0ZP5nnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J9Ahi9Bk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aXzQFpM0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:59:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773086386;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghgSaHzfknk5ugPVw6eWFLdVYGP7DEJPdiKWZPdxQv8=;
	b=J9Ahi9BkG+7jga3smxxbvdgOl2oDGTmJDukIHgXTu4C3feTU9rXalqsEHDQx70JdtGbVNG
	WutXn5oFu1aRx/JnfMszIOp11OV0uEQNdsOypfpGdxxV9xdizHbs+ybAO5s4NfuA3mdOIB
	aoYYxItoRBM/s+2g0xE6QOO00hJUy6HoECaY8odQ2mQ2MxJEjI7vs5O4VAs+MdqN8N1xVe
	eXkJVNyuT4SRKRdrW6zS0SAtNVzMSRFcnzuW7OOyTy5k/+zCfG1KkWSF3dDNDcusrw2kKV
	deWP3Pl+FM10ntA4sHLxQf6SqCj1PvnDhRj8w+5sbETBJl2IW2mNlrFCGJFrdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773086386;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghgSaHzfknk5ugPVw6eWFLdVYGP7DEJPdiKWZPdxQv8=;
	b=aXzQFpM05df6UnOET/pmzZeKHEhNbRxax50T5kjyF3AaweXoeEBIGuJFmJMUAnYvvYsRlc
	pZiSC39gbLb8y8BA==
From: "tip-bot2 for Song Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool/klp: Correlate locals to globals
Cc: Song Liu <song@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260305231531.3847295-8-song@kernel.org>
References: <20260305231531.3847295-8-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308638486.1647592.18004243516768157258.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1DA302409A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8410-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,linutronix.de:dkim,vger.kernel.org:replyto];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     4b57e97be22fb8332d05ee1d0fe3c0dd43c828bf
Gitweb:        https://git.kernel.org/tip/4b57e97be22fb8332d05ee1d0fe3c0dd43c=
828bf
Author:        Song Liu <song@kernel.org>
AuthorDate:    Thu, 05 Mar 2026 15:15:31 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Fri, 06 Mar 2026 08:08:34 -08:00

objtool/klp: Correlate locals to globals

Allow correlating original locals to patched globals, and vice versa.
This is needed when:

1. User adds/removes "static" for a function.
2. CONFIG_LTO_CLANG_THIN promotes local functions and objects to global
   and add .llvm.<hash> suffix.

Signed-off-by: Song Liu <song@kernel.org>
Link: https://patch.msgid.link/20260305231531.3847295-8-song@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 46afbf4..85281b3 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -517,6 +517,36 @@ static int correlate_symbols(struct elfs *e)
 		}
 	}
=20
+	/* Correlate original locals with patched globals */
+	for_each_sym(e->orig, sym1) {
+		if (sym1->twin || dont_correlate(sym1) || !is_local_sym(sym1))
+			continue;
+
+		sym2 =3D find_global_symbol_by_name(e->patched, sym1->name);
+		if (!sym2 && find_global_symbol_by_demangled_name(e->patched, sym1, &sym2))
+			return -1;
+
+		if (sym2 && !sym2->twin) {
+			sym1->twin =3D sym2;
+			sym2->twin =3D sym1;
+		}
+	}
+
+	/* Correlate original globals with patched locals */
+	for_each_sym(e->patched, sym2) {
+		if (sym2->twin || dont_correlate(sym2) || !is_local_sym(sym2))
+			continue;
+
+		sym1 =3D find_global_symbol_by_name(e->orig, sym2->name);
+		if (!sym1 && find_global_symbol_by_demangled_name(e->orig, sym2, &sym1))
+			return -1;
+
+		if (sym1 && !sym1->twin) {
+			sym2->twin =3D sym1;
+			sym1->twin =3D sym2;
+		}
+	}
+
 	for_each_sym(e->orig, sym1) {
 		if (sym1->twin || dont_correlate(sym1))
 			continue;

