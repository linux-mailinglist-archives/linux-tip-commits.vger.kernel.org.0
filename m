Return-Path: <linux-tip-commits+bounces-4676-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F082A7C283
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 19:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3902317CACE
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE5321D3F9;
	Fri,  4 Apr 2025 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h9Q0M/L0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="15T5ehBq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD4321930D;
	Fri,  4 Apr 2025 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788053; cv=none; b=m2nG1YG8jQ2Sxc3GWxiQ9kWj+JgdYuWWBYyPqIhyVeKji9jqIWPPRQrmj8ouu3gyhZbiEaBYAMx5mT6TULy3kQol6dg6K4QrJr3RYlaPmOoOXt8D8oA4Bd3KVBKP5GKDm4MtnTTmTQ6mZwH0yV2zaKhQ1/ghyJDHCO5Xf0sWADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788053; c=relaxed/simple;
	bh=+aIgrsYUQlJG570bhtBEpQftbFOsKhfkkKQV5C0XX/4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IfbIcDEm37mTg4H4ZY6c9ptFIVv8dJ2UkU5OrpjI3SbrHndRXU6zRJOAzBboOT1aZJRBtp2lb1WgUUTGyJROK5SVcfFLk/aodeuWI1ScRcbItWQDhjFz8my/k1n166NRrVruNyJZvZQ7x7m9z+8OmF4QwzwlqZ5A6fTE2KBAzUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h9Q0M/L0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=15T5ehBq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 17:34:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743788048;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4reJS6kIq9X1ORjX7ybr1mvSsuOI14AYUg+LheMKcBo=;
	b=h9Q0M/L0OHx4GQ9lwUQPWg+zfa/Hi4Dqd2bsjBOgsTsTMARRiipjY9Pruu7Wx1/9i2Ztj8
	3rYUk6yp46TR1wzPrVks2V9ySMynnAwDf9AYyxf3V1WCltFrTyDQX+bA3GB6mJvLf56ExA
	YAd/RkEeE6HssIUvQenxxkntaL9cAZLEi0//B3l1kgOWz4dgMxZr6rjjjyhTva6GoRknr9
	7tSi5aGJ5H7QxIJQHcv+DXKr+eHuXJNR2HWvX0SfzxAIBENYn69FV37T4q2H3YkdfTcPkn
	LT5p7uDQRFIV6LZBMJI1/QyBJ+UlXgRQuLSz9UaqBoWb/ei9Fx5zYNK2JaXkfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743788048;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4reJS6kIq9X1ORjX7ybr1mvSsuOI14AYUg+LheMKcBo=;
	b=15T5ehBqqc6VM0YZBNwHR1LnCUCSMTO0HFp90K34xvXtYFLzIRs+CHFr+MhMgCYfw0ZUQu
	3U1PLY+/2dkBcEDA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Rename debug_init_on_stack() to
 debug_setup_on_stack()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C073cf6162779a2f5b12624677d4c49ee7eccc1ed=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C073cf6162779a2f5b12624677d4c49ee7eccc1ed=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174378804420.31282.7274735423434317449.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     8ae61bc860c532ca1ae394797f8fff77a88e62ab
Gitweb:        https://git.kernel.org/tip/8ae61bc860c532ca1ae394797f8fff77a88e62ab
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 19:26:44 +02:00

hrtimers: Rename debug_init_on_stack() to debug_setup_on_stack()

All the hrtimer_init*() functions have been renamed to hrtimer_setup*().
Rename debug_init_on_stack() to debug_setup_on_stack() as well, to keep the
names consistent.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/073cf6162779a2f5b12624677d4c49ee7eccc1ed.1738746927.git.namcao@linutronix.de

---
 kernel/time/hrtimer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 472c298..4bf91fa 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -471,8 +471,8 @@ static inline void debug_setup(struct hrtimer *timer, clockid_t clockid, enum hr
 	trace_hrtimer_init(timer, clockid, mode);
 }
 
-static inline void debug_init_on_stack(struct hrtimer *timer, clockid_t clockid,
-				       enum hrtimer_mode mode)
+static inline void debug_setup_on_stack(struct hrtimer *timer, clockid_t clockid,
+					enum hrtimer_mode mode)
 {
 	debug_hrtimer_init_on_stack(timer);
 	trace_hrtimer_init(timer, clockid, mode);
@@ -1665,7 +1665,7 @@ void hrtimer_setup_on_stack(struct hrtimer *timer,
 			    enum hrtimer_restart (*function)(struct hrtimer *),
 			    clockid_t clock_id, enum hrtimer_mode mode)
 {
-	debug_init_on_stack(timer, clock_id, mode);
+	debug_setup_on_stack(timer, clock_id, mode);
 	__hrtimer_setup(timer, function, clock_id, mode);
 }
 EXPORT_SYMBOL_GPL(hrtimer_setup_on_stack);
@@ -2064,7 +2064,7 @@ static void __hrtimer_setup_sleeper(struct hrtimer_sleeper *sl,
 void hrtimer_setup_sleeper_on_stack(struct hrtimer_sleeper *sl,
 				    clockid_t clock_id, enum hrtimer_mode mode)
 {
-	debug_init_on_stack(&sl->timer, clock_id, mode);
+	debug_setup_on_stack(&sl->timer, clock_id, mode);
 	__hrtimer_setup_sleeper(sl, clock_id, mode);
 }
 EXPORT_SYMBOL_GPL(hrtimer_setup_sleeper_on_stack);

