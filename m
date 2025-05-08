Return-Path: <linux-tip-commits+bounces-5489-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50724AAF81A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09ED17254E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC721238C29;
	Thu,  8 May 2025 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sy+ar1T4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DfTYiiQq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357C3221FBB;
	Thu,  8 May 2025 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700473; cv=none; b=E5gwUPHSpFiUWOeYuxgcUNuZV7PnOWRn8RKUPXiIDul0ARkux3aoIZgOK7sIbQ/3Z6Gmjf9MFp0Q/vkj45n/89ufU49IdWTNdtjFQzuK16Y6RAV/smRYIfRa9d5jjG7eKO2XaLQ3qfUIL8nJvFi1CM6+Dt/PuiHmVWQvfEDU4wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700473; c=relaxed/simple;
	bh=akRbmWWy3uo32+sDV8dHAIM/IIfD+jvarYBomPIFZV8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RddRppWQfvb/sG8epm0pJgJoLkzcyJWUdtWwG/3NN6ZkDLZ3SEFKA/PTxvoUVtf5stuIPZnyHliRkRvd7h+Q3+MjjVfGEqAEMBUo/RUGQFClxcnhaIpdkOg3ArSsF9b4u6jcFb5G/z8JVOTFju34LaDNqf8gGWKHUvruUUECbXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sy+ar1T4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DfTYiiQq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:34:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700470;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLEpIjw9+8EJkKD40HuKH2wm7JNGz7RqkCTlT0hBhBs=;
	b=Sy+ar1T4kz4qr8Mpi7guhYpnlLLtVrVxsIYr+7D7Rh/AJ4sXoZd938YTuzZXVhDMIZ8arn
	na7ysmEbNx5NcXvxo3vmWfztWMnAgu0kCRIs0rdbWxnFirOQ3U/cOpqfDbJTDkXLkNZRmP
	SITyssX4bY98yJ5fZUqn+tofWZaEC1Pdo2fIn2N+eGNKY4gKUkNUDbgb42A4OYbz7mgzW8
	x/4vmIEXPpX+GMwnIyT9e23u2BFtt4YXjFaKj+4IV3SitEzxacaIn36T6QEB9uBBgLjazb
	MOgp7mi8tmT0k1dZp8iBu9sWA2rKcfgjzp3jlpQ9jJarhvLCPUy05LmJMTptVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700470;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLEpIjw9+8EJkKD40HuKH2wm7JNGz7RqkCTlT0hBhBs=;
	b=DfTYiiQqfZ6HSVwFxG3N9ULV9ePRS0vlG2g4bn6PoeMwfWRTGMr6iZmIZkkqtXmYh0BwVy
	2yoq+ultuoyCm7CQ==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Fix failing inherit_event() doing extra
 refcount decrement on parent
Cc: Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250424161128.29176-2-frederic@kernel.org>
References: <20250424161128.29176-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670046994.406.11347888958227901456.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f162bd64d95f42f42d1efdba555d898dd14af758
Gitweb:        https://git.kernel.org/tip/f162bd64d95f42f42d1efdba555d898dd14af758
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 24 Apr 2025 18:11:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 May 2025 12:40:40 +02:00

perf: Fix failing inherit_event() doing extra refcount decrement on parent

When inherit_event() fails after the child allocation but before the
parent refcount has been incremented, calling put_event() wrongly
decrements the reference to the parent, risking to free it too early.

Also pmu_get_event() can't be holding a reference to the child
concurrently at this point since it is under pmus_srcu critical section.

Fix it with restoring the deleted free_event() function and call it on
the failing child in order to free it directly under the verified
assumption that its refcount is only 1. The refcount to the parent is
then voluntarily omitted.

Fixes: da916e96e2de ("perf: Make perf_pmu_unregister() useable")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250424161128.29176-2-frederic@kernel.org
---
 kernel/events/core.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 05136e8..882db7b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5628,6 +5628,22 @@ static void _free_event(struct perf_event *event)
 }
 
 /*
+ * Used to free events which have a known refcount of 1, such as in error paths
+ * of inherited events.
+ */
+static void free_event(struct perf_event *event)
+{
+	if (WARN(atomic_long_cmpxchg(&event->refcount, 1, 0) != 1,
+				     "unexpected event refcount: %ld; ptr=%p\n",
+				     atomic_long_read(&event->refcount), event)) {
+		/* leak to avoid use-after-free */
+		return;
+	}
+
+	_free_event(event);
+}
+
+/*
  * Remove user event from the owner task.
  */
 static void perf_remove_from_owner(struct perf_event *event)
@@ -14184,7 +14200,7 @@ inherit_event(struct perf_event *parent_event,
 
 	pmu_ctx = find_get_pmu_context(child_event->pmu, child_ctx, child_event);
 	if (IS_ERR(pmu_ctx)) {
-		put_event(child_event);
+		free_event(child_event);
 		return ERR_CAST(pmu_ctx);
 	}
 	child_event->pmu_ctx = pmu_ctx;
@@ -14199,7 +14215,7 @@ inherit_event(struct perf_event *parent_event,
 	if (is_orphaned_event(parent_event) ||
 	    !atomic_long_inc_not_zero(&parent_event->refcount)) {
 		mutex_unlock(&parent_event->child_mutex);
-		put_event(child_event);
+		free_event(child_event);
 		return NULL;
 	}
 

