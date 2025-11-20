Return-Path: <linux-tip-commits+bounces-7433-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E71C7611A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 20:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B73CB4E20BE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 19:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0042368DFF;
	Thu, 20 Nov 2025 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mTXsLFrR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cF5jAlCY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D18130F801;
	Thu, 20 Nov 2025 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763666579; cv=none; b=P4M3qR9gykAQ/8uCKfrfraTimOb423xEZ6luP4ohkN0R4ljOtkgW7IDF0kyzHqgGBs+kPHgWnjkvD1Ba4Ln4o3SSUDverh5GTLnZ3wQZSTN8xlU6l8yWwHgY35n7UecgtWdY28rTOn6A90AlZsx0z/PPWS1kLD1FQ92hV6qfJmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763666579; c=relaxed/simple;
	bh=ToqwTRqTz8dxqtsgodoNG2LxYlTmwsW2G9nBKvJio5w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A6ECAQTIjwJkZZ9Z4WvCZG83tnZjYv2tTZKfLVwc3G04Hg2CdGwq1PQ9++5pZF0QgchwcslQA68Ex8IduaW4QwEhk33A5bXb/iBeBJfs0lqaqQK8Axvm/qbRUyk6H6fjiE7Tk7EsCm7yjojXWiq+0LzKTwc9poVxrqNPdCYXveg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mTXsLFrR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cF5jAlCY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 19:22:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763666576;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R9IniNUJ1SGSbJeTgAlWCX1uqP65NGDDpSmjYizExow=;
	b=mTXsLFrROM4npQJxJZ9/9d6ZAnEGrtWoxkC8HCRhTI7PdLAEKYSwp7xvgF9+S20r/2s99t
	at4vyZ6qfulIlWQ05HQb2OgzUKTeXC94DJZ2UTqCxMkh73R53H1wUOdjU5fgI4xCm7FyrC
	iX86obM172Nq2as77bxcvtcDlpgRsTKzs+po+b7Ww4i6zPqP5xvjF8fJaL3HdLuC/3y5k4
	BGiT5MfazvNcd8KCKzFJMzsOUvBMh9mzYBye2OpowimTpF/JyeYDSHN8Hsrn73IhbsWGfD
	S8+SfVKsRG92Fb6HA3TMWuuKMIxtr2QUGbT9a+Yek+eDhj29tRr2XKQofwcbxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763666576;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R9IniNUJ1SGSbJeTgAlWCX1uqP65NGDDpSmjYizExow=;
	b=cF5jAlCY7UEqK9Al6OQtSwVuOLwa7FUC77zJ8rjkvlvoGuR93TdslHDxswuNbIyo5ERNa/
	6Pq5UiVuPpVLXCDw==
From: "tip-bot2 for Gabriele Monaco" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers/migration: Use scoped_guard on available
 flag set/clear
Cc: Gabriele Monaco <gmonaco@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251120145653.296659-4-gmonaco@redhat.com>
References: <20251120145653.296659-4-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176366657540.498.7006845183237671305.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4c2374ed86847c71dab5602c7882d21a0d56a4c7
Gitweb:        https://git.kernel.org/tip/4c2374ed86847c71dab5602c7882d21a0d5=
6a4c7
Author:        Gabriele Monaco <gmonaco@redhat.com>
AuthorDate:    Thu, 20 Nov 2025 15:56:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 Nov 2025 20:17:31 +01:00

timers/migration: Use scoped_guard on available flag set/clear

Cleanup tmigr_clear_cpu_available() and tmigr_set_cpu_available() to
prepare for easier checks on the available flag.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251120145653.296659-4-gmonaco@redhat.com
---
 kernel/time/timer_migration.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 3325ca7..a01c7f8 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1440,17 +1440,17 @@ static int tmigr_clear_cpu_available(unsigned int cpu)
 	u64 firstexp;
=20
 	cpumask_clear_cpu(cpu, tmigr_available_cpumask);
-	raw_spin_lock_irq(&tmc->lock);
-	tmc->available =3D false;
-	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
+	scoped_guard(raw_spinlock_irq, &tmc->lock) {
+		tmc->available =3D false;
+		WRITE_ONCE(tmc->wakeup, KTIME_MAX);
=20
-	/*
-	 * CPU has to handle the local events on his own, when on the way to
-	 * offline; Therefore nextevt value is set to KTIME_MAX
-	 */
-	firstexp =3D __tmigr_cpu_deactivate(tmc, KTIME_MAX);
-	trace_tmigr_cpu_unavailable(tmc);
-	raw_spin_unlock_irq(&tmc->lock);
+		/*
+		 * CPU has to handle the local events on his own, when on the way to
+		 * offline; Therefore nextevt value is set to KTIME_MAX
+		 */
+		firstexp =3D __tmigr_cpu_deactivate(tmc, KTIME_MAX);
+		trace_tmigr_cpu_unavailable(tmc);
+	}
=20
 	if (firstexp !=3D KTIME_MAX) {
 		migrator =3D cpumask_any(tmigr_available_cpumask);
@@ -1469,13 +1469,13 @@ static int tmigr_set_cpu_available(unsigned int cpu)
 		return -EINVAL;
=20
 	cpumask_set_cpu(cpu, tmigr_available_cpumask);
-	raw_spin_lock_irq(&tmc->lock);
-	trace_tmigr_cpu_available(tmc);
-	tmc->idle =3D timer_base_is_idle();
-	if (!tmc->idle)
-		__tmigr_cpu_activate(tmc);
-	tmc->available =3D true;
-	raw_spin_unlock_irq(&tmc->lock);
+	scoped_guard(raw_spinlock_irq, &tmc->lock) {
+		trace_tmigr_cpu_available(tmc);
+		tmc->idle =3D timer_base_is_idle();
+		if (!tmc->idle)
+			__tmigr_cpu_activate(tmc);
+		tmc->available =3D true;
+	}
 	return 0;
 }
=20

