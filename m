Return-Path: <linux-tip-commits+bounces-8220-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH1VAqIsnGmcAQQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8220-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:32:02 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 620CC174EDA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10515305DB91
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 10:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7D435B649;
	Mon, 23 Feb 2026 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xWiKzDfX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rzoH/FoM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5547350299;
	Mon, 23 Feb 2026 10:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842315; cv=none; b=K1u76jYuNqhtIPOkDrwNoSEM06zZ5suuVHmRLWv4A2dpqLnYJr5vMd2nrIw8QkyPuHJuTSXUH2C2bW0zAahgZjWsn3zKiwnd4Kd+KO9SBCwjceHu/F4flnr1dr6WlOjmCv/cwjimmrOuH11aBEvfcOjhxDZoKCeHgPB9K431N0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842315; c=relaxed/simple;
	bh=pzdOTZci/WxcBIz6cxFUen4HsI7yNKzdHli9jIB8bNc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LpWksPBY+3Rs4fdP/a2uAMP++MpCchL9dOfsLyeg4KgoG8WpedbegOxRGU/h0bQNB6+22iSwXcEw2q4J6orIE1XBoX6ITgxnEaCU5C6/D9E2qF7uIIhGXFr1BDpwdb8W1QNoBPZsKfuq2u3mMQ2z7hF90QaUcuLJ5v1LIzhc4a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xWiKzDfX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rzoH/FoM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 23 Feb 2026 10:25:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771842312;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6AZbgK7vL7m3EXJGl3OxkitCItbsbnjGcFQcGPWYHo=;
	b=xWiKzDfXJcQGF98i4ku/VkYKE8MK5ZPFnZzHhJo9c5tpis/5r5XGdfDTd/aPr2y1TQTayw
	Ynw+D5ELJRO4v0nS2QFmXH7HRvRWuf9lq6jHa8O8KVVc60M9ALGkcSjvamj8T7mx9rLYCl
	CnxQ5GN13mBbbdaa+WbuuEf3CA5bbFX8IGxLBpOikTCFHoZnM/vYTxLdtPpLqqRtjEA1l9
	H8tKQXGDzYOuQ7M3IaceSL82lFG9txjJFW7ooTTM2Ajpdwf3bomdJgFqHL9adlqlv8IJLC
	PZsnParnm5B3iFIGsZYRE83NoS48NF6n74BOUMl6qpl53VzHHDRlnoltgVE2qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771842312;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6AZbgK7vL7m3EXJGl3OxkitCItbsbnjGcFQcGPWYHo=;
	b=rzoH/FoMUBzNMY4O55/uqwsB4jqjcfAGvArV+82Poar/MjTBXPs+iJfkQqjCR2pOo5FHK7
	mGo1OM2z06mdahCg==
From: "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/mutex: Rename mutex_init_lockep()
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260217191512.1180151-2-dave@stgolabs.net>
References: <20260217191512.1180151-2-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177184231102.1647592.15870693130422478932.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8220-lists,linux-tip-commits=lfdr.de];
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
X-Rspamd-Queue-Id: 620CC174EDA
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8b65eb52d93e4e496bd26e6867152344554eb39e
Gitweb:        https://git.kernel.org/tip/8b65eb52d93e4e496bd26e6867152344554=
eb39e
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Tue, 17 Feb 2026 11:15:10 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 11:19:15 +01:00

locking/mutex: Rename mutex_init_lockep()

Typo, this wants to be _lockdep().

Fixes: 51d7a054521d ("locking/mutex: Redo __mutex_init() to reduce generated =
code size")
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260217191512.1180151-2-dave@stgolabs.net
---
 include/linux/mutex.h  | 4 ++--
 kernel/locking/mutex.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index ecaa044..8126da9 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -87,12 +87,12 @@ do {									\
 	struct mutex mutexname =3D __MUTEX_INITIALIZER(mutexname)
=20
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-void mutex_init_lockep(struct mutex *lock, const char *name, struct lock_cla=
ss_key *key);
+void mutex_init_lockdep(struct mutex *lock, const char *name, struct lock_cl=
ass_key *key);
=20
 static inline void __mutex_init(struct mutex *lock, const char *name,
 				struct lock_class_key *key)
 {
-	mutex_init_lockep(lock, name, key);
+	mutex_init_lockdep(lock, name, key);
 }
 #else
 extern void mutex_init_generic(struct mutex *lock);
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 2a1d165..c867f6c 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -171,7 +171,7 @@ static __always_inline bool __mutex_unlock_fast(struct mu=
tex *lock)
=20
 #else /* !CONFIG_DEBUG_LOCK_ALLOC */
=20
-void mutex_init_lockep(struct mutex *lock, const char *name, struct lock_cla=
ss_key *key)
+void mutex_init_lockdep(struct mutex *lock, const char *name, struct lock_cl=
ass_key *key)
 {
 	__mutex_init_generic(lock);
=20
@@ -181,7 +181,7 @@ void mutex_init_lockep(struct mutex *lock, const char *na=
me, struct lock_class_k
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
 	lockdep_init_map_wait(&lock->dep_map, name, key, 0, LD_WAIT_SLEEP);
 }
-EXPORT_SYMBOL(mutex_init_lockep);
+EXPORT_SYMBOL(mutex_init_lockdep);
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
=20
 static inline void __mutex_set_flag(struct mutex *lock, unsigned long flag)

