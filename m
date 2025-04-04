Return-Path: <linux-tip-commits+bounces-4655-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D83A7BFAA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 16:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FDB1897DEF
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BBC1F4261;
	Fri,  4 Apr 2025 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ONxXrKsj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6V1EgE33"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305A51F416B;
	Fri,  4 Apr 2025 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777378; cv=none; b=jmhy4QzAp7Ab1klD1M52FIhWmLi6pk5dFBq6QDeecmUJ/f0XdLT8y//3mWtitJFWUAwTNDlPICaEVIasYbzcQ26o+7OiT3Tf2OaeHHNMVBdKKjZ1F8jvwqsw8uvVmzRJgTosVjimRbeUXLHorwuOxyvDKZ1k1vk9ve7rkhV5e4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777378; c=relaxed/simple;
	bh=BsJjzk6IWDEo2YRgzQyJjaj1jWuhTC8a/Eb6evCJ4jk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YLEXImfETF1vHObP27rbUXk1MaGQ4rLV1IJOe+xCjbPTyqGQjgR+bnJ2x/mFh1AXGI3InXj8xeQTX9W4043wrMyGWKtqHSesjqeW8IEXgAxFTdtrm7MI/88k+gHDYc5BCV2tysNKShBn8qJO3YvdPK07Wi/PsAvwozEn4DO0qZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ONxXrKsj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6V1EgE33; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 14:36:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743777374;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTrD/vjAJPen9BMCXLPY5PkHH2+QOnkeKh9oPv9Fflc=;
	b=ONxXrKsj7AVMUWWfnuHLyceIY/gxnE9kV1BpZ+VmbE6g+vIxeV3YvTJrwPUvcejN55X9RB
	3tI9D3/sb6qxnmtPjCYoAq3MOps60IggenBYZD2iErNviKECNM47vaZNpFTbdXqHjHCl1u
	umwBM2//tYUPdTZPjViGYziSazJCqMdoaP0cH963Pjj7gPIcz4yYURM+NPyEOQjJPmjl/x
	5md4h31uRyRSxzBv/oI56/cPiQ1c7vpzQvYpgYrS29OHgGEszJ2VVfJxmPFllxjPjcfihR
	Flxvvvb6tWo8gmLTsjqr9i1a0kV88FjACi2sotMFXRZoGZLLEnGrrZYO7Uyuvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743777374;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTrD/vjAJPen9BMCXLPY5PkHH2+QOnkeKh9oPv9Fflc=;
	b=6V1EgE33eoJwrbRPMaWL+f85NBtSnVVeYesT3pSnVTt8DXEnw74NjtmPX5AUvDE1DXHxp/
	nEF4Gs3ieStvKxAQ==
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
Message-ID: <174377737331.31282.13890214575582800677.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     4be5eef55ab364ceac1aa3eaf78d2e443032b8c2
Gitweb:        https://git.kernel.org/tip/4be5eef55ab364ceac1aa3eaf78d2e443032b8c2
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 16:26:10 +02:00

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

