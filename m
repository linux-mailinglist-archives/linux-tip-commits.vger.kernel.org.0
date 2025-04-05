Return-Path: <linux-tip-commits+bounces-4695-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F76A7C84B
	for <lists+linux-tip-commits@lfdr.de>; Sat,  5 Apr 2025 10:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AFE43B78E8
	for <lists+linux-tip-commits@lfdr.de>; Sat,  5 Apr 2025 08:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652B51DBB19;
	Sat,  5 Apr 2025 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Coaf6DF/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HwxhPHcp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33D719F495;
	Sat,  5 Apr 2025 08:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743842804; cv=none; b=HiiQIeCqGekl7B80erVA1E3niQXhnTfWPSSoW110oVH0Auq7Rffc3NepK1nj7secsf/sa7tt3Puj+bLSzk6Cflu8gUr1sRMkrYGYmMXasGn17bl002Cx9i7ArjNhdDUANQkoxyu3V/MnueP3+UbYt3ep2ypb9LUH6TgbMeG7hiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743842804; c=relaxed/simple;
	bh=GlPn0908UzrC07DfI7gTgI/SKb07ptkDzOwBEDwZPGc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ALB6AHW9TsddGAWO7bIX/cfEpe3UKiB8T6NB8hdr8TTqvTG4cpN5f9syhr16tUy06jTMwKJUtht1yZSKBgSaBZzfDLPMvrHBC9LbtswoSh7t5/4wtw0ZHaw1J9A+1Moqj8QduqY6j9S5pANvxQbvC+e2tAVnCQg1GgfnzM81JFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Coaf6DF/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HwxhPHcp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 05 Apr 2025 08:46:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743842793;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R2BVXczvDBhZK3wccapgjs0ivCGnuiUdizVO4xc7cKo=;
	b=Coaf6DF/hNs/ilKWe0LzDLFGPjXDynAUEMh8/yIMM8bZnJi9YLMBEOcXylsX/0zZlmP5sA
	U8m8iljbHlLCk0XjAUhlrBCXvslNyg+59XUcoeNqXEW5K8O13J+eP1PZSVdtumxBSqgVvF
	nMlcc/LVmXzyD/YRaJFLmTDHnInwi8H6HDkSW3aAx08WsYZ2VOueCOykwhSZo+gOAh3Q8X
	COHCrsm50yGOfWACMCE8uOSjyQaWea4UkuFyqfwqiZBE9QcoQZE5INoGR9/pbI8DUX6J9W
	ZLtcFGhldioJfXXse2J1qe7cXvJsmEbUJ6KJ02ipZFYlUPShYzxgUVXfG0fnbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743842793;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R2BVXczvDBhZK3wccapgjs0ivCGnuiUdizVO4xc7cKo=;
	b=HwxhPHcpM337n9AH9bAZAkuvNMrzru1JMTEbFnNmWmI8UFVTXhXSZc+iJsfSnZrg0cSwAu
	C9u45SdfHof+WjBg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Rename debug_init_on_stack() to
 debug_setup_on_stack()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
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
Message-ID: <174384279261.31282.11456944974988835609.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     59c9edafc0f3843c3e616eb8136a310c7c552595
Gitweb:        https://git.kernel.org/tip/59c9edafc0f3843c3e616eb8136a310c7c552595
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:20 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 05 Apr 2025 10:30:17 +02:00

hrtimers: Rename debug_init_on_stack() to debug_setup_on_stack()

All the hrtimer_init*() functions have been renamed to hrtimer_setup*().
Rename debug_init_on_stack() to debug_setup_on_stack() as well, to keep the
names consistent.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

