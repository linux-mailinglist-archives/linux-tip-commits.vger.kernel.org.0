Return-Path: <linux-tip-commits+bounces-5141-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACA3AA43CD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 09:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09A94C589F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 07:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293E920D505;
	Wed, 30 Apr 2025 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tOTGspgT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dmjJQMbn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652F620C038;
	Wed, 30 Apr 2025 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745997746; cv=none; b=YHR/rnE1kbMAi0hPxDZIPe80zCCPVQZfZ2v1ErXnkVJMhYYi69wBOFmkfKb5mlcv7CbwWM6P+NNacNHSpheN/ItZWwsBREDp39Zz6tmzMH8JTZ49gq488R1ilfao/MNcWNEXc1SalaDabTMJLwfTu6ZNR3jjXeTMvI22wfke3LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745997746; c=relaxed/simple;
	bh=9vOlsdyYz0oqRQggJmKJhJNLNTqunkbx318xFnwqjD0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SDSlvJkQxny1Lr+B4DqMCnBJKOidcyDU67KSv90mR8Xxjd/i1S7R0w0zbJ3xCxaXwe/VI9JOtfABYfRPkYjTn+mIE3prTVWkB2pIn31aLSpuPF2UugzvHEJeAjahx48UAb+tSH75P14CmAgLCQr8rmBATaUoX/6clmwyZOOt6qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tOTGspgT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dmjJQMbn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Apr 2025 07:22:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745997742;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jwqGfP6ipNqRR5ErbnK5eMpCjKlYWUpIyL7Fvi4ZvfI=;
	b=tOTGspgT6E9yHXeiNq+kbrViN2PYlzkKF1nGpisEJkC7KFad9zhU7LhLylhKeICjj8K7O3
	S7tRumUqr04QdPkytOzo6BYdh2PlKnp2bch+rVCoNaosvCgFOIeBbfkPClXectTlwXUq+y
	hH7aPR7JA6Sp9kBAmAMScqYghBxkk09uUhNtuwBVb8S8kk3deee/86KSjh9WfLlMr+JxPl
	AFVz3/kj8cSykOKWMJ65hGiP92fIdWBQFxBZORKg/yfKG9vlwks/YOoM6ylzGYPG6s4/rX
	aDvIZ4Ecq2x4CTgAR4t1ZLHOTgfiOJrEmFWjsSnoaVfMUkiXO3hsLRly/FaLWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745997742;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jwqGfP6ipNqRR5ErbnK5eMpCjKlYWUpIyL7Fvi4ZvfI=;
	b=dmjJQMbnO7fzCjBoAub/Kvetk272ZZooMWhbOYrqjMO1tcAvbQdXGQ0H7N0s9vZmpuOCQj
	1CacojYDNK9pQ+AQ==
From: "tip-bot2 for Su Hui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time/jiffies: Change register_refined_jiffies() to
 void __init
Cc: Su Hui <suhui@nfschina.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250430032734.2079290-2-suhui@nfschina.com>
References: <20250430032734.2079290-2-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174599774175.22196.10917731514907157768.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     007c07168ac0c64387be500f6604b09ace3f3bdc
Gitweb:        https://git.kernel.org/tip/007c07168ac0c64387be500f6604b09ace3f3bdc
Author:        Su Hui <suhui@nfschina.com>
AuthorDate:    Wed, 30 Apr 2025 11:27:32 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 30 Apr 2025 09:06:23 +02:00

time/jiffies: Change register_refined_jiffies() to void __init

register_refined_jiffies() is only used in setup code and always returns 0.
Mark it as __init to save some bytes and change it to void.

Signed-off-by: Su Hui <suhui@nfschina.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250430032734.2079290-2-suhui@nfschina.com
---
 include/linux/jiffies.h | 2 +-
 kernel/time/jiffies.c   | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 0ea8c98..91b2078 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -59,7 +59,7 @@
 /* LATCH is used in the interval timer and ftape setup. */
 #define LATCH ((CLOCK_TICK_RATE + HZ/2) / HZ)	/* For divider */
 
-extern int register_refined_jiffies(long clock_tick_rate);
+extern void register_refined_jiffies(long clock_tick_rate);
 
 /* TICK_USEC is the time between ticks in usec assuming SHIFTED_HZ */
 #define TICK_USEC ((USEC_PER_SEC + HZ/2) / HZ)
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index bc4db9e..34eeaca 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -75,13 +75,11 @@ struct clocksource * __init __weak clocksource_default_clock(void)
 
 static struct clocksource refined_jiffies;
 
-int register_refined_jiffies(long cycles_per_second)
+void __init register_refined_jiffies(long cycles_per_second)
 {
 	u64 nsec_per_tick, shift_hz;
 	long cycles_per_tick;
 
-
-
 	refined_jiffies = clocksource_jiffies;
 	refined_jiffies.name = "refined-jiffies";
 	refined_jiffies.rating++;
@@ -100,5 +98,4 @@ int register_refined_jiffies(long cycles_per_second)
 	refined_jiffies.mult = ((u32)nsec_per_tick) << JIFFIES_SHIFT;
 
 	__clocksource_register(&refined_jiffies);
-	return 0;
 }

