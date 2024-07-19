Return-Path: <linux-tip-commits+bounces-1731-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C8B937BFF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Jul 2024 20:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20E31F21705
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Jul 2024 18:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9175C146D60;
	Fri, 19 Jul 2024 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cd4oaNGr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d6JmWUwA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBC314600C;
	Fri, 19 Jul 2024 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721412375; cv=none; b=cwRNvPNF5x4fcH+N6E3Nd3NamOMXbXvq548nU4Z7Cr+Lf1wEAiVJqu2Jab/996rhIrvLwTTlS8vZiRS/Q4sZlB/RM0WmsowwtupcJimInrLlyTj1TcbTwdWJqFmUNlkPgZjwdg+JNvQdEiinqNnMREIHjHdWT5/P2vzD5TUTAM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721412375; c=relaxed/simple;
	bh=zrIWYyf/WZmLwwzAhwHufCAd4xWHpfkaVtXVupcBZYA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WAc6xa/oA62WymWu57BdGbsHAZIaxr1O6uws2vRsbMeeBhK0UvHj9oYr74BLdiJjKfBsuB/Z34SwDfzoqnOTK7iKvwiLGEPsfb6NzgsvTKl6pIH77bTg3k5QElbNfwh+t1IjRckmBPC8LDuFWO05B3fcTn6TJE2X5tKomrbzPMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cd4oaNGr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d6JmWUwA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 19 Jul 2024 18:06:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721412371;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZ7R+s7nix/A7jWblhB2XsTSd05EFGQ23qNnoc5kRDw=;
	b=cd4oaNGrBg3xVkB1rAKw6HA/8U+46nxHfXfoK9NslcyHFxSvSdfiO2ZfaGdMJBnmqMeVRr
	87GQjAbFFWdvCx/WLn1y3B9s8yvAgf5JTdZYQVlGaYGOFWxdFftT+VjorWuXJRUANBuaeV
	RGSvj1NM0zL+6hGOGKKmvLkdZMjGC68+ECb2og9RYGVU+wGk4Mc2zeo0SIYIagVl1dxBZM
	tHgA++lBISxAYA1CX6cSse0IbD6y+9QPuxBDYVrRA9xE73pqyfNWZJosl+eyxyAxxkuPc+
	pQa/TsjOyKUmczA32dUE+jeWojaheHgsbb3cXo8/veczfa8zupb4VaWrE9WeFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721412371;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZ7R+s7nix/A7jWblhB2XsTSd05EFGQ23qNnoc5kRDw=;
	b=d6JmWUwA03xb+TAEwuq9PYBzGox/iCxElR9djeY3jRuPv1LZcaKqJK+OXrgbLUK3kEJABl
	leuZ89r73uMIJSAw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] timers/migration: Spare write when nothing changed
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240716-tmigr-fixes-v4-7-757baa7803fe@linutronix.de>
References: <20240716-tmigr-fixes-v4-7-757baa7803fe@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172141237140.2215.10414624050813481047.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     7aa42d6722d3b2fe4b78e40148feaa5194b46f16
Gitweb:        https://git.kernel.org/tip/7aa42d6722d3b2fe4b78e40148feaa5194b46f16
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 16 Jul 2024 16:19:25 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 19 Jul 2024 19:58:02 +02:00

timers/migration: Spare write when nothing changed

The wakeup value is written unconditionally in tmigr_cpu_new_timer(). When
there was no new next timer expiry that needs to be propagated, then the
value that was read before is written. This is not required.

Move the write to the place where wakeup value is changed changed.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240716-tmigr-fixes-v4-7-757baa7803fe@linutronix.de

---
 kernel/time/timer_migration.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 66c3437..9b80e8a 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1215,14 +1215,13 @@ u64 tmigr_cpu_new_timer(u64 nextexp)
 		if (nextexp != tmc->cpuevt.nextevt.expires ||
 		    tmc->cpuevt.ignore) {
 			ret = tmigr_new_timer(tmc, nextexp);
+			/*
+			 * Make sure the reevaluation of timers in idle path
+			 * will not miss an event.
+			 */
+			WRITE_ONCE(tmc->wakeup, ret);
 		}
 	}
-	/*
-	 * Make sure the reevaluation of timers in idle path will not miss an
-	 * event.
-	 */
-	WRITE_ONCE(tmc->wakeup, ret);
-
 	trace_tmigr_cpu_new_timer_idle(tmc, nextexp);
 	raw_spin_unlock(&tmc->lock);
 	return ret;

