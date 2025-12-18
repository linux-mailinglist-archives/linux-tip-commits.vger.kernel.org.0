Return-Path: <linux-tip-commits+bounces-7762-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C703CCB44C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Dec 2025 10:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29E9F3020371
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Dec 2025 09:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04F53314D2;
	Thu, 18 Dec 2025 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DM64fKr5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+i85yLEc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3FD1E7C18;
	Thu, 18 Dec 2025 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766051510; cv=none; b=HcKQdUANyV1yIYkyTPgGpns0vKmgNqTJcBndN6l0lMJTLqPJcLlbO18kdBwZCV6Ib6U7A/NwWl+fLpMXXwje85gu1vQfhRAb7ftO+UXPPrhOjJMeH9uGX/zqh2PyPtzTOtAVCSrpu0L4bj8Jf/ynGyghEiLr4d2XomHMAQ1w3Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766051510; c=relaxed/simple;
	bh=G61/81Se1NmkVXh7UzFFadxwDZplzpjHN9TtnUeUh70=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sCT5jtlNk7lmawipiqEW1ITbYZp997280VzwiSI22lUcUT7HYpz0ZY6BZwRIzZKtvllro0Emf+y44BNPOC4RuldcJQHK8dTBslt8cQ1Whs76rbVIx6eZrhI0tePYSb1PgC9ph/trKEE9HXqayBQDCwKYH9PO7SnSvDQH5lwCLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DM64fKr5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+i85yLEc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Dec 2025 09:51:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766051507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AYcjWw3kD2D7Z478Qj1FM29LT/bYmnFr2KSDnh5to18=;
	b=DM64fKr5VyaEJVyvuc0jSoyMQJ5x/LVu+3USsliDb7i42Nn7JECU86HY7+lKoTKYb2JjPk
	GgiJ5MM+NJc2RXtrvnAhTweEecA8xh9T4ECk1g87SStChbWo2qjNx05jJC7jdPFlU/lpOP
	LkXoq7ll6gBl5XW9L+p/8Q+zJ2W0XX30PUVzUcmmbTGd+oRpUHN4AhQI2iKiZPa9873c/T
	9adHj0wNpFQHzzljz4MQhF878ha1WUX3uAMVS+/c0MdQoAJsEQGo0LQ08PfullgUyPtIoq
	Pua6NlMJE9eOE6G1ypKTMp5pOo42nG9lZOjQmY5yMbIlegFEF0XiEVHlM5VisQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766051507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AYcjWw3kD2D7Z478Qj1FM29LT/bYmnFr2KSDnh5to18=;
	b=+i85yLEcWpFbucI+ba2CX9XYLAXmFaoI4ZUlIo/1L80yAmDDRjz+H4hIhIeEs5S4dxWNmd
	5ID2gGXwZy2tmECQ==
From: "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] test-ww_mutex: Move work to its own UNBOUND workqueue
Cc: John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251205013515.759030-3-jstultz@google.com>
References: <20251205013515.759030-3-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176605150629.510.15684688440979181256.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d327e7166efa24c69719890ea332b55a9dea21a7
Gitweb:        https://git.kernel.org/tip/d327e7166efa24c69719890ea332b55a9de=
a21a7
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Fri, 05 Dec 2025 01:35:10=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 18 Dec 2025 10:45:23 +01:00

test-ww_mutex: Move work to its own UNBOUND workqueue

The test-ww_mutex test already allocates its own workqueue
so be sure to use it for the mtx.work and abba.work rather
then the default system workqueue.

This resolves numerous messages of the sort:
"workqueue: test_abba_work hogged CPU... consider switching to WQ_UNBOUND"
"workqueue: test_mutex_work hogged CPU... consider switching to WQ_UNBOUND"

Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251205013515.759030-3-jstultz@google.com
---
 kernel/locking/test-ww_mutex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index d27aaaa..30512b3 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -72,7 +72,7 @@ static int __test_mutex(struct ww_class *class, unsigned in=
t flags)
 	init_completion(&mtx.done);
 	mtx.flags =3D flags;
=20
-	schedule_work(&mtx.work);
+	queue_work(wq, &mtx.work);
=20
 	wait_for_completion(&mtx.ready);
 	ww_mutex_lock(&mtx.mutex, (flags & TEST_MTX_CTX) ? &ctx : NULL);
@@ -234,7 +234,7 @@ static int test_abba(struct ww_class *class, bool trylock=
, bool resolve)
 	abba.trylock =3D trylock;
 	abba.resolve =3D resolve;
=20
-	schedule_work(&abba.work);
+	queue_work(wq, &abba.work);
=20
 	ww_acquire_init_noinject(&ctx, class);
 	if (!trylock)

