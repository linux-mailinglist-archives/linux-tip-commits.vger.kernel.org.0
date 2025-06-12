Return-Path: <linux-tip-commits+bounces-5778-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E81AD7CA9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Jun 2025 22:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AECCE167BB2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Jun 2025 20:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20042D543C;
	Thu, 12 Jun 2025 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PLQn4hk7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ilAjJBPX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9D81D79A5;
	Thu, 12 Jun 2025 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749761398; cv=none; b=CBm2uWH5yJZRd1ThBgcCeOC2ixWVuOHI4x8hTDK9RfnUi7JN8aKEnRPDF7v1KzylWcQSU5JNPtq8vHy2X94njYZdYr8NXQgIC9QIuSS/NUEc2ZAIyWSRFdoKeOxnU1oOAAb9gUcnoD1+Ke0CsiwQUDFxIIOn3qpvxkgBTyGuQf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749761398; c=relaxed/simple;
	bh=O2p1MhzN+ZJJmQ1ZrQsXhk3wl3bpSQipC0HvCC69Bh0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qurfNtPLWycDaragvYYOjSsq0iiCjzoco+ZeMj92S8QcylLo6o05aSY/ME4JPuOtRxm/JxwisWpVdsR7mVoPaa1exI9/4M9s4XKE8dK6i+KMejoNAqL9x4ceaKtMp+Mof1Sr65+t6hYlCkXONorBEvWkpUqye90Xh0tVYqSbO7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PLQn4hk7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ilAjJBPX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Jun 2025 20:49:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749761394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2rMfTiI7Yfuq9iGAtuQSu1rxzkU/r5mn+u4g2Hm1UiU=;
	b=PLQn4hk7xr+a6ZatUoyXuKqHgYE9hkI1XuO4jeuSt1J1IcAWnIVHKFxpD9BtsHC2ysdsL/
	UfK0yqddOic9yO95vPFmLkF8qAEdzUXhPs6YqXzzd1m+vj0YKJwZbtSlLzTzpT8wOICwQ7
	ktWucPia401CP5fcC4YML3EnHCDMNmzTd+LQRWNU3/OVAfqbtDWPMEy5KgQ4JaBp6EZiIE
	hqFFAXmtHUo2Vu8Ocw2AIAOU83tO0HqHxQJUYKTzGJFQn7BpqvT3phzF4RtEBg42lMEkcF
	3UNgqj8M0i81DaKmZNEP0DDsD2ZLvJDnSUHgYDitubXFlrgmpAvtgDYGd3SypA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749761394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2rMfTiI7Yfuq9iGAtuQSu1rxzkU/r5mn+u4g2Hm1UiU=;
	b=ilAjJBPXICoTkVX++bcnkrKBAwftGdDXQ0wAVcPQlSPpeiU7Xkcj6Of/A5tiAfBWJgH6zk
	HOc6FLCLZ+zdE5Ag==
From: "tip-bot2 for Petr Tesarik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timers/migration: Clean up the loop in tmigr_quick_check()
Cc: Petr Tesarik <ptesarik@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250606124818.455560-1-ptesarik@suse.com>
References: <20250606124818.455560-1-ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174976139364.406.7611487381768978220.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ff56a3e2a8613e8524f40ef2efa2c0169659e99e
Gitweb:        https://git.kernel.org/tip/ff56a3e2a8613e8524f40ef2efa2c0169659e99e
Author:        Petr Tesarik <ptesarik@suse.com>
AuthorDate:    Fri, 06 Jun 2025 14:48:18 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 12 Jun 2025 21:03:45 +02:00

timers/migration: Clean up the loop in tmigr_quick_check()

Make the logic easier to follow:

  - Remove the final return statement, which is never reached, and move the
    actual walk-terminating return statement out of the do-while loop.

  - Remove the else-clause to reduce indentation. If a non-lonely group is
    encountered during the walk, the loop is immediately terminated with a
    return statement anyway; no need for an else.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250606124818.455560-1-ptesarik@suse.com

---
 kernel/time/timer_migration.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 2f63308..c0c54dc 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1405,23 +1405,20 @@ u64 tmigr_quick_check(u64 nextevt)
 		return KTIME_MAX;
 
 	do {
-		if (!tmigr_check_lonely(group)) {
+		if (!tmigr_check_lonely(group))
 			return KTIME_MAX;
-		} else {
-			/*
-			 * Since current CPU is active, events may not be sorted
-			 * from bottom to the top because the CPU's event is ignored
-			 * up to the top and its sibling's events not propagated upwards.
-			 * Thus keep track of the lowest observed expiry.
-			 */
-			nextevt = min_t(u64, nextevt, READ_ONCE(group->next_expiry));
-			if (!group->parent)
-				return nextevt;
-		}
+
+		/*
+		 * Since current CPU is active, events may not be sorted
+		 * from bottom to the top because the CPU's event is ignored
+		 * up to the top and its sibling's events not propagated upwards.
+		 * Thus keep track of the lowest observed expiry.
+		 */
+		nextevt = min_t(u64, nextevt, READ_ONCE(group->next_expiry));
 		group = group->parent;
 	} while (group);
 
-	return KTIME_MAX;
+	return nextevt;
 }
 
 /*

