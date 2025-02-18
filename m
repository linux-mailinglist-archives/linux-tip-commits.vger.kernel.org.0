Return-Path: <linux-tip-commits+bounces-3422-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 168FFA397A5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9CA23B812E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250BA241139;
	Tue, 18 Feb 2025 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DL/8w11r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nu10YQmP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC9C23FC61;
	Tue, 18 Feb 2025 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872002; cv=none; b=S+bdi22/BfAALHAlf4E64FCQF2t7NOY84dpNLziHfCj6Gs9B9ESsEvWkG7O/ZFJLDKUe13gy+/v0NWzi+rEKrjpShbdeEUBY07hNuAZJwKrart927pGPu23yIEaDmZm1QYWos7Q/4lTZOYFcllj0CpYG9sBgV7cFuW/O9/WOGZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872002; c=relaxed/simple;
	bh=wrup2CpQuZgVLdh9fZ0iGH65gAmstNbiFW8+4X9BK5A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=s3ZnCEktYv6eDc4yXO++WrZ5TyGia+rFmLqu4yuVJ/SvSAbM5mFTDheQi5xWrg68YNwfUxGLem0XUU1T6Ej5Y/sueF+d7srCtBZdRqgg/5iBbRVqX3ym0RN0ZHW2xUjXtvEt0CAW5SEYUfJsZUw6B94UxCq2WLVi3/r4C95Bj6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DL/8w11r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nu10YQmP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739871998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cDbwfFp//NYW1u+i6riFR7BQ22bYnKHPpz3UEiN5e0=;
	b=DL/8w11r34Ru7ZVYwx30pLefLAGLhVkQRDSukkBLMsDDOSiWOW74guhc77+nH3v9rMZNuQ
	LvBd1Bj8+HNTTcRpwX6qXGsQSjG1QJds+1eNu5gX/GoBogHBaNLXBsWUIlH0fNHD4bsK7F
	HlU7gRpvm5WUQ+6eQ6a7c0nAHlzZ5c0sJgWHmTHvANMfyx1lhNXrnFw/vYs2T7Nh7rrLqM
	EmOPGLZhKLChOP4fvh/NSPm0rFWt5Ryx5gJZJ58+x8+l8q++btG5P8Co/AvIkDknTJc5nT
	DDE7vwIc5RTVvxbG9aSgEXqW3af86RZPdOZLv+K7xN5x8b6vNO7hWkfXrqMTpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739871998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cDbwfFp//NYW1u+i6riFR7BQ22bYnKHPpz3UEiN5e0=;
	b=nu10YQmPUvACuDN+7tL7EKkLdJWk6fAjAT5zXx0k7nseNmHqigRaDwZ8yA7g2VffQL1fjA
	C6bJIsBDZmzWo1CA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] mm/slab: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C030065d66630068f788caf9df15756fad404e754=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C030065d66630068f788caf9df15756fad404e754=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987199757.10177.14299572489434327906.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     53867760f50c2b5b6b16f1350135553dda88c461
Gitweb:        https://git.kernel.org/tip/53867760f50c2b5b6b16f1350135553dda88c461
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:38:58 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:32 +01:00

mm/slab: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/all/030065d66630068f788caf9df15756fad404e754.1738746821.git.namcao@linutronix.de

---
 mm/slab_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 4030907..59578da 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1887,8 +1887,8 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 				&krcp->page_cache_work,
 					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
 		} else {
-			hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-			krcp->hrtimer.function = schedule_page_work_fn;
+			hrtimer_setup(&krcp->hrtimer, schedule_page_work_fn, CLOCK_MONOTONIC,
+				      HRTIMER_MODE_REL);
 			hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
 		}
 	}

