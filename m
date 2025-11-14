Return-Path: <linux-tip-commits+bounces-7340-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 84502C5D13A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 13:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB6FC34DF4E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 12:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E2214EC73;
	Fri, 14 Nov 2025 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1rVjGE8W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R8bHnd40"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB4E314D25;
	Fri, 14 Nov 2025 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122750; cv=none; b=Um05yjFkg9YIQ3DceVOq2VIgicTTi6uDned9CS0cuAWegxkZy9V3xbv1Yfk8H53mUbjvsAzJX0Nb3Lc1Aso9+VKRismw26TlsPZ2g8rxE6ihUYna89e6v7w02U4RC2Z/8urSWjbsijKefAb+xc64/2LPmh6DHgbzL1pgpl6wKHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122750; c=relaxed/simple;
	bh=0TKc0c4EsXcT986WkHDqElZI2yHOaIr2bLiifvJXkIs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PdZchKHwvjN+2J2yqg7i7Bi5mqr3VpLOGWthmFI9b0kc5tJK7vdFbLGNIIDJ0dSg58pe1P92X/hBf0Ht4l5iUfHslyvMcXFxZGB8maJ4S6pUpv9n/SSg4OmwSQOuwI/L3vuDEeG8Sau8ua5pq940nfz8TOAHWGzoBz19G8VyT1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1rVjGE8W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R8bHnd40; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 12:19:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763122747;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j9vgZxYDZJkDvjD9XXN19xZVKiNlkxzCELP0IeLtuUw=;
	b=1rVjGE8WLCc2FYNALvgNjwE4dfhFKSRkW8kx2Jmqia8zKOTHkaDqp95iJzoQd0NZ5GmUei
	X022Eq3Brc3Yevn0gTpWvSvMj9no4g4Lep3XzZRzdJIzjuCAlIU56h+SDqyAy2i9ALFhxU
	b9gppO5XVCYAPrp5+mftkykNb973Epg6PJPC2g9VNeOcOQKasqd6SwD8pE9k4n+23xJ/oC
	Me9M69h1yTR/LJWdDkMofkVxer4gCxLiTfY8x3TPqkgwR1jg0v5w/byslNoW9wChjcnTy8
	xekV+Z57U6LAbCSsADHK1YU+z7qMi27qGE+9UBf1jIVwG2zwrCynp58icqLtQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763122747;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j9vgZxYDZJkDvjD9XXN19xZVKiNlkxzCELP0IeLtuUw=;
	b=R8bHnd40nsmiR15fzHyiEPZbO6JctIzJIp+DzLBv1u9/2FtLT9FM22V89B/+hzkFfgbNdJ
	GVdmScrWXDwLqQCQ==
From: "tip-bot2 for Phil Auld" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Increase sched_tick_remote timeout
Cc: Frederic Weisbecker <frederic@kernel.org>, Phil Auld <pauld@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250911161300.437944-1-pauld@redhat.com>
References: <20250911161300.437944-1-pauld@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176312274606.498.4882667650358877046.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2616d12247639da40339757adc08c822147aa993
Gitweb:        https://git.kernel.org/tip/2616d12247639da40339757adc08c822147=
aa993
Author:        Phil Auld <pauld@redhat.com>
AuthorDate:    Thu, 11 Sep 2025 12:13:00 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Nov 2025 13:03:06 +01:00

sched: Increase sched_tick_remote timeout

Increase the sched_tick_remote WARN_ON timeout to remove false
positives due to temporarily busy HK cpus. The suggestion
was 30 seconds to catch really stuck remote tick processing
but not trigger it too easily.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://patch.msgid.link/20250911161300.437944-1-pauld@redhat.com
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 68f19aa..699db3f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5619,7 +5619,7 @@ static void sched_tick_remote(struct work_struct *work)
 				 * reasonable amount of time.
 				 */
 				u64 delta =3D rq_clock_task(rq) - curr->se.exec_start;
-				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
+				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 30);
 			}
 			curr->sched_class->task_tick(rq, curr, 0);
=20

