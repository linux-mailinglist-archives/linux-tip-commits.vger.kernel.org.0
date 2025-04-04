Return-Path: <linux-tip-commits+bounces-4685-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA34A7C2E1
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 19:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E037A176925
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E78421C16A;
	Fri,  4 Apr 2025 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MYVbJGNQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W4hQbCuM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EB2215077;
	Fri,  4 Apr 2025 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743789277; cv=none; b=mymN+dJ+HHCmMBO/0lynw/w7R1qHzE52Ng8MaA9kBtAxngsyq3zglMOAT+M4mNMlNMntVcsz2gMy2lOr+D4YT3yGltTQFjwAtilGkBHdlhno0TZhTLbQkRWbJioWh7AvlvbXXFRT49Cz7YDHvJpms8yt5IY9El0Bq3bEg11uqak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743789277; c=relaxed/simple;
	bh=+bFYv4m7EMb3yd6OIRQlKSklsgR7DcjSSttPQDsrGck=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J+LSec23uNZ14aWGPD3lsiRlokWQsQB2JhEqO+4fw+2Y8/E86TEk+V5Ya/C/DJFceUk93Y+PF7UetCvknTaWXrcZHd20EoMJttt7q2FfLjk6VMDAdjUmfaOXJHug+JgUt1/X3L+9jYAuHI6NeYTC4+3vPDh0AlrQ0iJ8RBlhjL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MYVbJGNQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W4hQbCuM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 17:54:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743789274;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsalhT/4ffAbg/xnACOrAJZxliKs7aT0dUfZItF7LFE=;
	b=MYVbJGNQPYv2BmhSQHgP88kAoxCZMHmyEfdCa92NT5OYPwVlk1B4dtPEXn6L6MARRmjLT+
	fEeRi40Fc5TdX/3+ej4zexiREd9Mwjhy8qw2GZRHVsS7MuQdwwbMB6fBNEHbJxLMQmfx4P
	1iS8JO+yvgeP3uOSY/KCzLXccXa0d7zmdqu0jd7pFXoEfxMBNS4uIY/3iU6eXX+bXncCl/
	ITSHT+B/Erqwr7bQtyEwGpPUuoXHoVVM61NK+V1W5NUQOKQHs49L+FN2C4vw6V+WWijyhN
	bOXfOBGCttVEspYObcgl1CYj02aDyklfi2MzlQGH76Iyoz0CrknbeIchX8bRVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743789274;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsalhT/4ffAbg/xnACOrAJZxliKs7aT0dUfZItF7LFE=;
	b=W4hQbCuMIPM72/EtYWh75Z178ZuLCtC/uIehFuONLujj4y7yG+C3ENaH9HzDm8dyj8gOgi
	kocuMVi9mdDC9jDA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Rename debug_init() to debug_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C4b730c1f79648b16a1c5413f928fdc2e138dfc43=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C4b730c1f79648b16a1c5413f928fdc2e138dfc43=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174378927316.31282.9479640556407971399.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     9c81b62306c7d33aa5d6a416b2c57dfedb99bd41
Gitweb:        https://git.kernel.org/tip/9c81b62306c7d33aa5d6a416b2c57dfedb99bd41
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 19:46:06 +02:00

hrtimers: Rename debug_init() to debug_setup()

All the hrtimer_init*() functions have been renamed to hrtimer_setup*().
Rename debug_init() to debug_setup() as well, to keep the names consistent.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/4b730c1f79648b16a1c5413f928fdc2e138dfc43.1738746927.git.namcao@linutronix.de

---
 kernel/time/hrtimer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 8cb2c85..472c298 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -465,9 +465,7 @@ static inline void debug_hrtimer_activate(struct hrtimer *timer,
 static inline void debug_hrtimer_deactivate(struct hrtimer *timer) { }
 #endif
 
-static inline void
-debug_init(struct hrtimer *timer, clockid_t clockid,
-	   enum hrtimer_mode mode)
+static inline void debug_setup(struct hrtimer *timer, clockid_t clockid, enum hrtimer_mode mode)
 {
 	debug_hrtimer_init(timer);
 	trace_hrtimer_init(timer, clockid, mode);
@@ -1648,7 +1646,7 @@ static void __hrtimer_setup(struct hrtimer *timer,
 void hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*function)(struct hrtimer *),
 		   clockid_t clock_id, enum hrtimer_mode mode)
 {
-	debug_init(timer, clock_id, mode);
+	debug_setup(timer, clock_id, mode);
 	__hrtimer_setup(timer, function, clock_id, mode);
 }
 EXPORT_SYMBOL_GPL(hrtimer_setup);

