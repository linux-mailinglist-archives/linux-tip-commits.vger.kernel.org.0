Return-Path: <linux-tip-commits+bounces-7361-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FA0C5F106
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 20:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDA93AFC5D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 19:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B01A326952;
	Fri, 14 Nov 2025 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k6LQa32n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h+Tcij+H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CE82EFDBB;
	Fri, 14 Nov 2025 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763149152; cv=none; b=l+ylMiDoCtFD8XOXkkzNmiDsYDopPzYArQKYNIKOd3+XA4hU0mFxuTUu13hD8YLpNU2hcDutuG8J+M4cDbuzDvatmeBaB8nUthx0GehRTC5vE1fUhzJL0YtdMa538A6x+E8KqTPDuQ1NpjNI0P6sFIqNDjHP3LpcAUTgmLmCXpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763149152; c=relaxed/simple;
	bh=m9HsxscY1+pcwV44E5N3dI7oJGqVdnzC4fCSE4jOVUE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=prWj23Ll87WFWDIt+ZQS1h8DPnEd5UAyFF+fqb+4TjZjQKO+c1ldK3sz7Ag/kJRb02Xvsx8GgGuGES8tbOCFiHlzAq35B0gQg6Ck0CT4XP9KxmJJHHyluMUEulnAoMl13iNElASWKFk3DsobkqGcCoZHvay7GToXj/Cjn60boDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k6LQa32n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h+Tcij+H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 19:39:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763149149;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGpjsWAGebHX3iPPXvKsXquO7rvV0ZdgbQvomEtP2Mc=;
	b=k6LQa32n+XBx2ER6QOSQmZstcEVsRFX9BZpeC0jhZbp8MHr/Mi6S31A3n7GPRdwUzsNk0e
	R/W3nWt7i/A5bXBrNpEYKmjodC6ESgsS4zuYTJJZmNlFA0y58nuoKDh5KTQ0nVHt1T+3vZ
	Y1zi9feuA8kAwg3u2Ghsu77aRcm1aQPbsQz8h6rgUe9h8CDhFF9E5PnCbUgmuiJcAS1SD9
	LwBUrQRh4FnCfEXb4m3ZXIsGOMhC97c/lB/cmyCQJ0DfI08UozBnNx6ZiXyOT9+njP4vOC
	Xq1A/3oxqZCX6gAd7uKh+DE3v8c4Gp/VQUyvtjXFsnMEuKea50EvP6vXgRbnYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763149149;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGpjsWAGebHX3iPPXvKsXquO7rvV0ZdgbQvomEtP2Mc=;
	b=h+Tcij+HrjJBpWhtbnJLxc117QlzkXW6e9wfR4w0mG/9i46NqbXWcceRF++0mOui7FF/+D
	teVuvNuNdrKhI1CA==
From: "tip-bot2 for Jianyun Gao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] time: Fix a few typos in time[r] related code comments
Cc: Jianyun Gao <jianyungao89@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250927093411.1509275-1-jianyungao89@gmail.com>
References: <20250927093411.1509275-1-jianyungao89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176314914826.498.9885322035796599569.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4518767be9089ea4f54754ad27364d6134fc46e2
Gitweb:        https://git.kernel.org/tip/4518767be9089ea4f54754ad27364d6134f=
c46e2
Author:        Jianyun Gao <jianyungao89@gmail.com>
AuthorDate:    Sat, 27 Sep 2025 17:34:10 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 14 Nov 2025 20:34:50 +01:00

time: Fix a few typos in time[r] related code comments

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20250927093411.1509275-1-jianyungao89@gmail.com
---
 include/linux/delay.h         | 8 ++++----
 kernel/time/posix-timers.c    | 2 +-
 kernel/time/timer_migration.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/delay.h b/include/linux/delay.h
index 89866ba..46412c0 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -68,7 +68,7 @@ void usleep_range_state(unsigned long min, unsigned long ma=
x,
  * @min:	Minimum time in microseconds to sleep
  * @max:	Maximum time in microseconds to sleep
  *
- * For basic information please refere to usleep_range_state().
+ * For basic information please refer to usleep_range_state().
  *
  * The task will be in the state TASK_UNINTERRUPTIBLE during the sleep.
  */
@@ -82,10 +82,10 @@ static inline void usleep_range(unsigned long min, unsign=
ed long max)
  * @min:	Minimum time in microseconds to sleep
  * @max:	Maximum time in microseconds to sleep
  *
- * For basic information please refere to usleep_range_state().
+ * For basic information please refer to usleep_range_state().
  *
  * The sleeping task has the state TASK_IDLE during the sleep to prevent
- * contribution to the load avarage.
+ * contribution to the load average.
  */
 static inline void usleep_range_idle(unsigned long min, unsigned long max)
 {
@@ -96,7 +96,7 @@ static inline void usleep_range_idle(unsigned long min, uns=
igned long max)
  * ssleep - wrapper for seconds around msleep
  * @seconds:	Requested sleep duration in seconds
  *
- * Please refere to msleep() for detailed information.
+ * Please refer to msleep() for detailed information.
  */
 static inline void ssleep(unsigned int seconds)
 {
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index aa31201..36dbb81 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1242,7 +1242,7 @@ SYSCALL_DEFINE2(clock_adjtime, const clockid_t, which_c=
lock,
  *    sys_clock_settime(). The kernel internal timekeeping is always using
  *    nanoseconds precision independent of the clocksource device which is
  *    used to read the time from. The resolution of that device only
- *    affects the presicion of the time returned by sys_clock_gettime().
+ *    affects the precision of the time returned by sys_clock_gettime().
  *
  * Returns:
  *	0		Success. @tp contains the resolution
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 19ddfa9..57e3867 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -708,7 +708,7 @@ void tmigr_cpu_activate(void)
 /*
  * Returns true, if there is nothing to be propagated to the next level
  *
- * @data->firstexp is set to expiry of first gobal event of the (top level of
+ * @data->firstexp is set to expiry of first global event of the (top level =
of
  * the) hierarchy, but only when hierarchy is completely idle.
  *
  * The child and group states need to be read under the lock, to prevent a r=
ace

