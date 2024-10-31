Return-Path: <linux-tip-commits+bounces-2667-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A969B77FA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 10:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58F2DB23B5F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 09:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65AF19939E;
	Thu, 31 Oct 2024 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QheFsZrx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="imReOw30"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49F6198E86;
	Thu, 31 Oct 2024 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368279; cv=none; b=rSUsp/uS4Wc9qLdhHh02vWXtLa412se9RwD6zZAr0oCHPi9w8EMtxLq+I1AZK0qgzsPe5CqaTPYzJSJ9Rlf3K8appFo3+Vl4COspmke3DnJ7t1gXyheYmoyeyLA/1w2lwO4JWjpl7seRLp2g/Q5u7oeG7EOjF2kfAAU3J1lS+o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368279; c=relaxed/simple;
	bh=o6TgdGdcofNyYXJqL2gjmH0LxZIslvOglpCJx2FNxTs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XODnSpFUMR2Ekff1QRp2jEF2ySEEXC2lPRsjWvuAjViLge7TSBcK0oywSnQKmSQSi/x3VMVTY8k/2H7VsvqUe0eVjiEGtz8ak+U3x0O398xkIP5vf3VdHqvzp25lu9RI5XvsOv6v1jEU/aPrhhhSvCc52/sGXFeA9+1KejToaqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QheFsZrx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=imReOw30; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 09:51:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730368275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0okUuG6s/OCuM+/KqHhz/zE1ge/gkC9aNlf2QTzPws=;
	b=QheFsZrxoPjIH4Sl0eaXpwhKXD2AeiRxaHmb0k220ZOf8s+UCl4B/t+J8/sJ//Mzda8G/b
	x6X8XuXkGxy3HzZQAJrIgJP1G/3rvRQmefsawYmnweSCgdoHQ3KWXNMgeLEuxGZDGKX+vr
	nV8ds6QhhhrgfpWMfl1weEEKB/VV4YICAcT/BTNkj8a5+SbHO8KoBo0mvUaK8cxaIsk35l
	EwLqi9o7M6+iTzPXBmHb+iS92awd23TYmNw76Csh0VjsFHrcPPM+n5A7jv+tGpfuBV1E17
	83SuW61Zp946viFq1SkYwpVS+TAC4WeQ3Xg/4gaWciW6t+RwfBePomjzHvZoOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730368275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0okUuG6s/OCuM+/KqHhz/zE1ge/gkC9aNlf2QTzPws=;
	b=imReOw30jc7eMLasbzbNJPyA4kx7ZfX/fYcZ81GGketYyel+x4Z8RKm+r4qWYJdIfwNfDG
	HaS7GtxTYE9DJ9DA==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_global_timer: Remove
 clockevents shutdown call on offlining
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241029125451.54574-7-frederic@kernel.org>
References: <20241029125451.54574-7-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173036827513.3137.13428186509149928499.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     15b810e0496eba62ca5a70d1545d1e4757c0a1ee
Gitweb:        https://git.kernel.org/tip/15b810e0496eba62ca5a70d1545d1e4757c0a1ee
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 29 Oct 2024 13:54:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 31 Oct 2024 10:41:42 +01:00

clocksource/drivers/arm_global_timer: Remove clockevents shutdown call on offlining

The clockevents core already detached and unregistered it at this stage.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241029125451.54574-7-frederic@kernel.org

---
 drivers/clocksource/arm_global_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index a05cfaa..2d86bbc 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -195,7 +195,6 @@ static int gt_dying_cpu(unsigned int cpu)
 {
 	struct clock_event_device *clk = this_cpu_ptr(gt_evt);
 
-	gt_clockevent_shutdown(clk);
 	disable_percpu_irq(clk->irq);
 	return 0;
 }

