Return-Path: <linux-tip-commits+bounces-1346-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BEF8FD138
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Jun 2024 16:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C7D1F252ED
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Jun 2024 14:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D832837A;
	Wed,  5 Jun 2024 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nM/ELYqC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9JF+QV1y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33FA262BE;
	Wed,  5 Jun 2024 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599277; cv=none; b=tP5MwQh/kk+DNGS8I4U6QkiIfUnZqu6sqB5lC3OkvCy8Bei4wmI3WS5KyeEsCm7YvJSH2Tec2P/bFul393kjozpHOD6LxkyK/FebB5iJ+rjgqCzDhe3t8Tca06pPPMm+isSGCE7HXa6thUOtaaFsr+PGHvf5W2/bJpPYFrQqEMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599277; c=relaxed/simple;
	bh=vEAm8XW4A4JCAVr1Njf+fvAe/H3oq73qrPOokg531pE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FPcm2pGO98UX4WhJTWgB4fWYd9eqRZ2TNi0zTh+s/7sN/6YSqhLb/OEj7gxGjlCR5PFTups08v8Fs0nP0UbgdhsS/MtpVGSsMS46Q+sJgx/qeDpoqB77ycitB21OIDm2NHZf78FGvGIp6m2PWAEzx06EYguv0/SeRSx0W6EVOOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nM/ELYqC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9JF+QV1y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Jun 2024 14:54:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717599273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nabDAdkeXLpiGcP4YJdk7saSMZT0JJB2s6uiC+hHzDE=;
	b=nM/ELYqCgJQRkG5V+oEE4toaC0xcVofpE8NwzW+fKhx/XT9w5+ZPQNKgUulLKzjbj23++2
	pNhh91OpmY0ktFQJWK8syhQVQemLec1IEAIOfwFLAwepjtuWjGi8+Q0cmrAyNNEh2c+vqq
	MHYkS2iSc2/SMJjY9rF1ests9jvrmTsqF2Br/bLUhORrrKG3PnYyd0ExDiF8dsxWxA9tGk
	imHjkkzM+oZgm5esoO3JWlQD3/JQnXxuOFV7Ok3OzsQ+rXYsjviJrYC/alGElLClY29ihu
	U3mR+5Aoaqc/Pr7J2TXas0bq2Jqz/skZ0isVtSVXnXt7BfvHZrH7ybnmO6ZDtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717599273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nabDAdkeXLpiGcP4YJdk7saSMZT0JJB2s6uiC+hHzDE=;
	b=9JF+QV1y/hu+ezbU7P5YrNthKDO8LeiRPnDZXIQxKlJhKMYGXgza3Gj0OWq0tpYJLboQZK
	u7jAW75bs0bqPcAQ==
From: "tip-bot2 for Christian Loehle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] idle: Remove stale RCU comment
Cc: Christian Loehle <christian.loehle@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <5b936388-47df-4050-9229-6617a6c2bba5@arm.com>
References: <5b936388-47df-4050-9229-6617a6c2bba5@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171759927337.10875.6268868204666848368.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     764d5fcc2a58d789629f6800451975fc93f25822
Gitweb:        https://git.kernel.org/tip/764d5fcc2a58d789629f6800451975fc93f25822
Author:        Christian Loehle <christian.loehle@arm.com>
AuthorDate:    Mon, 03 Jun 2024 16:30:39 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 05 Jun 2024 15:52:35 +02:00

idle: Remove stale RCU comment

The call of rcu_idle_enter() from within cpuidle_idle_call() was
removed in commit 1098582a0f6c ("sched,idle,rcu: Push rcu_idle deeper
into the idle path") which makes the comment out of place.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/5b936388-47df-4050-9229-6617a6c2bba5@arm.com
---
 kernel/sched/idle.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 770e698..6e78d07 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -179,12 +179,6 @@ static void cpuidle_idle_call(void)
 		return;
 	}
 
-	/*
-	 * The RCU framework needs to be told that we are entering an idle
-	 * section, so no more RCU read side critical sections and one more
-	 * step to the grace period
-	 */
-
 	if (cpuidle_not_available(drv, dev)) {
 		tick_nohz_idle_stop_tick();
 

