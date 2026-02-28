Return-Path: <linux-tip-commits+bounces-8280-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I5MEerKomnz5QQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8280-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 12:00:58 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C76551C26A0
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 12:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD0793085A59
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 10:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756A542E004;
	Sat, 28 Feb 2026 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dGb+67uK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CsjZwOTA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1AF43D4F1;
	Sat, 28 Feb 2026 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276216; cv=none; b=F5Wj3KUhhBlzDCsayi3VL+nZYNjD8hjUfi08wxnm4YLRxdUOg7jreScXHji7RSGcBEwQYBlbnovOQafjYyuC2bbaHkQxOBW9pthQWZZLhNZ0be7Z8ZIpB0L7gXY2CWhoQRbF5Yp2iNsDjFTlpxl115JkYi1oP86XSYsfn0GrDW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276216; c=relaxed/simple;
	bh=5WK8N/q/QQl/Y0nKO2ByYDrPl9mJ7Nj0cV9fcl4N0Y8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KjiZIcr3Sb/Cayl81p2wgFrydElsF3K3u4eo5UYcqsOcdCyWzVBK5ScqFUB8eGB97zf9Y/sHIvEkxQEP2dNwBQlFvdzgKOJLYdY2vaTjd68Mp6x3YJA6h9icamvceohZR7cIzxcwAIe5Yp9Qsvv8J9aQMtCHt37sUMIB7k6MusQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dGb+67uK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CsjZwOTA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 10:56:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772276210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bgrhWZcQUmj9nOhiwe+OaVSlCNAGn1IWJJdmxw/nVyg=;
	b=dGb+67uKtAY/wi41Hr35KaIUCpyToY1QzFb/QImX0eMj2/V3gCwyeyIkY8k8uvHIKj1ewu
	jNGLzfmZJbITQ160lhCVs5mrpx3/uBlNgIBe53eLlP0+HSKbbKtgIhZ+fOYQSkrnOLilWy
	5aeDBVBrEE65hyKKgrSiR3UiZsiW4XShGfYOGFEhGDn4cnA4h9Y45R63eUDd1uQaEV0emQ
	dcbgPexfe+kMl+wD9jTr6EVt34IWbJJ2tylZbpbJnA2oQzLQotZQ8fv7tcUKs1p5BGa947
	sfLOj5xsSwhYY1HRyezybzXoObBn5Y6UjwAwh22fKAN0n+QMmyQ5aOsMJ5Dh3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772276210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bgrhWZcQUmj9nOhiwe+OaVSlCNAGn1IWJJdmxw/nVyg=;
	b=CsjZwOTAJ0BIwNymw+e6fLQjrrvoie+5Yb0iF+9TYCbTEHNRdNgFYljcP6qSSLtnDaXUlB
	BAkGWeRiDeMz5+Aw==
From: "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Pass GFP flags to attach_task_ctx_data()
Cc: Namhyung Kim <namhyung@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260211223222.3119790-2-namhyung@kernel.org>
References: <20260211223222.3119790-2-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177227620940.1647592.8976791210708047470.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8280-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:dkim,msgid.link:url,vger.kernel.org:replyto];
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
X-Rspamd-Queue-Id: C76551C26A0
X-Rspamd-Action: no action

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     28c75fbfec8f024db1278194918e5f6eda4c570f
Gitweb:        https://git.kernel.org/tip/28c75fbfec8f024db1278194918e5f6eda4=
c570f
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Wed, 11 Feb 2026 14:32:19 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:21 +01:00

perf/core: Pass GFP flags to attach_task_ctx_data()

This is a preparation for the next change to reduce the computational
complexity in the global context data handling for LBR callstacks.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260211223222.3119790-2-namhyung@kernel.org
---
 kernel/events/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ac70d68..90b0c93 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5370,15 +5370,15 @@ static void unaccount_freq_event(void)
=20
=20
 static struct perf_ctx_data *
-alloc_perf_ctx_data(struct kmem_cache *ctx_cache, bool global)
+alloc_perf_ctx_data(struct kmem_cache *ctx_cache, bool global, gfp_t gfp_fla=
gs)
 {
 	struct perf_ctx_data *cd;
=20
-	cd =3D kzalloc_obj(*cd);
+	cd =3D kzalloc_obj(*cd, gfp_flags);
 	if (!cd)
 		return NULL;
=20
-	cd->data =3D kmem_cache_zalloc(ctx_cache, GFP_KERNEL);
+	cd->data =3D kmem_cache_zalloc(ctx_cache, gfp_flags);
 	if (!cd->data) {
 		kfree(cd);
 		return NULL;
@@ -5412,11 +5412,11 @@ static inline void perf_free_ctx_data_rcu(struct perf=
_ctx_data *cd)
=20
 static int
 attach_task_ctx_data(struct task_struct *task, struct kmem_cache *ctx_cache,
-		     bool global)
+		     bool global, gfp_t gfp_flags)
 {
 	struct perf_ctx_data *cd, *old =3D NULL;
=20
-	cd =3D alloc_perf_ctx_data(ctx_cache, global);
+	cd =3D alloc_perf_ctx_data(ctx_cache, global, gfp_flags);
 	if (!cd)
 		return -ENOMEM;
=20
@@ -5499,7 +5499,7 @@ again:
=20
 	return 0;
 alloc:
-	ret =3D attach_task_ctx_data(p, ctx_cache, true);
+	ret =3D attach_task_ctx_data(p, ctx_cache, true, GFP_KERNEL);
 	put_task_struct(p);
 	if (ret) {
 		__detach_global_ctx_data();
@@ -5519,7 +5519,7 @@ attach_perf_ctx_data(struct perf_event *event)
 		return -ENOMEM;
=20
 	if (task)
-		return attach_task_ctx_data(task, ctx_cache, false);
+		return attach_task_ctx_data(task, ctx_cache, false, GFP_KERNEL);
=20
 	ret =3D attach_global_ctx_data(ctx_cache);
 	if (ret)
@@ -9240,7 +9240,7 @@ perf_event_alloc_task_data(struct task_struct *child,
=20
 	return;
 attach:
-	attach_task_ctx_data(child, ctx_cache, true);
+	attach_task_ctx_data(child, ctx_cache, true, GFP_KERNEL);
 }
=20
 void perf_event_fork(struct task_struct *task)

