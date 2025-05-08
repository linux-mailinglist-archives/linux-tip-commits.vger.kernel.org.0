Return-Path: <linux-tip-commits+bounces-5508-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1BFAB041D
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 21:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB7D9E8000
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 19:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D897028B3FF;
	Thu,  8 May 2025 19:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bhm8eIYs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bpay86Xh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DDD28A1D7;
	Thu,  8 May 2025 19:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734120; cv=none; b=K2IDgmDIiA3bT+XpXo8aBjWqQBiIjLsHBnWwux+aQdcZi205BjOByNnota6RY7SuOA81t2/i3/dhNrf+tMcc2v+cu4OpMEOYuUmka8grcg3Qb/Jie1w3h5RAlau4oFlNPw6aPEZhcywRmNlYTwQvXfhUYZhHhWBI5wU92hBhUa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734120; c=relaxed/simple;
	bh=27Nf70DNfEJuw12FAZQ96YFnyDdogWkaXzF1a3qYhi0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tG2P850ZDnCV/t8zcQOFMLPje+yXnKDryaAAOAAEvG5awmXt7v5SsY7Ss9yb9GX4T2JSwgj7K9Gfxa/2/ntrz4HBXnKBXAfzQANDpkGnE5IIdLwk4qQyNa6aQx8TjPC1LZn53vAy7gBT/LDPeNYggVHyzJ5VtJBzridkmtQ0deo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bhm8eIYs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bpay86Xh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 19:55:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746734117;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iq57mVoWwRm1g+xzYTXi+KMRJ0NnG3xGZjW+7azcILs=;
	b=Bhm8eIYs3WEWi2sxgXFqePgvoHRQbEWfaazKILvtjhmv33/FhepISVuOb8nvutILKhxZb/
	ghwBVBLnqzoKNxliV52ZhD0np9rfdPDkLcK/BZ77zRoRTmIc07mTX/s198lWCnJhoHk3p1
	yd4G/TaRyns4DEMQhtolDIjE+Tzk8brB8JnzpJTWaBGowKBTvr6A+AGV0lN56SPXSdh8tK
	7T2qtoQTjW0P2X3bqj04hm5PYOrXIzd5AMqAzQuZljzcjzYW+cWDEB6pYy8auCmVMI5Uqv
	qpN+0+a81euiGTonnueReNB8yhdDy2uEeX8XVa9cKyRp4oIoBkIWWdTcV7vemA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746734117;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iq57mVoWwRm1g+xzYTXi+KMRJ0NnG3xGZjW+7azcILs=;
	b=bpay86XhpTlcCGLp4Uj1WbdF/do6uWKPfrVOV8h7b3vCrJFxH0odugXrQGIScqwRycIZZ+
	TW+fQFvDgA/r4/Ag==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Fix confusing aux iteration
Cc: Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250424161128.29176-5-frederic@kernel.org>
References: <20250424161128.29176-5-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174673411578.406.5132629507145379440.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     881097c0549f3818f5aa31af8ccb49213bd99bed
Gitweb:        https://git.kernel.org/tip/881097c0549f3818f5aa31af8ccb49213bd99bed
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 24 Apr 2025 18:11:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 08 May 2025 21:50:19 +02:00

perf: Fix confusing aux iteration

While an event tears down all links to it as an aux, the iteration
happens on the event's group leader instead of the group itself.

If the event is a group leader, it has no effect because the event is
also its own group leader. But otherwise there would be a risk to detach
all the siblings events from the wrong group leader.

It just happens to work because each sibling's aux link is tested
against the right event before proceeding. Also the ctx lock is the same
for the events and their group leader so the iteration is safe.

Yet the iteration is confusing. Clarify the actual intent.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250424161128.29176-5-frederic@kernel.org
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e0ca4a8..b846107 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2171,7 +2171,7 @@ static void perf_put_aux_event(struct perf_event *event)
 	 * If the event is an aux_event, tear down all links to
 	 * it from other events.
 	 */
-	for_each_sibling_event(iter, event->group_leader) {
+	for_each_sibling_event(iter, event) {
 		if (iter->aux_event != event)
 			continue;
 

