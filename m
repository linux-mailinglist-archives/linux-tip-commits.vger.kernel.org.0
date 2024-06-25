Return-Path: <linux-tip-commits+bounces-1536-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D25916BAC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jun 2024 17:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A4E288225
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jun 2024 15:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6330B17BB3D;
	Tue, 25 Jun 2024 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="trYLAgpC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hZKiQZ9H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB44716C6AE;
	Tue, 25 Jun 2024 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327687; cv=none; b=Svj7gFXXm1yetVBiQauA89LRgnIl26mf4zLqMbdH3IyLXgdNmTJdsk/ImKdqWWihM9Ropk/bxXa81tAUpUeJyr7u6JEEQVYdjreawy+c6SiZfAnTd5qjYa/UXVJjTDuxmvzhy8P9/F5jxdZ7o1MaW+3f0SX3Bb6Irmyb4urzp/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327687; c=relaxed/simple;
	bh=4eLqse1vF9JmYCi/WvX+PCNtXrG8+aGWPyh7rKifTmk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Jvsu/MJrQNuRl9yKZ6CElOHA/WkfpEL2LX7Cj53x5QlCXEB+H5wjnTWbK5GeLFPqlFAZ+mfE987ip6wxMV8441YaJdwLaxr1d2ebAYA4VKyoC5BCj0IkODbe1z1WW+LKOtrjewnRpFVf2NoLtcO7vF+24bP+dtif5CTmp6yeyAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=trYLAgpC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hZKiQZ9H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Jun 2024 15:01:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719327684;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=fklcLLhd5eg8GBZwiepm0m7fp8mS0c6yldyXI1gupng=;
	b=trYLAgpCbVnj77g9I14Q5Voc4Eq7EZSpRas4tll+44Oux3GFWbdOnXIu5oyvY4yLBliwVt
	VprhtfDdcILB1pPuA/uVXvBjPqYMvyPYwgGuqoEnwlOpIWCyYzmaVuU2qQf3gaZj8/35Sg
	h3ncmzgOA25Lz3oUEWdGHccu9KRSN3PYeHIVkETKLqrw/AMi3iWFHk/WStNRaObTafB7Nm
	A6RXM0OW040IbNpz6J+HNHHCvmygQMa/4TFpWpLLlDEoa3biy2QtMyrwBa30oHzfJYMYyW
	TKP8PmoWE5u+MlqQtfzhi++hWcXv37lYOqlmRWgYX5efbUqaPMkweWYhbHJcbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719327684;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=fklcLLhd5eg8GBZwiepm0m7fp8mS0c6yldyXI1gupng=;
	b=hZKiQZ9HtbyAui4TFCJTh9EtKq4f6E6AOp1ASqXJ9+1KUtXDF7G4i3cUCc+/o/Ix81XPpE
	sx8Of3EFstpjVcAg==
From: "tip-bot2 for Phil Chang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] hrtimer: Prevent queuing of hrtimer without a
 function callback
Cc: Phil Chang <phil.chang@mediatek.com>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171932768353.2215.17369057757603861329.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     5a830bbce3af16833fe0092dec47b6dd30279825
Gitweb:        https://git.kernel.org/tip/5a830bbce3af16833fe0092dec47b6dd30279825
Author:        Phil Chang <phil.chang@mediatek.com>
AuthorDate:    Mon, 10 Jun 2024 21:31:36 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 25 Jun 2024 16:54:27 +02:00

hrtimer: Prevent queuing of hrtimer without a function callback

The hrtimer function callback must not be NULL. It has to be specified by
the call side but it is not validated by the hrtimer code. When a hrtimer
is queued without a function callback, the kernel crashes with a null
pointer dereference when trying to execute the callback in __run_hrtimer().

Introduce a validation before queuing the hrtimer in
hrtimer_start_range_ns().

[anna-maria: Rephrase commit message]

Signed-off-by: Phil Chang <phil.chang@mediatek.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/hrtimer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 492c14a..b8ee320 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1285,6 +1285,8 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	struct hrtimer_clock_base *base;
 	unsigned long flags;
 
+	if (WARN_ON_ONCE(!timer->function))
+		return;
 	/*
 	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
 	 * match on CONFIG_PREEMPT_RT = n. With PREEMPT_RT check the hard

