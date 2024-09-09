Return-Path: <linux-tip-commits+bounces-2210-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABD2971D53
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 16:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A3FBB22A7D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 14:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E40B1BBBFE;
	Mon,  9 Sep 2024 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="auuqNEXO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CaAOdA75"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0E01BBBFD;
	Mon,  9 Sep 2024 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893966; cv=none; b=Zg3h5tHNjTYltTtsJfQO7RgZBx4iqCZTfY7L0CrqeJbZPRvjng/OzRcLwGs/u76EzsahdLBgdkTWJLhvqNUh5u5Gt1Vuu85mTqEiQAZizrHldVaFWnl73DkqrgG+fCpTh+LBfCbpdfJ3OtarAqNcOmSZIjQpNxb7F8DDcRgRAtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893966; c=relaxed/simple;
	bh=JM0dE9diSaIWxy1iMpjHTN1l6rPyxO6T3y8z7MDdK/U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FNk8wWw+0K+93xNwbx8fHqNm7F9Tm/96I06owpPRNQAkSdoF5gfOyf6JoP9jVvO7MFmz5P9RwltTTOCsR2KRrajPdZ3UqgYoKPx7ztxLvaygyoZYPC3V4YsEU5e34hex6OrpMV87zi3PWWaX670x769RuJMg6PjsUUvWTlznUCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=auuqNEXO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CaAOdA75; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 14:59:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725893962;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DHIF+dTwPL5+ns4F116MKpT1rNHZAMeiU5VrE/OgeOY=;
	b=auuqNEXOw7V4qs186JyVgvU7n9wuB7qeLanuOZtTvhnbClue8Ph/XzTc7WpNlUBBtRmqn2
	zoOUOzBZJcXrbmbYz4pr1tqNkuYkys4fGno4CpVVIQduG8u/tr0vnSPYXODRn6CKdK2JGb
	OnRf/2zgEg+FaL2fg+FzD/H2HarhVY5PzGvsfx8dx61FwJcRm6S9Gu0wDa5SNUCHfdK+LI
	NqirsSDvC8qA82Q7mtahUiIVhGcbIhwhNOiQqK4S+8uWEWG4VlmFWtJ/i1XgEzZHiRVyQl
	pnT6+aTQkpg4z9LjmOOH2qRFfCKa+JBq/IQ9WfJbG5t0slZuJhP4+fLfD8lhQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725893962;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DHIF+dTwPL5+ns4F116MKpT1rNHZAMeiU5VrE/OgeOY=;
	b=CaAOdA75srx8sZTaIxr4E7DzWkuU4q/oYPPsZMsaM9c1NZpNj7rQuj4pceO8wvsPFk4v2o
	v5jtHD3WacCCvZBg==
From: "tip-bot2 for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/debugobjects] debugobjects: Remove redundant checks in fill_pool()
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240904133944.2124-4-thunder.leizhen@huawei.com>
References: <20240904133944.2124-4-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172589396211.2215.5668953664849792936.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     63a4a9b52c3c7f86351710739011717a36652b72
Gitweb:        https://git.kernel.org/tip/63a4a9b52c3c7f86351710739011717a36652b72
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Wed, 04 Sep 2024 21:39:41 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 09 Sep 2024 16:40:26 +02:00

debugobjects: Remove redundant checks in fill_pool()

fill_pool() checks locklessly at the beginning whether the pool has to be
refilled. After that it checks locklessly in a loop whether the free list
contains objects and repeats the refill check.

If both conditions are true, it acquires the pool lock and tries to move
objects from the free list to the pool repeating the same checks again.

There are two redundant issues with that:

      1) The repeated check for the fill condition
      2) The loop processing

The repeated check is pointless as it was just established that fill is
required. The condition has to be re-evaluated under the lock anyway.

The loop processing is not required either because there is practically
zero chance that a repeated attempt will succeed if the checks under the
lock terminate the moving of objects.

Remove the redundant check and replace the loop with a simple if condition.

[ tglx: Massaged change log ]

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240904133944.2124-4-thunder.leizhen@huawei.com

---
 lib/debugobjects.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 6329a86..5ce473a 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -135,15 +135,13 @@ static void fill_pool(void)
 		return;
 
 	/*
-	 * Reuse objs from the global free list; they will be reinitialized
-	 * when allocating.
+	 * Reuse objs from the global obj_to_free list; they will be
+	 * reinitialized when allocating.
 	 *
-	 * Both obj_nr_tofree and obj_pool_free are checked locklessly; the
-	 * READ_ONCE()s pair with the WRITE_ONCE()s in pool_lock critical
-	 * sections.
+	 * obj_nr_tofree is checked locklessly; the READ_ONCE() pairs with
+	 * the WRITE_ONCE() in pool_lock critical sections.
 	 */
-	while (READ_ONCE(obj_nr_tofree) &&
-	       READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
+	if (READ_ONCE(obj_nr_tofree)) {
 		raw_spin_lock_irqsave(&pool_lock, flags);
 		/*
 		 * Recheck with the lock held as the worker thread might have

