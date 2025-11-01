Return-Path: <linux-tip-commits+bounces-7124-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D42CFC28656
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7FA3B6B99
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312B02FFDEA;
	Sat,  1 Nov 2025 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mgm/tQO/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aIrOu166"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B1E2749F2;
	Sat,  1 Nov 2025 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762025370; cv=none; b=l80TyCLIoHvq602FD1sBEPnyYmvQnvskOJllIQj6bnSxw0yUBTeq7WlaCm8udgFRpxcQ4uQXCRWZ6L5uIeD0LMkII4tH1zw+snmGc6eClTRTMIGwozsfPl81QiIwRdi/VzDbc82Tgri+Bx+eUKizGpCLPU6a4Qb00gCRJN13C8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762025370; c=relaxed/simple;
	bh=0+xbIZMSiHeIDGWSH8ZeXzu502yzjBEEAQi9fwcKK+U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NgzkJ/Q92ylYGUo78nAUuI8xj00M2gndimRImLj051iNLqxSlHXaWER7NqO9eWrcrBZSAElyXsfNjf8U/DBa8Pya1Nkjv21MWnTILYuQHFYxGmx4uFAf7AYcsJbD8RbdM2flg5NnWEh04KiButTPOgJBXwAnvZ8MIVKepwVGCMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mgm/tQO/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aIrOu166; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:29:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762025366;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1pecLsb8phHLYbZYaNbjZH1sKGsCr3dpjSr56vfZ7j8=;
	b=Mgm/tQO/cKYdE+CLVlCKeE67sH4caAa+6Rj3x1WhJjbvZfWK0sD+M3SqYmg4ADdmA4uoPU
	0PU/T8DqaFgfwKpjEJzCwdU+S6haHzF1sT2VBcgmkr6NLJul/RcrEd7xp3vg8IlQPzSAgt
	sQ4ylVE1MGprAR1sVF2askfQzARMZYXsnVesjAchdlMrhdso4MqsuOtn8j6G6F2IJtFn+Z
	cz9LkMjQOKsFd/XOB/aqzMsso4FKJFEIuH9NQybRcEqOBtNwJ/QgAUD1jawEM26M7mgYTA
	7fpO2dnETpOq/UtbVwnglNYzUnWPPjA2/VL3jPp7x9p8DR8WBRgFQ3OEnujIGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762025366;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1pecLsb8phHLYbZYaNbjZH1sKGsCr3dpjSr56vfZ7j8=;
	b=aIrOu166dp4rPlSKE1N5SNQ2Cjr8ykBh7PtzzIxtyppJztgXSazcHa4NA6eq9fIEejPPiM
	jGZuejAzczrQovBQ==
From: "tip-bot2 for Steve Wahl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/sched: Limit non-timekeeper CPUs calling
 jiffies update
Cc: Steve Wahl <steve.wahl@hpe.com>, Thomas Gleixner <tglx@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027183456.343407-1-steve.wahl@hpe.com>
References: <20251027183456.343407-1-steve.wahl@hpe.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202536453.2601451.10522224448840694773.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4138787408aa47e9e107f28876cb59b42d78bb99
Gitweb:        https://git.kernel.org/tip/4138787408aa47e9e107f28876cb59b42d7=
8bb99
Author:        Steve Wahl <steve.wahl@hpe.com>
AuthorDate:    Mon, 27 Oct 2025 13:34:56 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:25:53 +01:00

tick/sched: Limit non-timekeeper CPUs calling jiffies update

On large NUMA systems, while running a test program that saturates the
inter-processor and inter-NUMA links, acquiring the jiffies_lock can be
very expensive.

If the cpu designated to do jiffies updates (tick_do_timer_cpu) gets
delayed and other cpus decide to do the jiffies update themselves, a large
number of them decide to do so at the same time.

The inexpensive check against tick_next_period is far quicker than actually
acquiring the lock, so most of these get in line to obtain the lock.  If
obtaining the lock is slow enough, this spirals into the vast majority of
CPUs continuously being stuck waiting for this lock, just to obtain it and
find out that time has already been updated by another cpu. For example, on
one random entry to kdb by manually-injected NMI, 2912 of 3840 CPUs were
observed to be stuck there.

To avoid this, allow only one non-timekeeper CPU to call
tick_do_update_jiffies64() at any given time, resetting ts->stalled jiffies
only if the jiffies update function is actually called.

With this change, manually interrupting the test at most two CPUs are
observed to invoke tick_do_update_jiffies64() - the timekeeper and one
other.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://patch.msgid.link/20251027183456.343407-1-steve.wahl@hpe.com
---
 kernel/time/tick-sched.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c527b42..3ff3eb1 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -201,6 +201,27 @@ static inline void tick_sched_flag_clear(struct tick_sch=
ed *ts,
 	ts->flags &=3D ~flag;
 }
=20
+/*
+ * Allow only one non-timekeeper CPU at a time update jiffies from
+ * the timer tick.
+ *
+ * Returns true if update was run.
+ */
+static bool tick_limited_update_jiffies64(struct tick_sched *ts, ktime_t now)
+{
+	static atomic_t in_progress;
+	int inp;
+
+	inp =3D atomic_read(&in_progress);
+	if (inp || !atomic_try_cmpxchg(&in_progress, &inp, 1))
+		return false;
+
+	if (ts->last_tick_jiffies =3D=3D jiffies)
+		tick_do_update_jiffies64(now);
+	atomic_set(&in_progress, 0);
+	return true;
+}
+
 #define MAX_STALLED_JIFFIES 5
=20
 static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
@@ -239,10 +260,11 @@ static void tick_sched_do_timer(struct tick_sched *ts, =
ktime_t now)
 		ts->stalled_jiffies =3D 0;
 		ts->last_tick_jiffies =3D READ_ONCE(jiffies);
 	} else {
-		if (++ts->stalled_jiffies =3D=3D MAX_STALLED_JIFFIES) {
-			tick_do_update_jiffies64(now);
-			ts->stalled_jiffies =3D 0;
-			ts->last_tick_jiffies =3D READ_ONCE(jiffies);
+		if (++ts->stalled_jiffies >=3D MAX_STALLED_JIFFIES) {
+			if (tick_limited_update_jiffies64(ts, now)) {
+				ts->stalled_jiffies =3D 0;
+				ts->last_tick_jiffies =3D READ_ONCE(jiffies);
+			}
 		}
 	}
=20

