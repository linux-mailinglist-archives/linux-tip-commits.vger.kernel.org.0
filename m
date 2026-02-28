Return-Path: <linux-tip-commits+bounces-8278-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCOyMVXKomnz5QQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8278-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:58:29 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4EE1C260F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7AF53003378
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 10:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029BF43CEE4;
	Sat, 28 Feb 2026 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nunl+5JT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RcXklU4b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED4E43C076;
	Sat, 28 Feb 2026 10:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276210; cv=none; b=TpVQTlfBkThcJ6xSkCN9kUIR4HSuTppUEoEEZhtSgDEWSR2LcwuuGonl4npiCHE7vlFoF/3eyyKEkBuySj9xKX0m5Z5Etc/f4mLm2UMO6UmYsQ3d24fKrcssExBM8sO3UU6Ep4R3fjUZilJqGjdiPyrE7K1JyKmGgJ5g3nLoZec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276210; c=relaxed/simple;
	bh=FEnBnG5LIpjZT6q8Duc/bJNtZcHwhekHfm2IwZSKidw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PL+gIu0CPTg2IoEUBFoZu7zjRsbDY+EWSNgE/VkJOYK8iolJy/IQMCnYzRHBGef2TC3rTp2k3EhbH6/xc+IVK6yPiC3PNhBxAWO9DzUS+3KdSAFAS8SLgi4mYrY3EE5f0wVlQpDo0bg8y0Ljryj71TPXZRnf26L7U1JhkvBof1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nunl+5JT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RcXklU4b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 10:56:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772276208;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hU949Er8HIdiD/G8Hs+mbW/rqi4WlLWDjKMLhG4UEBg=;
	b=Nunl+5JT0EjDRe3pKiuZsooyH/H+EZaPIs6E6qZANdGykx5amL6Mw1OlcOBmXJiuEfEBC5
	De4mmx21qwelD5zDTuCzqLPSssipxX6Owhos9jymlB5kHjKUCI5ELJOeCYdE6OMbMAso1W
	9jP8MFYoSIkUkCuIufBVQKpGBXTwO2bfxsCpZXahFsby7RFbJbk51ZXZthRTM8MozCBHzy
	5fI5nrl4CeS4jkn1P4McMrofLbUjZ+5JrI9/NbAClGzWAR6G376/8eNPgp7H8hxWZs0e5F
	Pos4uSiic1byFCG7Ri0YaqAQV6ycZE7LzY4DvtphXVrmMlPXL+qrVV4jzroExA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772276208;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hU949Er8HIdiD/G8Hs+mbW/rqi4WlLWDjKMLhG4UEBg=;
	b=RcXklU4bSsys3gIJEl1yqTaxFdDhKpU7rXWvZu7QIg4tf8YLT7isGGiG6Pz8MWXrUtUuaP
	Xbgr9nPAFnGCjzBg==
From: "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Simplify __detach_global_ctx_data()
Cc: Namhyung Kim <namhyung@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260211223222.3119790-4-namhyung@kernel.org>
References: <20260211223222.3119790-4-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177227620714.1647592.9729034731958013027.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8278-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linutronix.de:dkim,msgid.link:url,vger.kernel.org:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 8D4EE1C260F
X-Rspamd-Action: no action

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     da45c8d5f051434a3c68397e66ae2d3b3c97cdec
Gitweb:        https://git.kernel.org/tip/da45c8d5f051434a3c68397e66ae2d3b3c9=
7cdec
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Wed, 11 Feb 2026 14:32:21 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:22 +01:00

perf/core: Simplify __detach_global_ctx_data()

Like in the attach_global_ctx_data() it has a O(N^2) loop to delete task
context data for each thread.  But perf_free_ctx_data_rcu() can be
called under RCU read lock, so just calls it directly rather than
iterating the whole thread list again.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260211223222.3119790-4-namhyung@kernel.org
---
 kernel/events/core.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d357714..5eeae86 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5560,22 +5560,15 @@ static void __detach_global_ctx_data(void)
 	struct task_struct *g, *p;
 	struct perf_ctx_data *cd;
=20
-again:
 	scoped_guard (rcu) {
 		for_each_process_thread(g, p) {
 			cd =3D rcu_dereference(p->perf_ctx_data);
-			if (!cd || !cd->global)
-				continue;
-			cd->global =3D 0;
-			get_task_struct(p);
-			goto detach;
+			if (cd && cd->global) {
+				cd->global =3D 0;
+				detach_task_ctx_data(p);
+			}
 		}
 	}
-	return;
-detach:
-	detach_task_ctx_data(p);
-	put_task_struct(p);
-	goto again;
 }
=20
 static void detach_global_ctx_data(void)

