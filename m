Return-Path: <linux-tip-commits+bounces-4700-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51824A7C857
	for <lists+linux-tip-commits@lfdr.de>; Sat,  5 Apr 2025 10:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B8B189C1B7
	for <lists+linux-tip-commits@lfdr.de>; Sat,  5 Apr 2025 08:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88461E7640;
	Sat,  5 Apr 2025 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g5XIpzy0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D6CmHcPF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D6A1DE8BB;
	Sat,  5 Apr 2025 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743842807; cv=none; b=U5nzjwfCTOLWJvHs293HHcYhsEsX6sJI7uKznsWc+n3sC6lNPEUgFKbVGURpKesolO3xuv5dc8tjpB8jfc/NOapKHXCDlorD9jiydxcybxLjlw31D7DAhG3SeaFiAKq3pq8XY96L4r450Rik9QFmWy1BgsahALJOBCc4Qjni2yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743842807; c=relaxed/simple;
	bh=LRHH8bZeOsmev6SskhPO+JXWkbx20ZTTI6wgUJY+ipk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fC0VOO9onOuQVN0Cv3SpngiOSCqULF0Vye+qwvoVNZJcOnHuR7TfZImthlrZfNQuSEp5VU/mkOBHyCCc07AtMKSMziJA2AQM6WfxtpDJ8tD2ySBQZVcJXlMQ5w3VUbsPkjJetMyos+tVWiwvOnh7ZdeaVqH8Z3PIEymZjnzmp7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g5XIpzy0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D6CmHcPF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 05 Apr 2025 08:46:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743842800;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7f7cBX0ucvHfq4gITJ3CdfbZltrEyKi+/0QIALTbYvA=;
	b=g5XIpzy0L809cYJUQzjXUytEvvWHIh87eq4g5mE5mQzj+D72vZHUZhQYBl0WTUZYrIgIvI
	3k3C6L5hRZO2i6hLSeVS4xlXbM+40f7FWQ0dy3waS5GyUjpTZlwOnTh6sc0++2/LjyK+yq
	fYthtePeoqSKa0voUH19zThVSpVBr+Sx4jEPkSIY5ARr/dUcI2RRMDiVY8tLPta9y/eZ69
	9Jb59AIwlgK39pvmrOPZwFiUwzls8m11tFLrX+YZ9LEHBOIJ7oUGQ+zvSWJ6n+0fL2qwPJ
	SQvCgcJuPg9moa85BZj5pnpK1ArfRlkICEgwLvP5vf+mPPGs3tclC4hWy3upnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743842800;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7f7cBX0ucvHfq4gITJ3CdfbZltrEyKi+/0QIALTbYvA=;
	b=D6CmHcPFDSz+B6bZ9XdAMdIsE6REKCzW1gYwvuO+o892lFyg08uDHs5srS7nV59YYLxUB7
	UssOhjpovAKFFWBg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Switch to use __htimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
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
Message-ID: <174384279935.31282.15296285237868629090.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     50177a8b2ec756a03f635444538da928dc5ac488
Gitweb:        https://git.kernel.org/tip/50177a8b2ec756a03f635444538da928dc5ac488
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:11 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 05 Apr 2025 10:30:17 +02:00

hrtimers: Switch to use __htimer_setup()

__hrtimer_init_sleeper() calls __hrtimer_init() and also sets up the
callback function. But there is already __hrtimer_setup() which does both
actions.

Switch to use __hrtimer_setup() to simplify the code.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
 

