Return-Path: <linux-tip-commits+bounces-8218-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNw/Mr4snGkKAgQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8218-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:32:30 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3748B174EF6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02E06302F9B1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 10:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B487E356A3E;
	Mon, 23 Feb 2026 10:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zUt7yIJb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NGUPwPqR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2352E63C;
	Mon, 23 Feb 2026 10:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842313; cv=none; b=j5jNrtABUL77jsAMAmnZBtSItxSdDuRgoG6CkvKffQFTX6WcQqy6YfO/aA26uB8ZRaOYtJUCSfOn/h+X3kTVlgVJyHLw61PmrEq4EVwfl0FS8qJtidUYePzVwVkrVTjIX/p9IA5WiiTDVO11a5GrNQDsonvOk5cV3os+5cyWnBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842313; c=relaxed/simple;
	bh=w/SvXg2kMiofOOWTAGDlRDdcY3hmRVV4FxpNA9J/hx4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JcYsXuicRdsEdMWB0y83KPmRttlNie3zEWWv4sQDn4oMRVIBSHMzD1DAHtJCxFB2IqED6VD4r/DFYeaqYOAeM0etkpM+8u9eqGhj18nCqtUIfmp8+TUURXV4nYSiU4mspfCTq8YVnxZlD80qjBEu+O/Vb7ADWshqquZvh/zgsz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zUt7yIJb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NGUPwPqR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 23 Feb 2026 10:25:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771842311;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESgEcKbgEKrsPFQLCjRBo2HBly07fHtNu/SC3uYBsJg=;
	b=zUt7yIJb6pEUB3/iqVdU1XjWP3kZ5uAqFbhYTQGb5r2q+dV/sNoOAmEFeNFwWQe8sDzfAR
	z3qgb7+yu8lsgy+Am0yNe8AdFTeMibBWZmE0h52QJtH2WCyTRo2DZCTajJVIjI+yUV2WLA
	YKiAQB4BjtyWCKkRM4ZUZ6N+/s/dx00jjNXCgU5QPueS2/CW81Eobn8h+pPNMIygXCcPP7
	3CbugmqC8mVgsnh3BSAnon02seJ1otJO7+2qp/R7XV1cA8oAl8l68JTkcM5yF1HSfZlb6S
	1CL0KCRhFDLc42CgscSrEutArjiwYWUVI36SR5hYCrQjfOVzzrrWp4mDnjPjIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771842311;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESgEcKbgEKrsPFQLCjRBo2HBly07fHtNu/SC3uYBsJg=;
	b=NGUPwPqRxpKd6g2xVG58g0R8E+VKoPk+hYBtJiGaEtgCMM+BPlHYXEOSiVvdtw3ZVcOWB+
	ZSDCNlx37PKwUQAw==
From: "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/mutex: Fix wrong comment for
 CONFIG_DEBUG_LOCK_ALLOC
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260217191512.1180151-3-dave@stgolabs.net>
References: <20260217191512.1180151-3-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177184230989.1647592.7105928329204729542.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8218-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,stgolabs.net:email,linutronix.de:dkim,vger.kernel.org:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 3748B174EF6
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     babcde3be8c9148aa60a14b17831e8f249854963
Gitweb:        https://git.kernel.org/tip/babcde3be8c9148aa60a14b17831e8f2498=
54963
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Tue, 17 Feb 2026 11:15:11 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 11:19:16 +01:00

locking/mutex: Fix wrong comment for CONFIG_DEBUG_LOCK_ALLOC

... that endif block should be CONFIG_DEBUG_LOCK_ALLOC, not
CONFIG_LOCKDEP.

Fixes: 51d7a054521d ("locking/mutex: Redo __mutex_init() to reduce generated =
code size")
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260217191512.1180151-3-dave@stgolabs.net
---
 include/linux/mutex.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 8126da9..f57d2a9 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -146,7 +146,7 @@ static inline void __mutex_init(struct mutex *lock, const=
 char *name,
 {
 	mutex_rt_init_generic(lock);
 }
-#endif /* !CONFIG_LOCKDEP */
+#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
 #endif /* CONFIG_PREEMPT_RT */
=20
 #ifdef CONFIG_DEBUG_MUTEXES

