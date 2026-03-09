Return-Path: <linux-tip-commits+bounces-8413-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNshChwor2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8413-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 21:05:48 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E0E2409F6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 21:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7F8F30E5002
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 20:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE20941C317;
	Mon,  9 Mar 2026 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W51XO/1c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ATGiFuLx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB6241C2E4;
	Mon,  9 Mar 2026 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086392; cv=none; b=YM2Gaa2v0bohj0sTeEE2iiA3amHOdtpvHhifk9Uan1CrLOFZvMJrV7arz7WkofXEXy0SHsTDdH0S8P5m6dOIf5FnhlvP1r7Bq6SLCYyPfHfmW5x61OXs2f+eXrZem/f7K+2BWqyqOufYzG97/9l9l/eVVJvKXfeUvKcA7ZwnkU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086392; c=relaxed/simple;
	bh=fdF5L5dEkf+4PjHjROeXOrvFzMFkRxoVMpEUNRxitFc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XamngTFNpAP10bZQJtlL2EnbVyy6uTkXjCA7Cjar3VgNQ4efk35hgzBwhBhsthM898Zkkj5z7GPJNtMhjHNilxYviSjeIAZLRTFzHqlYSgeWXS+ycBw9USIiDDf08YSIShRvlSWJwDzU625VIXXLGWfwG1chEqoAeA4p+jBgJTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W51XO/1c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ATGiFuLx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:59:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773086389;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09IbMFgVgY8VqA4/d1GBD9lJ12mQX/9vYbhpBoOUiM0=;
	b=W51XO/1c/k8N52qa58Bk0HWmXk35SI82clKufg+AR8UkwhSYzQ48ryWafcEtMrMvrpl6ux
	HoEnXbE9JUOxNJDu+2a5S0IL9ZmFB4IZER8L8g5f/6CpVRzjGe1ZijG3vGv3uURZlhn50z
	FtWC8ansO5F55MjU+08hEez6bm1gsKjpcQaxQMyqM1IW4KJF/fj0M2NJKlWPZPMUUPpIop
	LF+5LsemwcC4+BJN/H7n5wvIzCm75J8bNhVOQezm9Za86wOfgyLP7bKCgJXUeP7ogW7S98
	y8fJTGBE+FaYsWSOWM+7K4EAfl5v8SmsldywqVcVUsg3HWdrtjR1NqdcstTRYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773086389;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09IbMFgVgY8VqA4/d1GBD9lJ12mQX/9vYbhpBoOUiM0=;
	b=ATGiFuLxEpuEy9mADfkULR7xaEp7+VHR0rapF6evM4TvhE4cTzQloyOEYircQctnEsadW5
	A4f36qCj5tmqRSAg==
From: "tip-bot2 for Song Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool/klp: Also demangle global objects
Cc: Song Liu <song@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260305231531.3847295-5-song@kernel.org>
References: <20260305231531.3847295-5-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308638822.1647592.2081908226739900372.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 81E0E2409F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8413-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linutronix.de:dkim,vger.kernel.org:replyto];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     8206277746d5c6ae300e7e062a0d9238ed59cc7f
Gitweb:        https://git.kernel.org/tip/8206277746d5c6ae300e7e062a0d9238ed5=
9cc7f
Author:        Song Liu <song@kernel.org>
AuthorDate:    Thu, 05 Mar 2026 15:15:28 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Fri, 06 Mar 2026 08:08:32 -08:00

objtool/klp: Also demangle global objects

With CONFIG_LTO_CLANG_THIN, it is possible to have global __UNIQUE_ID,
such as:

   FUNC    GLOBAL HIDDEN  19745 __UNIQUE_ID_quirk_amd_nb_node_458

Also demangle global objects.

Signed-off-by: Song Liu <song@kernel.org>
Link: https://patch.msgid.link/20260305231531.3847295-5-song@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index b2d73c4..7e019f1 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -488,9 +488,6 @@ static const char *demangle_name(struct symbol *sym)
 	char *str;
 	ssize_t len;
=20
-	if (!is_local_sym(sym))
-		return sym->name;
-
 	if (!is_func_sym(sym) && !is_object_sym(sym))
 		return sym->name;
=20

