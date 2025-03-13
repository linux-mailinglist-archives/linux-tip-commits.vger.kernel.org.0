Return-Path: <linux-tip-commits+bounces-4171-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 465B7A5ED0B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 08:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8973D174CBB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 07:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB94E25E449;
	Thu, 13 Mar 2025 07:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="22R1W3JH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rw7XqeD4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE68A25DCFF;
	Thu, 13 Mar 2025 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741851155; cv=none; b=RugNYCewYKEQxqKSdp5fI0Tnczh/gCMLpZ9yxkcVBUVuJEZlC6Ov7M1vWFfKk6Q7Zs7tMosGNxcmpGDgo/RmCv5ztFGJM0ZbDiS3K/0FKEyql8Ceny43gU8KscwglP66eSK/PZ4zkLvsZs8g1xpRVnrfq5XLEouJWjwuMLIQ8qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741851155; c=relaxed/simple;
	bh=bEn7QdCuuXS0dl7AcrM6JEquQVl4bcUuiJ5Lyv65XTQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kfX4EnzvczpY7iVEWQBoIId9DjPaWpUpcY+Hqken0LmCCzGV656J7kcEZ+vds98X6pm7nYGjsLIEZvagalIFXQn0R1/j0QE2O7vkY+/HsFb2Mw5qTCQGrQ65DNI3U47chenXstOguAfi5bCwzuj8Z/JXly2oprt+JWcSynE6lC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=22R1W3JH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rw7XqeD4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 07:32:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741851151;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+04L24V3B5O9kVo48Int1oX5oYVsIi2CqNJvEDSz3gs=;
	b=22R1W3JHk48TzA50UPcUonN+BM/nZ3h6s4JJxNQ39vZfJWDOAspJS21Z5HRKCiQFWCNAFc
	M+vGlpFW9oSHxqq+pxY8jYvuPKqq0qDvgX54bXIFJBYTfgwaxiuu0eFPqoALi13uL9qIAk
	8WFmMjz7+0ulbnCctLnA6zSC4hiLLW0lTOwrBGmVap3q2QvTW5iL5S6kDT7MGB0tvs39GB
	ewRimG2xsyuzfRJgY7gNQ5WXT+9V2iAn8xtY+A9VDKra4HrCVaEmaRXGJqzfaXZE0t5AEo
	JE4ZzEX9P8dZWOD8uwaQxXnQuwy5BSnBaZsLIgAmTIMqWJU+sS7t7nKZXuHQww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741851151;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+04L24V3B5O9kVo48Int1oX5oYVsIi2CqNJvEDSz3gs=;
	b=rw7XqeD4L2fNobJDBQLdq/kC8faPXeYamg7MX8WpF4SOk6d+n8DhepO/Ca10s4OqwN9TeH
	RenUgUGWfBFmfnCA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timer_list: Don't use %pK through printk()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20250311-restricted-pointers-timer-v1-1-6626b91e54ab@linutronix.de>
References:
 <20250311-restricted-pointers-timer-v1-1-6626b91e54ab@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174185114740.14745.11770806383671985148.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a52067c24ccf6ee4c85acffa0f155e9714f9adce
Gitweb:        https://git.kernel.org/tip/a52067c24ccf6ee4c85acffa0f155e9714f=
9adce
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 11 Mar 2025 10:54:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Mar 2025 08:19:19 +01:00

timer_list: Don't use %pK through printk()

This reverts commit f590308536db ("timer debug: Hide kernel addresses via
%pK in /proc/timer_list")

The timer list helper SEQ_printf() uses either the real seq_printf() for
procfs output or vprintk() to print to the kernel log, when invoked from
SysRq-q. It uses %pK for printing pointers.

In the past %pK was prefered over %p as it would not leak raw pointer
values into the kernel log. Since commit ad67b74d2469 ("printk: hash
addresses printed with %p") the regular %p has been improved to avoid this
issue.

Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping looks in atomic contexts.

Switch to the regular pointer formatting which is safer, easier to reason
about and sufficient here.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7=
070468023@linutronix.de/
Link: https://lore.kernel.org/all/20250311-restricted-pointers-timer-v1-1-662=
6b91e54ab@linutronix.de
---
 kernel/time/timer_list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 1c311c4..cfbb46c 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -46,7 +46,7 @@ static void
 print_timer(struct seq_file *m, struct hrtimer *taddr, struct hrtimer *timer,
 	    int idx, u64 now)
 {
-	SEQ_printf(m, " #%d: <%pK>, %ps", idx, taddr, timer->function);
+	SEQ_printf(m, " #%d: <%p>, %ps", idx, taddr, timer->function);
 	SEQ_printf(m, ", S:%02x", timer->state);
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, " # expires at %Lu-%Lu nsecs [in %Ld to %Ld nsecs]\n",
@@ -98,7 +98,7 @@ next_one:
 static void
 print_base(struct seq_file *m, struct hrtimer_clock_base *base, u64 now)
 {
-	SEQ_printf(m, "  .base:       %pK\n", base);
+	SEQ_printf(m, "  .base:       %p\n", base);
 	SEQ_printf(m, "  .index:      %d\n", base->index);
=20
 	SEQ_printf(m, "  .resolution: %u nsecs\n", hrtimer_resolution);

