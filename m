Return-Path: <linux-tip-commits+bounces-2814-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFE99BFC21
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 03:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D37A1C21452
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DA9192D8F;
	Thu,  7 Nov 2024 01:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qahVe//4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZeVDs+pN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F701190049;
	Thu,  7 Nov 2024 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944786; cv=none; b=UL1N4lU6X+Kv1k0O/+FF8aVVDjhynNID2F7ptGWhmzdEWn0xCxpfUhMyQDshKFaN1G/RHF/BJYnJfwHYukwG0+9Bn9XJo52XFLhbRBSCGlNIYmH1vBeJhgHAoQyvIqtQJ1qdDVLiVtY2lmb6DL69rVhBvIXznSdO1Ds4I23qWSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944786; c=relaxed/simple;
	bh=lQLUY8tfzD9g+Yfza3GXvDk3YZlxeeFH8FcEJAbaGj4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CM7dG48tjVV2uvYBOGlpeO59mTdiz5WKxa+wR7CRqL8WCDolfmcUrT+ztCX8SI+jMOmEICzLo1fIgdhFJYkoeKtMhYoMCO4C9xbTTVbHcyCd9kQdMQPyDLA/cquiBf8dQ8GFxLn9ImBUJFog7TM2oqPUZ7+S43q9Hptg314izk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qahVe//4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZeVDs+pN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:59:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944783;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dup5UW5H8QLoTjRWjt20uIdL1B/lDizMdrOlbprE84M=;
	b=qahVe//4PkPejCmDapJcAUep6tdECa4jyUoVWF4OiktnJpo7VWJT8jl/Yf13ce6cnW4Bnx
	3VFoz4sFIWT2adnZONERqjee8GgCvqM34sobA9aYn/LHghfI3p8emWs9F8Em4EGpFPXfxh
	BK67Iqlw0hmtoHdG8WvEYHd4SnypzsnERN5Uhy9u1V6+wf2InWvMap1jHs3Zm+TjYesyYt
	jbbbLgiFbywuXcxDB80gIMY8G6NIYnQ6etK1kKWcrJNlfVcFVgJWM3g9rEzG/NUhCKR3dR
	Yi/K1qohzRMX6jAyeg7YHavhHAqXslWd1rGKWyclp4fKQVhyUDKHCs+BtJhl1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944783;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dup5UW5H8QLoTjRWjt20uIdL1B/lDizMdrOlbprE84M=;
	b=ZeVDs+pNIsWHybIzZHC3QPc1r50etvjSvhsglbkwRQ4Jb3FZtX0s6zfuiyzyX3gFTO+n3U
	oJ6j0N6yq/0KbVDQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] hrtimers: Introduce hrtimer_setup_sleeper_on_stack()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C7b5e18e6dd0ace9eaa211201528cb9dc23752454=2E17303?=
 =?utf-8?q?86209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C7b5e18e6dd0ace9eaa211201528cb9dc23752454=2E173038?=
 =?utf-8?q?6209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094478267.32228.14961081519610756350.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c9bd83abfeb9a9b103e689b251ccff7a01be8366
Gitweb:        https://git.kernel.org/tip/c9bd83abfeb9a9b103e689b251ccff7a01be8366
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 31 Oct 2024 16:14:22 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:47:05 +01:00

hrtimers: Introduce hrtimer_setup_sleeper_on_stack()

The hrtimer_init*() API is replaced by hrtimer_setup*() variants to
initialize the timer including the callback function at once.

hrtimer_init_sleeper_on_stack() does not need user to setup the callback
function separately, so a new variant would not be strictly necessary.

Nonetheless, to keep the naming convention consistent, introduce
hrtimer_setup_sleeper_on_stack(). hrtimer_init_on_stack() will be removed
once all users are converted.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/7b5e18e6dd0ace9eaa211201528cb9dc23752454.1730386209.git.namcao@linutronix.de

---
 include/linux/hrtimer.h |  2 ++
 kernel/time/hrtimer.c   | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 2da513f..48872a2 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -238,6 +238,8 @@ extern void hrtimer_setup_on_stack(struct hrtimer *timer,
 extern void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
 					  clockid_t clock_id,
 					  enum hrtimer_mode mode);
+extern void hrtimer_setup_sleeper_on_stack(struct hrtimer_sleeper *sl, clockid_t clock_id,
+					   enum hrtimer_mode mode);
 
 #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
 extern void destroy_hrtimer_on_stack(struct hrtimer *timer);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index daee4e2..1d1f5c0 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2065,6 +2065,20 @@ void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
 }
 EXPORT_SYMBOL_GPL(hrtimer_init_sleeper_on_stack);
 
+/**
+ * hrtimer_setup_sleeper_on_stack - initialize a sleeper in stack memory
+ * @sl:		sleeper to be initialized
+ * @clock_id:	the clock to be used
+ * @mode:	timer mode abs/rel
+ */
+void hrtimer_setup_sleeper_on_stack(struct hrtimer_sleeper *sl,
+				    clockid_t clock_id, enum hrtimer_mode mode)
+{
+	debug_init_on_stack(&sl->timer, clock_id, mode);
+	__hrtimer_init_sleeper(sl, clock_id, mode);
+}
+EXPORT_SYMBOL_GPL(hrtimer_setup_sleeper_on_stack);
+
 int nanosleep_copyout(struct restart_block *restart, struct timespec64 *ts)
 {
 	switch(restart->nanosleep.type) {

