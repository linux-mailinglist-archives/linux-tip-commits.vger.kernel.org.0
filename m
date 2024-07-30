Return-Path: <linux-tip-commits+bounces-1874-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BABA941C79
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541A61C20FE6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D2C18E053;
	Tue, 30 Jul 2024 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mo28yrKV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eJlnmLff"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FEA18C919;
	Tue, 30 Jul 2024 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359194; cv=none; b=PPOEbkqDZnuRSib/TT+wYJGr0SjO2nh1ITBarAz6I3fx4FxxNSUqEDMdij/caIBIsWt4ClqC4IOGKHI57q7pdVNcb7wB2MdECrXnBXnGRB562HkJ78WkJ4t8nIByjAmvkLzVmOB/tqn25WVxc+k7kUk8jn9spa9SLqZ7PkZNDS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359194; c=relaxed/simple;
	bh=nl/ApfKOwk8vf/G6VkGcu6rZJTqDo2nE9QdESuXubUc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=fCFdPAlgVt7u+t8+H8pKGuTy/rY2scHLMk5GExRnu4irU2V7zhlWNSgL0X7rtbwPwfDlhJvHU6eT6PzrWj6YG3+fH8HxmPJteN3PAWXVRQKdkFKiwslGd1a1fTo5A8HpiHfh2Hka9kCIVYt8nssJQ4GBOOGZYienSoOcg27KLH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mo28yrKV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eJlnmLff; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359191;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6w/brMdQ7mY2Gzze8vZs7X6SN3HHStKtLPFnfNnTLss=;
	b=Mo28yrKVf7MfuPyMr/ZMjXLH2NJOADx2Y1RRVjJ4HttlMrFB0cDgZvHQ833zKE8IGqyNWS
	h8/fP3cH/b7tBUaeLlY/wm73Ou2nkQ8KGXlr3ZqnCtpN/nKLnSRJvYpMmN9M5QMuru5Wrq
	0RbdJ/bHZL6bV3VukcH7UYil/emIi4qskpiZhMTD3pdzglyS1Xn43b/5pDKY1B0HoLhHJ9
	zkf7PK+CNeIU7JWiEia6Y4WlmxLtBrHVsGPpnKBmoR4xTbFX80mP8qDm/anYcJXgdANrey
	qIvw3JdAD+apqTyd28nW6PPTnjpMw08FLOxIMsvSgQqPtXw9qLJHu2FIdg2WDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359191;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6w/brMdQ7mY2Gzze8vZs7X6SN3HHStKtLPFnfNnTLss=;
	b=eJlnmLff31mpDP8d+GyB3LSyyLcBlzmH2wVVnqrNIJYCJ401mPvWTnTGyB78s28Z5fU4Q8
	KdF0wO86OIqQW9BA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Remove incorrect comment in
 posix_cpu_timer_set()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172235919066.2215.12691973230761298047.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     286bfaccea76e0bd3805ac6e77c8ec4a18ecb3fe
Gitweb:        https://git.kernel.org/tip/286bfaccea76e0bd3805ac6e77c8ec4a18ecb3fe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 18:42:23 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:34 +02:00

posix-cpu-timers: Remove incorrect comment in posix_cpu_timer_set()

A leftover from historical code which describes fiction.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/posix-cpu-timers.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index b1a9a2f..eb28150 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -689,13 +689,8 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 			__posix_cpu_timer_get(timer, old, now);
 	}
 
+	/* Retry if the timer expiry is running concurrently */
 	if (unlikely(ret)) {
-		/*
-		 * We are colliding with the timer actually firing.
-		 * Punt after filling in the timer's old value, and
-		 * disable this firing since we are already reporting
-		 * it as an overrun (thanks to bump_cpu_timer above).
-		 */
 		unlock_task_sighand(p, &flags);
 		goto out;
 	}

