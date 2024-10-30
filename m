Return-Path: <linux-tip-commits+bounces-2653-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A709B6D5C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 21:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557B31F21B81
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 20:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC81F1D1509;
	Wed, 30 Oct 2024 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lRztoGQ7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gsOWqLZO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14DE1BD9D8;
	Wed, 30 Oct 2024 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319215; cv=none; b=ibV5r4Z0gtvjLd8fMsJGTSmIt6KkCb7UN14wS44ztfH0oeetx7Jj2QgYWEOKbkiKhOA/UojMQWZU2VB1WqlgDz+MRcHlB35W9QN5KiwwrBaBF+eYR2NDIBrQIJCVpIYO34q57kWBRKwFB8G9DScHmISpm+iVj7rd/4TlmWkXfUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319215; c=relaxed/simple;
	bh=Y3m8DfNXLPnhNDwJBtZPrfDmB1WcnV65h+b5OXFMx3A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uTGrvPFD/XlE5BKsuglALN0GtWsuJFuOV9kT5c/AStOc/ZYJ2l/VpqxY0fOzSgENjX+mKOcomnwYnYtc6cPC9HUb4Jb+S5xN4xZA0lvFCXKmAGMa/UVCmjuT2adsgvXrH9E16H8QoWly41rz4q1VmAkAA/MBalhFxy8iCB26W2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lRztoGQ7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gsOWqLZO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Oct 2024 20:13:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730319212;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+kEAao9jABC5BxJcrKBsfbDqvvMyJcwNg6Hqfsca3g=;
	b=lRztoGQ7c7OUixiyAftl64K+IVR0VtZ0hkypN1GO+1a3Tlc1fg3gCWxLF++D8XXWQkH7Vn
	4p5DHGzhf7Hau12pEL2yeyXei4IwtnQe7WTZTVog4FuQFXc6m1dkPdeMluNhGKhxd7ZabT
	5QBYqz2Y9+JjHdxuP6XPs26JF4jpbUpyA8h5qtiFwVIkCgMLJu6P4S9Gnhx2TlOS+u/oh8
	nlT0N4+Q9xHg1JPsASjIDrUFYHfjmMPly4bPXuxufyqXU/Cz97x6NmwUJgc2f1WIAhdIIO
	mWW1fhR+/ua/9FtBnnCa2RKQSRNrk6052s1jfu4fvSL5zTNXdvt9ptpaZwor0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730319212;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+kEAao9jABC5BxJcrKBsfbDqvvMyJcwNg6Hqfsca3g=;
	b=gsOWqLZOufcj5S0G1mIolOXd8tiPblfm4cEAOz0YtZkcDNa4KsSwrm01O/AeJKbSUYCPxe
	qr+6L/aPVS/S76BQ==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/qcom: Remove clockevents
 shutdown call on offlining
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241029125451.54574-10-frederic@kernel.org>
References: <20241029125451.54574-10-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173031921159.3137.15613619302829138148.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     31522de0f764246ed1e583aa3b2acebd1f7c05fd
Gitweb:        https://git.kernel.org/tip/31522de0f764246ed1e583aa3b2acebd1f7c05fd
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 29 Oct 2024 13:54:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 30 Oct 2024 21:02:22 +01:00

clocksource/drivers/qcom: Remove clockevents shutdown call on offlining

The clockevents core already detached and unregistered it at this stage.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241029125451.54574-10-frederic@kernel.org

---
 drivers/clocksource/timer-qcom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-qcom.c b/drivers/clocksource/timer-qcom.c
index eac4c95..ddb1deb 100644
--- a/drivers/clocksource/timer-qcom.c
+++ b/drivers/clocksource/timer-qcom.c
@@ -130,7 +130,6 @@ static int msm_local_timer_dying_cpu(unsigned int cpu)
 {
 	struct clock_event_device *evt = per_cpu_ptr(msm_evt, cpu);
 
-	evt->set_state_shutdown(evt);
 	disable_percpu_irq(evt->irq);
 	return 0;
 }

