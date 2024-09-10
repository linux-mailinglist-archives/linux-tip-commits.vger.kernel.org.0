Return-Path: <linux-tip-commits+bounces-2274-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F74972BC0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 10:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273851C21788
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 08:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A295A19049D;
	Tue, 10 Sep 2024 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xopJETlJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+ZqYva5W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEE018FDBD;
	Tue, 10 Sep 2024 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955772; cv=none; b=O6yjzD1G1XnIypjyuTKj0ZO4o9psxZI+mFC5zBbTZidY28GWuf8bHwy/Ekupp4cHZCqnOCWs8Ob6DSNIPrY2Ef0mx4plO94PBQk46PDbArDdp4Padx/Lr8638u936Cxa2aBxKXqPmeyI9loqQ3I1cw8xRhpM1ukILHM+KiP+rjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955772; c=relaxed/simple;
	bh=GREvofTuhvGWwyuMk1a115wl2G09hwxMOpEazKAlFW0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r24D5NUcxgr8xDBBqblRQjkgzmueHn9OilmPZ15aFNUXTHOAxwqnvhU3JM/LoF8h0SFOD7YEzU4+Z9LOzldIcAHZs1uyQ76WOCbIaGK4cWL6ofimHMWihzo8HR9foJkbFeAUgRDXzncGttBe+U1wanK8ejyycBOiCiP7ECHBJTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xopJETlJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+ZqYva5W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Sep 2024 08:09:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725955762;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JS95HelS1121hR1+IQuGypcbi/YsdKM4mJawd72veJI=;
	b=xopJETlJ33MWKKHUoFZwgk1B3+gHelrKYRjlMTbvRbF6bih/4tqNk9tlt/0nyBEUldORvV
	oghUN4x70IqwtmjPw0ltrqwcGDMmc3DVxS3xAMtQ+IvfGehxK1SaJDSLIuM7wbQ2wgFprN
	Y2pnpTNO/3obx48VlAnoQBz29hfvXXvgE3F4YJYHdjtR90UiSv6HRu3tuoDSlNc1B4T33I
	ycjrvMrAta4QEZBz8le0WdLIyRbtEBn6B6dJCiqYGnKfKw/716yqKCRjwMTKY7n/hP4k+x
	qQsx8D27FavBZzjq42CmmROwtuSKvXLrAzJaHl7ydjam96PuUQ4qaRg7arp+Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725955762;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JS95HelS1121hR1+IQuGypcbi/YsdKM4mJawd72veJI=;
	b=+ZqYva5WboKdZNTR9SFAu/7HZvcdFDEjD4/3G/tHGAH0zaxYtG50XPx1cnEEyAo8p0Zikd
	tObmX8naRN0H1jDw==
From: "tip-bot2 for Christian Loehle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Convert schedtool example to chrt
Cc: Christian Loehle <christian.loehle@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240813144348.1180344-2-christian.loehle@arm.com>
References: <20240813144348.1180344-2-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172595576198.2215.14641067488346497218.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e031b586326f7d3d6be70dd1d69ed3045d9506ca
Gitweb:        https://git.kernel.org/tip/e031b586326f7d3d6be70dd1d69ed3045d9506ca
Author:        Christian Loehle <christian.loehle@arm.com>
AuthorDate:    Tue, 13 Aug 2024 15:43:45 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Sep 2024 09:51:16 +02:00

sched/deadline: Convert schedtool example to chrt

chrt has SCHED_DEADLINE support so convert the example instead of
relying on a schedtool fork. While at it fix the wrong mentioning
of microseconds, it was nanoseconds for both schedtool and chrt.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/r/20240813144348.1180344-2-christian.loehle@arm.com
---
 Documentation/scheduler/sched-deadline.rst | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/scheduler/sched-deadline.rst b/Documentation/scheduler/sched-deadline.rst
index 9fe4846..22838ed 100644
--- a/Documentation/scheduler/sched-deadline.rst
+++ b/Documentation/scheduler/sched-deadline.rst
@@ -749,21 +749,19 @@ Appendix A. Test suite
  of the command line options. Please refer to rt-app documentation for more
  details (`<rt-app-sources>/doc/*.json`).
 
- The second testing application is a modification of schedtool, called
- schedtool-dl, which can be used to setup SCHED_DEADLINE parameters for a
- certain pid/application. schedtool-dl is available at:
- https://github.com/scheduler-tools/schedtool-dl.git.
+ The second testing application is done using chrt which has support
+ for SCHED_DEADLINE.
 
  The usage is straightforward::
 
-  # schedtool -E -t 10000000:100000000 -e ./my_cpuhog_app
+  # chrt -d -T 10000000 -D 100000000 0 ./my_cpuhog_app
 
  With this, my_cpuhog_app is put to run inside a SCHED_DEADLINE reservation
- of 10ms every 100ms (note that parameters are expressed in microseconds).
- You can also use schedtool to create a reservation for an already running
+ of 10ms every 100ms (note that parameters are expressed in nanoseconds).
+ You can also use chrt to create a reservation for an already running
  application, given that you know its pid::
 
-  # schedtool -E -t 10000000:100000000 my_app_pid
+  # chrt -d -T 10000000 -D 100000000 -p 0 my_app_pid
 
 Appendix B. Minimal main()
 ==========================

