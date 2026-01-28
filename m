Return-Path: <linux-tip-commits+bounces-8133-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFywAMdoemmB5gEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8133-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 20:51:35 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69022A848F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 20:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 139CB3020ED4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 19:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCA3374747;
	Wed, 28 Jan 2026 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QY7ZirNx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ixdXEpQr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DA0353EF4;
	Wed, 28 Jan 2026 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769629876; cv=none; b=HS2UEgjCLjDNx69ed6gqswzaxcOz/WIii5mS0Yib6AiBI782oQKmAH/OV8/FhgqG3AtpPoOwkqHjvfx9WFRj1fKsp5d9/2vYFQIEanuRccciroIl8M3iL8nmIZWnnb92zbHT2o9eYl2MgvRF9esbwR9s0xgYjxJtFQy2pPuHm4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769629876; c=relaxed/simple;
	bh=dtfn0zohu0XhjgE2d/OxyRHaA1IsmZO7YcPWU55vt/M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DtBsFAqnP6Xg1gQMnp52JGmVzCJ+I3Iy+T5VLO54ektem3+fk8EcgfVzanisObPBTzmS1oP3X8kmoLicHZP/4jz20kd13tiKpsR4cKToOxQ+knT2EkmbG4VjnnxJaAU+aj0F6m8jlElPrbj1jkQauIeCyGTa/Ki+cFSr7V1simw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QY7ZirNx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ixdXEpQr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Jan 2026 19:51:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769629873;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/jzdKgpdkGj7ztqUxXZAkkTKs6nmNQDBlBAJ4kkURA=;
	b=QY7ZirNx/WKXXCQkU23q+zJSyvBU+gH5XzTc6pCvrhMMHnp3g0BaRjepK+W1nbM/cmRMl4
	3Hu1etyxRyyUiB0lS7+BuZrM0C1fBR4rl5Y+bfl6RoZ/7W2asYVn81hXgpWv4H99KeBONb
	zsQtvT7yUCzFC7bJzeAtfIvC2iLxq7TwKYuAeuzU63BlZIH6NZNcvTMPwlZn9hs0i5HpW3
	dMB150YgiUHA9ImvadyH5oK+jzo94uKuwgOLHFxRpgSelhdj7Turbz2I/p8AcxsA1wBAtd
	vOwyGRy+ZibtA1p1vdixFH3UsSqbokob5JH/ftFG1KTCeCTA98SzEBNSzYVcbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769629873;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/jzdKgpdkGj7ztqUxXZAkkTKs6nmNQDBlBAJ4kkURA=;
	b=ixdXEpQrYuW2QQZnWKZ11APvooNzGcZgpoQfdxdlist8LcTbf6DYggIWK10Slxq9uy/YWI
	3ImhXcrFcUciVMCg==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] crypto: Use scoped init guard
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260119094029.1344361-5-elver@google.com>
References: <20260119094029.1344361-5-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176962987215.2495410.960555823394445220.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8133-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 69022A848F
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f39261f55b3ee58d85e96142763c25b945399b2f
Gitweb:        https://git.kernel.org/tip/f39261f55b3ee58d85e96142763c25b9453=
99b2f
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 19 Jan 2026 10:05:54 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 28 Jan 2026 20:45:24 +01:00

crypto: Use scoped init guard

Convert lock initialization to scoped guarded initialization where
lock-guarded members are initialized in the same scope.

This ensures the context analysis treats the context as active during member
initialization. This is required to avoid errors once implicit context
assertion is removed.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260119094029.1344361-5-elver@google.com
---
 crypto/crypto_engine.c | 2 +-
 crypto/drbg.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
index 1653a4b..afb6848 100644
--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -453,7 +453,7 @@ struct crypto_engine *crypto_engine_alloc_init_and_set(st=
ruct device *dev,
 	snprintf(engine->name, sizeof(engine->name),
 		 "%s-engine", dev_name(dev));
=20
-	spin_lock_init(&engine->queue_lock);
+	guard(spinlock_init)(&engine->queue_lock);
 	crypto_init_queue(&engine->queue, qlen);
=20
 	engine->kworker =3D kthread_run_worker(0, "%s", engine->name);
diff --git a/crypto/drbg.c b/crypto/drbg.c
index 0a6f6c0..21b339c 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1780,7 +1780,7 @@ static inline int __init drbg_healthcheck_sanity(void)
 	if (!drbg)
 		return -ENOMEM;
=20
-	mutex_init(&drbg->drbg_mutex);
+	guard(mutex_init)(&drbg->drbg_mutex);
 	drbg->core =3D &drbg_cores[coreref];
 	drbg->reseed_threshold =3D drbg_max_requests(drbg);
=20

