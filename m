Return-Path: <linux-tip-commits+bounces-2462-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C929399FB8D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 00:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70832B21F02
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 22:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FA91FC7EC;
	Tue, 15 Oct 2024 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pfOiscLE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M0bAgYLc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C721F80A4;
	Tue, 15 Oct 2024 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032089; cv=none; b=etZw9cKgnsK1duqrWrg30ovyIG+eDLN9wlXoub5HuT2bdPp0WUrq690yT0jjFTOOgqNzaf3oflbSaTaxQczraUUfsvI6olu+0b/xCY8ycS4pUxLrN7QZ83gKRJm7jRpmHn0LkfKzCoWkccl2T/bbSRhjXosk6jMcgFYcLpdchIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032089; c=relaxed/simple;
	bh=LVTEQwkhT8GJ/0nUaWaHRod664gnd0hJabwO8lMfxZI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hsGVi1acS+yKtFIKIK3aNb/q96ndszVCBzMaQ9Mhp/d+7H+46FqzFWKkDLtkS5FlH8Ir8w3vcWgzddXoKV3xGB2Z9b5sK9DXYiUk0BpPM7gD8EjQBPh7Mh1mxcGF2ODjcyi2+u/1Jt8wRuqr7IeqngSlWbknQx1LUvcmWfZqFQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pfOiscLE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M0bAgYLc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 22:41:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729032086;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kr0TV34iVHmqtgVEl4sD0qg6Z+1hFqxz5vWFlkqByNc=;
	b=pfOiscLEOyVSFLQBZs3WCZhCGN0JKa5M4H6QOJQbV+YbOk5bD+c6uSVJbEgaTQO4659oQ6
	A03IyJokh7E5e0frcUXb23cI0T1GAbIcN1EHAwaZp2+tDOA53+wM6+D5Y8QxrqcNuGmLiM
	BVkAL52bdSNPB06WBV1jkwUj2LbHdBHZiuZTI+5oF+4e3944oNdX023CnCsY3iWi7Z4kro
	hbyMJfrsol0Wqq8ExK2jzMZiqJZ3hIm4+jRBzNLa4REHmb/xTHhZ8pzU+b8bLdoJ3jrhZF
	F1XYryWLcw+CSbyLssP99UGY5Z12vR8UTa1Ts/QCbzUYuLXYQqFu/gplTVnbTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729032086;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kr0TV34iVHmqtgVEl4sD0qg6Z+1hFqxz5vWFlkqByNc=;
	b=M0bAgYLcmt9xWkxsA268Xjl4cqRQBNtDT6QdqTPvFgf5ZYAEXaNqHNWwI9BwUCAoCdbBKu
	+/y/FJOh+1D9m/Bw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timers: Rename usleep_idle_range() to usleep_range_idle()
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, SeongJae Park <sj@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-4-dc8b907cb62f@linutronix.de>
References:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-4-dc8b907cb62f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172903208555.1442.9920857443473714899.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     102f085d84607462234ac60f6027973b45a9bde2
Gitweb:        https://git.kernel.org/tip/102f085d84607462234ac60f6027973b45a9bde2
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 14 Oct 2024 10:22:21 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 00:36:46 +02:00

timers: Rename usleep_idle_range() to usleep_range_idle()

usleep_idle_range() is a variant of usleep_range(). Both are using
usleep_range_state() as a base. To be able to find all the related
functions in one go, rename it usleep_idle_range() to usleep_range_idle().

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Link: https://lore.kernel.org/all/20241014-devel-anna-maria-b4-timers-flseep-v3-4-dc8b907cb62f@linutronix.de

---
 include/linux/delay.h | 2 +-
 mm/damon/core.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/delay.h b/include/linux/delay.h
index ff9cda9..2bc586a 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -68,7 +68,7 @@ static inline void usleep_range(unsigned long min, unsigned long max)
 	usleep_range_state(min, max, TASK_UNINTERRUPTIBLE);
 }
 
-static inline void usleep_idle_range(unsigned long min, unsigned long max)
+static inline void usleep_range_idle(unsigned long min, unsigned long max)
 {
 	usleep_range_state(min, max, TASK_IDLE);
 }
diff --git a/mm/damon/core.c b/mm/damon/core.c
index a83f3b7..c725c78 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1896,7 +1896,7 @@ static void kdamond_usleep(unsigned long usecs)
 	if (usecs > 20 * USEC_PER_MSEC)
 		schedule_timeout_idle(usecs_to_jiffies(usecs));
 	else
-		usleep_idle_range(usecs, usecs + 1);
+		usleep_range_idle(usecs, usecs + 1);
 }
 
 /* Returns negative error code if it's not activated but should return */

