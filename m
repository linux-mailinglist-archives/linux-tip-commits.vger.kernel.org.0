Return-Path: <linux-tip-commits+bounces-5702-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833E7ABF414
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D76937B115D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE94E26FA62;
	Wed, 21 May 2025 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E98arfjj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e6LJPA0O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF17426E17B;
	Wed, 21 May 2025 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829768; cv=none; b=jpWtsqmw+IDNncyAKmJMopQEYyQ2/IloQjCc4GKagXDBWh9bS1LAUlT1CY8iDOzhdlHIpRMmHSjpzIrAAzx05Jf0S425WOBWA2P7ReWSlcA+K1CAKO3obSNZhWlXPos3jMqt6SwhUmmXXcP2rAVYi/EcR3AYNR4GFZR0FVuRipo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829768; c=relaxed/simple;
	bh=PHpADjP1ZA+iiePdUyP2jHxVyMhTWpUD+YMOhbJHepw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KseT9yR28eBt8oHgxvEVRZXlfCeqMdY5CT9XdUMMTZpL2i8ugepYHpGY3p79kfjTcAax3ucV7ooKhX389cLT6avYu4MXHRdjm9+6s4AM1EUTdqK2fcxrh+I/D6I5AGICCSTvO4LsV8YYZbDfNzONi8Menymx3z+YhWesEGE1Y4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E98arfjj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e6LJPA0O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:16:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829764;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgPGF9SZyon43Q52HiOX7zYHtnqZHGpGsz817rSfJeU=;
	b=E98arfjjCN7bBXAIe9b9hBxgXu+4Yz1n9lFG2DS4wmHv2pLI7/zpbhhB5jV+3hpsphOd6U
	07VC2d287OGEXgFzlhUlaWi6RTm6rR57nBhkwa8jDgjYn7W0vbrRuZWtCZROPKp/8XAYPP
	xz6nd/IHzFQ1RrJhjbJlAAbJamf0r1FpL8SI+jKK4sdVHF7HT9h1geH7FCkvQ8C8J6yHUj
	Q8wBz2wrTu7CkeTQmeEG5KzIu4HEhen7mHDwnhvuKl0rd1puHZZMaQDthSDzY5rPpuvfvA
	bBshYgOoFFxRJ4Naoami2YaspmST1tRqTL7h1rtfWz1u3sJSnGWL5vZnKKiOGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829764;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgPGF9SZyon43Q52HiOX7zYHtnqZHGpGsz817rSfJeU=;
	b=e6LJPA0OGF+wcLGHTzk0JsfqVeSDDqXEqvp8H855TTGh/bbQ0YPor0GNKtUQmEHSM5v7m5
	KsG+ieJWh7TZKEBg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Only dump the throttle log for the leader
Cc: Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250520181644.2673067-3-kan.liang@linux.intel.com>
References: <20250520181644.2673067-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782976322.406.7197842239378864400.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e800ac51202f053018f3d6acb1819ecec4d75a2c
Gitweb:        https://git.kernel.org/tip/e800ac51202f053018f3d6acb1819ecec4d75a2c
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 20 May 2025 11:16:30 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:43 +02:00

perf: Only dump the throttle log for the leader

The PERF_RECORD_THROTTLE records are dumped for all throttled events.
It's not necessary for group events, which are throttled altogether.

Optimize it by only dump the throttle log for the leader.

The sample right after the THROTTLE record must be generated by the
actual target event. It is good enough for the perf tool to locate the
actual target event.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20250520181644.2673067-3-kan.liang@linux.intel.com
---
 kernel/events/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8327ab0..f34c99f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2650,14 +2650,16 @@ static void perf_event_unthrottle(struct perf_event *event, bool start)
 	event->hw.interrupts = 0;
 	if (start)
 		event->pmu->start(event, 0);
-	perf_log_throttle(event, 1);
+	if (event == event->group_leader)
+		perf_log_throttle(event, 1);
 }
 
 static void perf_event_throttle(struct perf_event *event)
 {
 	event->pmu->stop(event, 0);
 	event->hw.interrupts = MAX_INTERRUPTS;
-	perf_log_throttle(event, 0);
+	if (event == event->group_leader)
+		perf_log_throttle(event, 0);
 }
 
 static void perf_event_unthrottle_group(struct perf_event *event, bool skip_start_event)

