Return-Path: <linux-tip-commits+bounces-6670-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E14B7CFAC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 14:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE06E487BBE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 11:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8A82F5A2A;
	Wed, 17 Sep 2025 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OAJzNkEC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ASGw3wUD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8F4BA45;
	Wed, 17 Sep 2025 11:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758109132; cv=none; b=jGIFkwaKcGRZxLeO9ItkCb9pbNgumaiv4PCk9/VSX36VSJ403mbTZtcVjl2YaJ8cE0Uafa6dcge77ytp7cueXxhkk+k2QAzJRX1vH6Jq4929DAV3duxoCaR3l4d19EtFhcPiKx+P1UZ2CRSCEHqgKYFtL2X74Vbt82g/v+BFDW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758109132; c=relaxed/simple;
	bh=Fu294uvDHkvaxx9vtTFd3tnCDy6Uee/EKf+YTIELVlw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=oZWhSAm5wuJv2LjcTsYoY0KaV654iObYjzOZP/vpyO8TQFw8fThGxlrDT53ednyXltmYDuHsFMDAVDE98/fKsmdBY2/JaydTpkOQ0TsWn4TqgpRFzHmS92XcTjBTQW4ZcveI/jXhTHu9hAGVwXSHBMB3EIjvc2K/sRr3Ui6kocw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OAJzNkEC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ASGw3wUD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Sep 2025 11:38:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758109128;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=+RsCEHSSq0tvUC9rutGfPfSrwIgdcINQECQvTyB3HeA=;
	b=OAJzNkEChMKviWKo2yxY80rX3YUr/9FnsagXr+xi4n+/MV+kw0tSuvNzvoiH7Br0sgAjvD
	5x+itlLDW6O7lnzvOgKhtaAx9EVtKZ1wQNcLkuHjKNl/wHsNppG3izfL92gMiwgxjnPDAD
	r3+8Cl3JmPHzwv7Ij8attrzjDtVB7GYDoBLh9o1Mt66u5LLF0bhsnSSbDpR7VEpy3x6+l8
	rh9bbktZetzZIqydVYt13StSKLyVUw36ssg2RA+XBgExCXILx3HWYXaP4EK+tEu2Wr0Qrk
	xQ+qa0THyHaNs8PzemZHpGzuA7h5Kg4bYCH6DcU4UjUXHSLOJr+gdatLlY0okQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758109128;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=+RsCEHSSq0tvUC9rutGfPfSrwIgdcINQECQvTyB3HeA=;
	b=ASGw3wUDIxEvC9VrjxGR/032dOMDTbpSim6DOgEyeBHDQkreLnD937h5vk/mRsliVPS5au
	X5S2A5Pac9QDXeDg==
From: "tip-bot2 for Fernand Sieber" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Forfeit vruntime on yield()
Cc: Fernand Sieber <sieberf@amazon.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175810912711.709179.3678143545870319102.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     78f8764d34c0a1912ce209bb2a428a94d062707f
Gitweb:        https://git.kernel.org/tip/78f8764d34c0a1912ce209bb2a428a94d06=
2707f
Author:        Fernand Sieber <sieberf@amazon.com>
AuthorDate:    Tue, 16 Sep 2025 16:02:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 16 Sep 2025 16:44:12 +02:00

sched/fair: Forfeit vruntime on yield()

If a task yields, the scheduler may decide to pick it again. The task in
turn may decide to yield immediately or shortly after, leading to a tight
loop of yields.

If there's another runnable task as this point, the deadline will be
increased by the slice at each loop. This can cause the deadline to runaway
pretty quickly, and subsequent elevated run delays later on as the task
doesn't get picked again. The reason the scheduler can pick the same task
again and again despite its deadline increasing is because it may be the
only eligible task at that point.

Fix this by making the task forfeiting its remaining vruntime and pushing
the deadline one slice ahead. This implements yield behavior more
authentically.

Fixes: 147f3efaa24182 ("sched/fair: Implement an EEVDF-like scheduling  polic=
y")
Signed-off-by: Fernand Sieber <sieberf@amazon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250401123622.584018-1-sieberf@amazon.com
Link: https://lore.kernel.org/r/20250911095113.203439-1-sieberf@amazon.com
---
 kernel/sched/fair.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a05..c4d91e8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8921,6 +8921,7 @@ static void yield_task_fair(struct rq *rq)
 	 */
 	rq_clock_skip_update(rq);
=20
+	se->vruntime =3D se->deadline;
 	se->deadline +=3D calc_delta_fair(se->slice, se);
 }
=20

