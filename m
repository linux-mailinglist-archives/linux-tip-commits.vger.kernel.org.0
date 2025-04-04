Return-Path: <linux-tip-commits+bounces-4656-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B36A7BFAB
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 16:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91BCB1898159
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 14:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217CA1F428D;
	Fri,  4 Apr 2025 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Smn1JH+h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vsyAjnIa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF371F416F;
	Fri,  4 Apr 2025 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777379; cv=none; b=Rsch4HjsFfZJFT7Sthry1HPo1w2LCE04qzKryIZcAUKnc2qKiAWIiNYEspCjAXqZci6mQjZVsv43XxmY0nt8dURkQLRAaY4kw7DIS9fy41dS7exoy0bnF+JPYOXWXoW2hUoBld5RTkyoA9wcCASXVwXNcn1GfQVRtgyFOIhN5fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777379; c=relaxed/simple;
	bh=0MXLLpaexIQLqj8WPK2utAOHFhtzWDmajOCnnMU8iWk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cML/NPxmokHuQbbJ3A4T70woVhQy+BhzQ+/TmHErqahYMr2IbJO+7viLCnqdyyOO0gUTMo8xzm0RiLKvScMt/WCd9/fgh5kzYqV09RFY5I3qYCINns52Xm/fke52mTBbPs0jh//t5t0Wf3ku9gNB+Vjfd5IJ7pgtf3TTpW3+D0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Smn1JH+h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vsyAjnIa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 14:36:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743777375;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGEZftOOwXgW9GAPIVop6FcEPvaRJMlhXJmVRR4r2tg=;
	b=Smn1JH+hiMHAU5+dzngQ35ip13hZ7qCfKf5y+EAJ6y/vvqzk2p3eUJaH/4a5YQB7iI5B0W
	EQ49iGraT/SQJpWVbdxrkMxGue5ogVkLYrF4heWICeaYVx2VMsN79S0budee8/AdfdMCfe
	oFrLAuVtKyhBZ97QcaNzzXJ08yRbC/5ytmOdax+9i3ZyfIIrgZ0nXxHYOKbVZkjJpQqknj
	+BmeapN6CH03Ilck7imlHNw9NP6moqFzfXs/2QGSIHdsRXvSD1ssSq9ttIF0a59YOraTll
	MEzvHdX4Rg87BEF6aEOylddrq+gcxevISm66jwPdErxj6i5XCQgCCJBAzBdbLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743777375;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGEZftOOwXgW9GAPIVop6FcEPvaRJMlhXJmVRR4r2tg=;
	b=vsyAjnIabxRVsWUJ0dBsVwWMUBb2AdyDDKDRz6sq+qz0KV9DnMZyibVFdPymSEzNlanhf9
	7nVLHsGwdfSPVbBg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Rename debug_init() to debug_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C4b730c1f79648b16a1c5413f928fdc2e138dfc43=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C4b730c1f79648b16a1c5413f928fdc2e138dfc43=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174377737462.31282.644203451896581867.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     e4c393ce7142ad710d72481219c53b41a6f2032b
Gitweb:        https://git.kernel.org/tip/e4c393ce7142ad710d72481219c53b41a6f2032b
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 16:26:10 +02:00

hrtimers: Rename debug_init() to debug_setup()

All the hrtimer_init*() functions have been renamed to hrtimer_setup*().
Rename debug_init() to debug_setup() as well, to keep the names consistent.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/4b730c1f79648b16a1c5413f928fdc2e138dfc43.1738746927.git.namcao@linutronix.de

---
 kernel/time/hrtimer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 8cb2c85..472c298 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -465,9 +465,7 @@ static inline void debug_hrtimer_activate(struct hrtimer *timer,
 static inline void debug_hrtimer_deactivate(struct hrtimer *timer) { }
 #endif
 
-static inline void
-debug_init(struct hrtimer *timer, clockid_t clockid,
-	   enum hrtimer_mode mode)
+static inline void debug_setup(struct hrtimer *timer, clockid_t clockid, enum hrtimer_mode mode)
 {
 	debug_hrtimer_init(timer);
 	trace_hrtimer_init(timer, clockid, mode);
@@ -1648,7 +1646,7 @@ static void __hrtimer_setup(struct hrtimer *timer,
 void hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*function)(struct hrtimer *),
 		   clockid_t clock_id, enum hrtimer_mode mode)
 {
-	debug_init(timer, clock_id, mode);
+	debug_setup(timer, clock_id, mode);
 	__hrtimer_setup(timer, function, clock_id, mode);
 }
 EXPORT_SYMBOL_GPL(hrtimer_setup);

