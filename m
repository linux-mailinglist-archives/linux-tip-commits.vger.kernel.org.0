Return-Path: <linux-tip-commits+bounces-2803-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C9D9BFC0A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A231C218B6
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82DDD268;
	Thu,  7 Nov 2024 01:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NOaED8yI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nVxC0aeg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD6411712;
	Thu,  7 Nov 2024 01:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944778; cv=none; b=J/9XAyR2S3tfyKeB88zwin0Z9YslPVNDLZ/CBsSrTHDXB9/W4hddJMIiWs06iAwW0s6bFtBd8q2dRdvLxb7ThsY34fShS1J63pnsaURR4euqnD5WarmBy3cTQbRdSfr0Y2bHPkwUTBEvYzdfLS0OcyOs6YhD+IJ1mFrpNUuPNos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944778; c=relaxed/simple;
	bh=ADhtmGjNuzfTVzIeB5Enp/mY62svkA12VTWCK6ycMI4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BBjbMfIEUddKDL39WkIA1dg11G2Os/fgquzSTldAYunKxc+x2ElvRVapKSOd2c0gyYsgLcnaNWuz07e9mlIM0c1ibKNai2I2KrtJHz7EmhvWqJl0tH0wLgHzxHDRN9zLer+i+HYaWeObq6Zm64m7DKZCxZUGbE0Bxu6BiYkoa1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NOaED8yI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nVxC0aeg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:59:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944775;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvTePZF2zA8L+yIIqE2dBy/1BR2XdYXNt64BjojYNZg=;
	b=NOaED8yIHPp7UKBUbbEAaBiYi5ydSkkkAOqrB6T8zRl9LmufEOHa2jybEPW3q3NXnDwooK
	/JsLUrM0ohqbVbmNfxhfCabAugifObLcDzq4fA1Rq2AjdHQGSL8lNiDB1Gr+qQfQ8X01Nf
	qh+CowiarYHKEc1fC0S4PTO6F+xQP3VMQAD2uU4CBV79UCkKkX9D68AHxSBjahqpsAo0Fq
	m7ICs0MQq+W3u5ZKq8ZC5wyPL7PkAVu88hRvzSMpAIeUDJmHLqABdnUowdeSA+cpXfsjxH
	ZKDvVQJ4gMuoq011QxP1gd5rbNlsEff5AgknTX8XZwYuQQWzheZFAGjJSCWFng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944775;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvTePZF2zA8L+yIIqE2dBy/1BR2XdYXNt64BjojYNZg=;
	b=nVxC0aegaGG+qmsimWOF+lTpdnOzCjNsdn1k93Xyjz1bZPIddIuJTC0rQh3WVG6sfeHzOC
	xvV6dreJfeL8jrDQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimers: Delete hrtimer_init_on_stack()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C510ce0d2944c4a382ea51e51d03dcfb73ba0f4f7=2E17303?=
 =?utf-8?q?86209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C510ce0d2944c4a382ea51e51d03dcfb73ba0f4f7=2E173038?=
 =?utf-8?q?6209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094477419.32228.13900253022627837826.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3c2fb0152175f9f596b40763cdc1378297da60af
Gitweb:        https://git.kernel.org/tip/3c2fb0152175f9f596b40763cdc1378297da60af
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 31 Oct 2024 16:14:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:47:07 +01:00

hrtimers: Delete hrtimer_init_on_stack()

hrtimer_init_on_stack() is now unused. Delete it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/510ce0d2944c4a382ea51e51d03dcfb73ba0f4f7.1730386209.git.namcao@linutronix.de

---
 include/linux/hrtimer.h |  2 --
 kernel/time/hrtimer.c   | 17 -----------------
 2 files changed, 19 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 4e4f04b..7ef5f7e 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -230,8 +230,6 @@ extern void hrtimer_init(struct hrtimer *timer, clockid_t which_clock,
 			 enum hrtimer_mode mode);
 extern void hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*function)(struct hrtimer *),
 			  clockid_t clock_id, enum hrtimer_mode mode);
-extern void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t which_clock,
-				  enum hrtimer_mode mode);
 extern void hrtimer_setup_on_stack(struct hrtimer *timer,
 				   enum hrtimer_restart (*function)(struct hrtimer *),
 				   clockid_t clock_id, enum hrtimer_mode mode);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 376b818..55e9ffb 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1630,23 +1630,6 @@ void hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*function)(struc
 EXPORT_SYMBOL_GPL(hrtimer_setup);
 
 /**
- * hrtimer_init_on_stack - initialize a timer in stack memory
- * @timer:	The timer to be initialized
- * @clock_id:	The clock to be used
- * @mode:       The timer mode
- *
- * Similar to hrtimer_init(), except that this one must be used if struct hrtimer is in stack
- * memory.
- */
-void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t clock_id,
-			   enum hrtimer_mode mode)
-{
-	debug_init_on_stack(timer, clock_id, mode);
-	__hrtimer_init(timer, clock_id, mode);
-}
-EXPORT_SYMBOL_GPL(hrtimer_init_on_stack);
-
-/**
  * hrtimer_setup_on_stack - initialize a timer on stack memory
  * @timer:	The timer to be initialized
  * @function:	the callback function

