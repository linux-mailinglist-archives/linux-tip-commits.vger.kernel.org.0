Return-Path: <linux-tip-commits+bounces-8134-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kM1kJN9oemmB5gEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8134-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 20:51:59 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B26A4A849D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 20:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00E39301151A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 19:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1BC37647B;
	Wed, 28 Jan 2026 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eDIA3Ruq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qJeHAQcC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876FA37474F;
	Wed, 28 Jan 2026 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769629877; cv=none; b=uelewYBh0y6GROZmL6BlO+k9bitD5wPABmLn0d22i9etzvN/W8xWpFv/LOwcgTNpGIzfGyvkfBUVf4hZ9Ol9xPN9g4HHipKg4e3L9BwkPiyCcOEdn+/1QUQsdHXl6V4qPLPcIQK3znAX/VSP3HJxWDDoamD1YE88nKtnlIrfI30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769629877; c=relaxed/simple;
	bh=HweoXW20mKmTjvS/fYH5ptxRUICz2ie+L0iIn65vWko=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PjsFwcMFu/Eabf7jVbi3hxKFg8CfNfYbSoM59mskN8dezFo9HzckIAe2u136RbQB/TjLK4+SO/YNpSVq6a5qMqGcUZSZ0am3LNdByRtozgE5S4GqAyWHctTy/MrxHnKuEutodV+z0AclGbw7sHYfbJox/v/wYRouGZFx84oJYi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eDIA3Ruq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qJeHAQcC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Jan 2026 19:51:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769629874;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5G1dUGCzZT4L/CFvFJV6cN/gW75pVTKWuZWzKMGVjD8=;
	b=eDIA3Ruqywd+sJaBLZiHhsQh9Pi4VSCAC3MvyfE5DeBN9HXpujQoBnlZU+UwlT2A0gKrlr
	AQHR4I+z36LEhsUBfeTIZFsneVUVOGRRLWjiJwvzSICC1jxOrOVIe4kge5qHHdmGDcv0XS
	CoUtVYA0Ge80/5g2npqfTK7YyRJZ81VzefyB6zPDJ4rS5CxOy56nJxev8WWORu5sxSM6+3
	gSwwd0e3bT2aI0uvvMBJOpPIZK6eBSubVJTnbTbUpJ71QhanYxilwxjcyOb/OfHlJxn8L0
	8F21noLTPf6qt+KQXA7vGu00amJ5pBpSDwJgA3DYLv2vYskklv6bQDKUHWzV9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769629874;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5G1dUGCzZT4L/CFvFJV6cN/gW75pVTKWuZWzKMGVjD8=;
	b=qJeHAQcC28HgeP8mxMEk9sJW6431UGjY82NyyGhjbtnzf+BV3Mg5/LHBuOZM7IhOXyff0L
	AK8tcUzileLhFODQ==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcov: Use scoped init guard
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260119094029.1344361-4-elver@google.com>
References: <20260119094029.1344361-4-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176962987344.2495410.8693404089061799178.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8134-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: B26A4A849D
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b7be9442a3758a27a4b09b75ad79f3626b16ec3d
Gitweb:        https://git.kernel.org/tip/b7be9442a3758a27a4b09b75ad79f3626b1=
6ec3d
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 19 Jan 2026 10:05:53 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 28 Jan 2026 20:45:24 +01:00

kcov: Use scoped init guard

Convert lock initialization to scoped guarded initialization where
lock-guarded members are initialized in the same scope.

This ensures the context analysis treats the context as active during
member initialization. This is required to avoid errors once implicit
context assertion is removed.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260119094029.1344361-4-elver@google.com
---
 kernel/kcov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 6cbc6e2..5397d0c 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -530,7 +530,7 @@ static int kcov_open(struct inode *inode, struct file *fi=
lep)
 	kcov =3D kzalloc(sizeof(*kcov), GFP_KERNEL);
 	if (!kcov)
 		return -ENOMEM;
-	spin_lock_init(&kcov->lock);
+	guard(spinlock_init)(&kcov->lock);
 	kcov->mode =3D KCOV_MODE_DISABLED;
 	kcov->sequence =3D 1;
 	refcount_set(&kcov->refcount, 1);

