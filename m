Return-Path: <linux-tip-commits+bounces-4834-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8026A853B3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 07:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4981B6288C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 05:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C81227CCFF;
	Fri, 11 Apr 2025 05:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kL59YxhU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VgkR+Q2Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D709B27CCD6;
	Fri, 11 Apr 2025 05:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744350292; cv=none; b=QVHFt5Vy7gr1KGqVK8ciX1xCi8YfkudNHedjcKyHfX+MAkyr2xEUKYR/q+OG4DpJp1P9vQfMRO3Ig91bB+aE45HE+3dDJe27FCEZcVScf8XynvxlAZoqV6Cdb4zosvGWot4UhBjMuI29LmR0IOR8I2NAcbnGjtNjETEpuVskBDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744350292; c=relaxed/simple;
	bh=xebDiIQQ2wgC0/HnVBr0UvIfwklyg6b7Z4k06Voi9eM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=B76KoDSgc0BZerxzAotuzlHvAPZS6Z38P5n8cC49lZbyOp7zV2cAFkDY6GVj6+mNXX88Y392zf3LK19Zkx7sVDR2QZoj1r9apCfwWWcH6q/ZUEVyXz+9l31p6pBH03pcSslTgu89yKFVG3nyDBXTCqv4taa3m9asNKqSRx1E+sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kL59YxhU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VgkR+Q2Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 05:44:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744350288;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4/+ndLmoMJWpHExxOrgWYAe7YeA2D7nUdx6OURcDfY=;
	b=kL59YxhUSoIm4CPSlz0vymAGN4YML91TffYqhUOCJVNQRoPc53UTxUmP2WhHe4V83vOd6B
	2+hQEVu0gzgiR3Kn/ahZJgU2li17voNPby1NNA8A3YNnQh7A9O+PoauVjXr/p2bfPWhwM2
	UsjyOIoOq9IzeoLbngqUO2wmCI+7xtMamEMk5c6d9x9NLzSeaOEH0iWICOFSUXA02nviNg
	0CzRniXmQylGxjWHNV0KIhSXUDbN3Ml8T7oookdisg01l1CPaNlMgp986eCrLTRupyjLcU
	hBEFAm8YHFAf5Y7a/0dU6iyXWXeEbnem0Aqqgxhl5/2MFsfdlIX8V3LLfULWHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744350288;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4/+ndLmoMJWpHExxOrgWYAe7YeA2D7nUdx6OURcDfY=;
	b=VgkR+Q2ZfZl0pqQN+iHciMjrX3RUDYqKnnqGqxaWXtsnrNY5XckQTOEg7Umx0TnH2C+p+w
	f/snmTrBUgWCcyDA==
From: "tip-bot2 for Fernando Fernandez Mancera" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] x86/i8253: Call clockevent_i8253_disable() with
 interrupts disabled
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Fernando Fernandez Mancera <ffmancera@riseup.net>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Z-uwd4Bnn7FcCShX@gmail.com>
References: <Z-uwd4Bnn7FcCShX@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174435028421.31282.9864723186814628549.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     3940f5349b476197fb079c5aa19c9a988de64efb
Gitweb:        https://git.kernel.org/tip/3940f5349b476197fb079c5aa19c9a988de64efb
Author:        Fernando Fernandez Mancera <ffmancera@riseup.net>
AuthorDate:    Tue, 01 Apr 2025 11:23:03 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 07:28:20 +02:00

x86/i8253: Call clockevent_i8253_disable() with interrupts disabled

There's a lockdep false positive warning related to i8253_lock:

  WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
  ...
  systemd-sleep/3324 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
  ffffffffb2c23398 (i8253_lock){+.+.}-{2:2}, at: pcspkr_event+0x3f/0xe0 [pcspkr]

  ...
  ... which became HARDIRQ-irq-unsafe at:
  ...
    lock_acquire+0xd0/0x2f0
    _raw_spin_lock+0x30/0x40
    clockevent_i8253_disable+0x1c/0x60
    pit_timer_init+0x25/0x50
    hpet_time_init+0x46/0x50
    x86_late_time_init+0x1b/0x40
    start_kernel+0x962/0xa00
    x86_64_start_reservations+0x24/0x30
    x86_64_start_kernel+0xed/0xf0
    common_startup_64+0x13e/0x141
  ...

Lockdep complains due pit_timer_init() using the lock in an IRQ-unsafe
fashion, but it's a false positive, because there is no deadlock
possible at that point due to init ordering: at the point where
pit_timer_init() is called there is no other possible usage of
i8253_lock because the system is still in the very early boot stage
with no interrupts.

But in any case, pit_timer_init() should disable interrupts before
calling clockevent_i8253_disable() out of general principle, and to
keep lockdep working even in this scenario.

Use scoped_guard() for that, as suggested by Thomas Gleixner.

[ mingo: Cleaned up the changelog. ]

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/Z-uwd4Bnn7FcCShX@gmail.com
---
 arch/x86/kernel/i8253.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/i8253.c b/arch/x86/kernel/i8253.c
index 80e262b..cb9852a 100644
--- a/arch/x86/kernel/i8253.c
+++ b/arch/x86/kernel/i8253.c
@@ -46,7 +46,8 @@ bool __init pit_timer_init(void)
 		 * VMMs otherwise steal CPU time just to pointlessly waggle
 		 * the (masked) IRQ.
 		 */
-		clockevent_i8253_disable();
+		scoped_guard(irq)
+			clockevent_i8253_disable();
 		return false;
 	}
 	clockevent_i8253_init(true);

