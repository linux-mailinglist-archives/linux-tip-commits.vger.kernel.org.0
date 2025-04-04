Return-Path: <linux-tip-commits+bounces-4662-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12B2A7BFAF
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 16:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730C23B349E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 14:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4301F76C6;
	Fri,  4 Apr 2025 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DmW5wUih";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D8aTHv15"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD391F2B8B;
	Fri,  4 Apr 2025 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777388; cv=none; b=XDeWTvuiEB2zVh60O8uxWNOWUWQidHnjIt07ziVR85h5YI4NkLTry2d6qS+hKZMP3XDeYPj0XLXzMpZyPNh03HrNOVGYLWg/u43+KvYLK336YWgQIYDC9L2jIcey8tfL5xvNWugQ/IpB4nO4NlQuQjU7MYtnpSMRzymiZWM6Y9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777388; c=relaxed/simple;
	bh=UK1BKiKJxKtPapqgqQGXYWXj41M3zq5guZO07tuFTzs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Gp2OyVwtqYSf7Jq/YMzi/XD3qdjPtGTm1dNUdNNdg0j8BCWB0kI4Wkmwn/l9qRGUnaDZusjX8A/P7I4neAcbzi1ZaBb/H37ID5B9xcmMm4+fELzz+Wp+tdQSPqyKXYSyIYFYiNiXjxvNu8f4wzrmFPfBvTsS4ES8yvoLYTjh1/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DmW5wUih; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D8aTHv15; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 14:36:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743777381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qT2qL59BSYosvq1/lL7Tffo1PysWkyS+13wmfKdS5Rw=;
	b=DmW5wUihok46wZKf/E8jsUNGKeWA7XKG/PJnpTMt/qV3kyhxfHtPZEVRebGZr4mrK9ASRI
	N5ZrEHUx9DvIkJz7guK6SeZat1H26Tgyz58W7N0gQLW9kueN3Ulob0dEd9ZIvEBfTlGE55
	RVm2n7VMurUseg+JAOVVXSdrKGoKKVMov3JN1WiGr/qf0uICIybVJY76NpgLOBmsMjWFe5
	cHLM1KW4astWyY6ppeUji9ZY3iL6McdQ4NC7OzduDs2IE0png+NRXVBHYExldPE+1Ko7tJ
	l9imGOzDd3IzsAnqoXOD3ts0LlqYX/Hjytfe9E029xOli5vuxy0te22egvAetQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743777381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qT2qL59BSYosvq1/lL7Tffo1PysWkyS+13wmfKdS5Rw=;
	b=D8aTHv15Cc/BbsH/YJAbvW5FWZ+h6l/GJA7g/V6C8nW7uT2nmowRfJ0zDbt2dosjOIuBwq
	mWTFc0aZMvXgJsDw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Switch to use __htimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cd9a45a51b6a8aa0045310d63f73753bf6b33f385=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cd9a45a51b6a8aa0045310d63f73753bf6b33f385=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174377738038.31282.2750269952539289520.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     8ed35ea9f00307a68c9b15b0b0ab927f552b1711
Gitweb:        https://git.kernel.org/tip/8ed35ea9f00307a68c9b15b0b0ab927f552b1711
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:11 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 16:26:09 +02:00

hrtimers: Switch to use __htimer_setup()

__hrtimer_init_sleeper() calls __hrtimer_init() and also setups the
callback function. But there is already __hrtimer_setup() which does both
actions.

Switch to use __hrtimer_setup() to simplify the code.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/d9a45a51b6a8aa0045310d63f73753bf6b33f385.1738746927.git.namcao@linutronix.de

---
 kernel/time/hrtimer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index b7555ba..2d2835c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2061,8 +2061,7 @@ static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 			mode |= HRTIMER_MODE_HARD;
 	}
 
-	__hrtimer_init(&sl->timer, clock_id, mode);
-	sl->timer.function = hrtimer_wakeup;
+	__hrtimer_setup(&sl->timer, hrtimer_wakeup, clock_id, mode);
 	sl->task = current;
 }
 

