Return-Path: <linux-tip-commits+bounces-3501-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8DEA3996A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5000C3B7C17
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777CC269AE3;
	Tue, 18 Feb 2025 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wlZvAdb7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="irillKp+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6052690DE;
	Tue, 18 Feb 2025 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874411; cv=none; b=QzxWYS/8+tzXMO/bqRUm2QN+q+i+IjyRKnqcYPQ9jgmX46eJX4wkEumZbzYbuTIEyupKQMdBq13915YxkAksl6oWVbQ8L0ns/tKXsi0yV/tNHlOO9paI/bNnUCkEGgSH9U43PC6KK2wLHaZyye4Z/ksvwWjEBatJdzaRsrtqdhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874411; c=relaxed/simple;
	bh=Z4qO9rOdI/2DrO5D6VjAaXkvUDhTZeFgGMuoBr0++tE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SVG/vrQAqqWpVWLq2BDJ8FLALn48H8YY75TlQ9pAskLrRKEJAFV4e5UoIpVI20nBzqqoHKbD3/R7AA+TmLG9K6zme9qPbokOhoejfj9Q6vdmbNLw5gdVrvMHLfUVEsvsEKZrFOfYbOYz9rMrkf9lKmmpPPYQU5YXakcLzu+WIbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wlZvAdb7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=irillKp+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874408;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+g7jX2ZSJSaFVWnd9oTZwMLnabbe+STBVcIlWv1skg=;
	b=wlZvAdb7YsdKZqtpVy0b9la9kcPU5otSur/Od7wuAP0yFlt0Q5whvhOtTIxh93laiD7Ctu
	q/ULmOLb1V9JMNDGWRigSRy13h+yu3jiKGDzcDTVeJjV/KSZD/urLsfrbGUtJj44t0GDam
	pghgrBvwuJK5y6N1uIGFLyIyrIWgUMzgQiFKWNlM6AN+1qiaZGsogpLdZuVNpTv2ZuJ0Dr
	ohiGIu009sqkinXL/sPgNqOA7QC2A8EXfigWLXPIP8bZHzVjhX1TmrYGdN/43QB4K8RhRx
	QSRmgRbKiRedO54d12KWp/jyH/CqUnnWHCIS5jMj2vvDABbi2vxtSd+4nvn0QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874408;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+g7jX2ZSJSaFVWnd9oTZwMLnabbe+STBVcIlWv1skg=;
	b=irillKp+0WsfTSCoQgd1CS1WxPqTlld58ZGs+u+XlwmtWZ/5k708hHceOaltoIVVd6F4FO
	H9pzbH9GVJrDj+BA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] USB: chipidea: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ca6e43ac5a90f975343e1cef2d8346b4697ec0473=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Ca6e43ac5a90f975343e1cef2d8346b4697ec0473=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987440777.10177.15830505053389996369.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     a63cb05bd553d93e43bfac4a899cd356082d307c
Gitweb:        https://git.kernel.org/tip/a63cb05bd553d93e43bfac4a899cd356082d307c
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:45:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:01 +01:00

USB: chipidea: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/a6e43ac5a90f975343e1cef2d8346b4697ec0473.1738746904.git.namcao@linutronix.de

---
 drivers/usb/chipidea/otg_fsm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/otg_fsm.c b/drivers/usb/chipidea/otg_fsm.c
index c17516c..a093544 100644
--- a/drivers/usb/chipidea/otg_fsm.c
+++ b/drivers/usb/chipidea/otg_fsm.c
@@ -424,8 +424,7 @@ static enum hrtimer_restart ci_otg_hrtimer_func(struct hrtimer *t)
 /* Initialize timers */
 static int ci_otg_init_timers(struct ci_hdrc *ci)
 {
-	hrtimer_init(&ci->otg_fsm_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	ci->otg_fsm_hrtimer.function = ci_otg_hrtimer_func;
+	hrtimer_setup(&ci->otg_fsm_hrtimer, ci_otg_hrtimer_func, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 
 	return 0;
 }

