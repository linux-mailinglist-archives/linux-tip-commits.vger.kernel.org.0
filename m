Return-Path: <linux-tip-commits+bounces-8412-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLUAOvknr2nHOwIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8412-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 21:05:13 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A002F2409D4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 21:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BA11307F9A5
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 20:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7407D41C2F5;
	Mon,  9 Mar 2026 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D1SL9q5C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sO13Uu0h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB31141C0B4;
	Mon,  9 Mar 2026 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086391; cv=none; b=fItwvcWEX/tlKrK5OnxMLGztnc40yA0cComnjme5eejGUnfNRpOkzmtlmkoa1F8cmvu4fvQnqdBhPOKuEhdfeW1iKmAZw1tk294wGwzHjaZJjL/vJnT3B50gOBot0qHkbmP2irXEunlcIyOH2cR97Xh/m8g5ECUSHaUKYasWE5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086391; c=relaxed/simple;
	bh=7AbacM6PkhzraM2NutC39V1U0+iq4lFsTCzi3jLypF0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KKHK1I0AN62yP6LkooU5aQpBx0NzhWyacqCDap0JeG5d9/b6DjjKUQR4MX+WEFyeHVbUB5rex9ZzcVdbWLNZNIRdivamO2pyQJAKJk4nz7/aF3+MLJC68/du7tLLPbQ1Cqv2upsEdmClbb6Oh4Cf0nnalNkCW+cLXcVopx+8AI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D1SL9q5C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sO13Uu0h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:59:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773086388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFfFvFC/XZYpoA3YipNYRayqOMLtyvwvvuEzExj2BPU=;
	b=D1SL9q5CAp8l956gMpDYCXUZ+0g2PpovO41pSPfzk5bWSzdWE9Z7TgXuZwn5S/245UoIoh
	mxwSnsG9sQvyBg0Q9w7fUhaK4Z21d/aOG7Y3e7Rmqv31Ml8O179brUk8nlRFuUaKcymEml
	cqs7lLtzsl3Eve4nnDcLKZJ8S4tajjB290bnCoCeBTrSZZI/1EXRtrTHZlENPwhaZ/HRl1
	vR3lyxsADWdVz0/BGbikPb5vZM4ITMWBSjzEuB9yiJMsN1eASmn2krBLYar7vzxt1P9R0U
	lHEp/NkFWSR9K4+ax8agmfLSz8LxHQSVO226Dw+KHmLbZN62oaci1RteFWUxuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773086388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFfFvFC/XZYpoA3YipNYRayqOMLtyvwvvuEzExj2BPU=;
	b=sO13Uu0hJKZuyvBK0GUyQlSb5M7TfqrBDPDfXFc2AlmNq0aAzNwFAsBJrbgA5/MUW91Doe
	YIthGOacpCnGfHDQ==
From: "tip-bot2 for Song Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool/klp: Remove .llvm suffix in demangle_name()
Cc: Song Liu <song@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260305231531.3847295-6-song@kernel.org>
References: <20260305231531.3847295-6-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308638719.1647592.15594614011127505895.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A002F2409D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8412-lists,linux-tip-commits=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     020b71dcafeeececb78d9ee9e5a2e68e8e05e922
Gitweb:        https://git.kernel.org/tip/020b71dcafeeececb78d9ee9e5a2e68e8e0=
5e922
Author:        Song Liu <song@kernel.org>
AuthorDate:    Thu, 05 Mar 2026 15:15:29 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Fri, 06 Mar 2026 08:08:33 -08:00

objtool/klp: Remove .llvm suffix in demangle_name()

Remove .llvm suffix, so that we can correlate foo.llvm.<hash 1> and
foo.llvm.<hash 2>.

Signed-off-by: Song Liu <song@kernel.org>
Link: https://patch.msgid.link/20260305231531.3847295-6-song@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 7e019f1..feaec45 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -455,6 +455,11 @@ static int read_sections(struct elf *elf)
 static ssize_t demangled_name_len(const char *name)
 {
 	ssize_t idx;
+	const char *p;
+
+	p =3D strstr(name, ".llvm.");
+	if (p)
+		return p - name;
=20
 	if (!strstarts(name, "__UNIQUE_ID_") && !strchr(name, '.'))
 		return strlen(name);
@@ -482,6 +487,9 @@ static ssize_t demangled_name_len(const char *name)
  *   __UNIQUE_ID_addressable___UNIQUE_ID_pci_invalid_bar_694_695
  *
  * to remove both trailing numbers, also remove trailing '_'.
+ *
+ * For symbols with llvm suffix, i.e., foo.llvm.<hash>, remove the
+ * .llvm.<hash> part.
  */
 static const char *demangle_name(struct symbol *sym)
 {

