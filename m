Return-Path: <linux-tip-commits+bounces-2265-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F8D9720EF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20A3285064
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F3E18E748;
	Mon,  9 Sep 2024 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dLnkrD/5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h39BybJN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC43C18C912;
	Mon,  9 Sep 2024 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902883; cv=none; b=e+xgsa5Nrwp+SqOOZt01gEaX6LaB/oKOW7g+Juj+0wfnGbMjAzYPTp3vrG1v97LwXIE8AFl8nk2mSrJumORdcxIrWwux1ygWAhhyUN45c7vFrWLFXIr9q81UP6kt05wlmrz1nsQTpKRPe751zN06ArZyMMkmNUS9DKXrVIdL8Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902883; c=relaxed/simple;
	bh=/4eSCnnJiZm84cKm55vK6xDthsneDSaEvYlRAtsjRio=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SnHCQDJT3PXe7fJkYXMXXWNFiJ4LFA1GdRyr9QzsuW/iM/F8VsklSOpZK/usdt4zUH+HB7QRHNRxq8n5QXTXvsuciKjPB/EWNOZ1vWqSxYqIHwUCVlUnvxxnSsiVwL9QxPBZQilV1mMIbXKj1SO+0ymwqTLH+1dxeoJgHk5WpkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dLnkrD/5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h39BybJN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902879;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kcAUJQZsH8FB+wUpZp77u4ngmTJrA8+NRiSBXggEw+U=;
	b=dLnkrD/5OTC4exRwmV84ydEsZoGz424S9fKTb9sZd+VMsbA88pjj93CsKzTvT6L2T6FFTx
	qJi62U4617rK/yvjMUkYrbYBRO2/urwqVBGhJzh8zaQly95+EtBleQ0znkiuMbwCarOer+
	9EgCvBJTHITFPUAnCGNXBjLsABywemojqeFhfCFpIvM9zdsCzPNQYk3oizOMTo1tQYp7z+
	vYaGRmlSCWBybkoYgDcgiiJf/OkkFNG/y19yOfOo3cOsW1uzv70u0+YtmWhj3K7a3lWoTw
	v/5y4U9c2silc8uqW8wvYT+m2sVPM/FHkzLXhNfdGbsPhiWYZB0mZkQK6Ks4rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902879;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kcAUJQZsH8FB+wUpZp77u4ngmTJrA8+NRiSBXggEw+U=;
	b=h39BybJNxk3UkZjauD1vn3BSkqg6NC2KQQEnP2PXjdfRG3FPfxJmVrrPHCQUwgF8siuhZL
	OakAqMsIwtb71SAg==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/rt] printk: nbcon: Clarify rules of the owner/waiter matching
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-6-john.ogness@linutronix.de>
References: <20240820063001.36405-6-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287874.2215.1571832259655722622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     8c9dab2c55ad74680728c72949971b20d70b56ca
Gitweb:        https://git.kernel.org/tip/8c9dab2c55ad74680728c72949971b20d70b56ca
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:31 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:22 +02:00

printk: nbcon: Clarify rules of the owner/waiter matching

The functions nbcon_owner_matches() and nbcon_waiter_matches()
use a minimal set of data to determine if a context matches.
The existing kerneldoc and comments were not clear enough and
caused the printk folks to re-prove that the functions are
indeed reliable in all cases.

Update and expand the explanations so that it is clear that the
implementations are sufficient for all cases.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-6-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/nbcon.c | 56 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 776746d..931b8f0 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -228,6 +228,13 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
 	struct nbcon_state new;
 
 	do {
+		/*
+		 * Panic does not imply that the console is owned. However, it
+		 * is critical that non-panic CPUs during panic are unable to
+		 * acquire ownership in order to satisfy the assumptions of
+		 * nbcon_waiter_matches(). In particular, the assumption that
+		 * lower priorities are ignored during panic.
+		 */
 		if (other_cpu_in_panic())
 			return -EPERM;
 
@@ -259,18 +266,29 @@ static bool nbcon_waiter_matches(struct nbcon_state *cur, int expected_prio)
 	/*
 	 * The request context is well defined by the @req_prio because:
 	 *
-	 * - Only a context with a higher priority can take over the request.
+	 * - Only a context with a priority higher than the owner can become
+	 *   a waiter.
+	 * - Only a context with a priority higher than the waiter can
+	 *   directly take over the request.
 	 * - There are only three priorities.
 	 * - Only one CPU is allowed to request PANIC priority.
 	 * - Lower priorities are ignored during panic() until reboot.
 	 *
 	 * As a result, the following scenario is *not* possible:
 	 *
-	 * 1. Another context with a higher priority directly takes ownership.
-	 * 2. The higher priority context releases the ownership.
-	 * 3. A lower priority context takes the ownership.
-	 * 4. Another context with the same priority as this context
+	 * 1. This context is currently a waiter.
+	 * 2. Another context with a higher priority than this context
+	 *    directly takes ownership.
+	 * 3. The higher priority context releases the ownership.
+	 * 4. Another lower priority context takes the ownership.
+	 * 5. Another context with the same priority as this context
 	 *    creates a request and starts waiting.
+	 *
+	 * Event #1 implies this context is EMERGENCY.
+	 * Event #2 implies the new context is PANIC.
+	 * Event #3 occurs when panic() has flushed the console.
+	 * Events #4 and #5 are not possible due to the other_cpu_in_panic()
+	 * check in nbcon_context_try_acquire_direct().
 	 */
 
 	return (cur->req_prio == expected_prio);
@@ -578,11 +596,29 @@ static bool nbcon_owner_matches(struct nbcon_state *cur, int expected_cpu,
 				int expected_prio)
 {
 	/*
-	 * Since consoles can only be acquired by higher priorities,
-	 * owning contexts are uniquely identified by @prio. However,
-	 * since contexts can unexpectedly lose ownership, it is
-	 * possible that later another owner appears with the same
-	 * priority. For this reason @cpu is also needed.
+	 * A similar function, nbcon_waiter_matches(), only deals with
+	 * EMERGENCY and PANIC priorities. However, this function must also
+	 * deal with the NORMAL priority, which requires additional checks
+	 * and constraints.
+	 *
+	 * For the case where preemption and interrupts are disabled, it is
+	 * enough to also verify that the owning CPU has not changed.
+	 *
+	 * For the case where preemption or interrupts are enabled, an
+	 * external synchronization method *must* be used. In particular,
+	 * the driver-specific locking mechanism used in device_lock()
+	 * (including disabling migration) should be used. It prevents
+	 * scenarios such as:
+	 *
+	 * 1. [Task A] owns a context with NBCON_PRIO_NORMAL on [CPU X] and
+	 *    is scheduled out.
+	 * 2. Another context takes over the lock with NBCON_PRIO_EMERGENCY
+	 *    and releases it.
+	 * 3. [Task B] acquires a context with NBCON_PRIO_NORMAL on [CPU X]
+	 *    and is scheduled out.
+	 * 4. [Task A] gets running on [CPU X] and sees that the console is
+	 *    still owned by a task on [CPU X] with NBON_PRIO_NORMAL. Thus
+	 *    [Task A] thinks it is the owner when it is not.
 	 */
 
 	if (cur->prio != expected_prio)

