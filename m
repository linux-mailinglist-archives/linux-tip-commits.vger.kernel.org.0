Return-Path: <linux-tip-commits+bounces-4684-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87B8A7C2E5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 19:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835043B785E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A18E219313;
	Fri,  4 Apr 2025 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NGiApybb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lzWta90Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA0420ADD8;
	Fri,  4 Apr 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743789276; cv=none; b=ViIdldV3UfskU0/pOxgZxYzpF53a7ZM2Guw2z2mvtPCLk2YVEkf33slNE/m/l8JNCqBHpVuDrJivMLRfH3F9pMx384P/ecijsiDKXNBY0N4feYD63fJD5CYeTDq5rMo9oJJ8iEo1YvpNoauo10J+c/k5fj+/OgrpExzUtXQkOe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743789276; c=relaxed/simple;
	bh=FF5lNFZoXP8BV9H7u53J+lvmPN2gRSsfC3sKjksnSMk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nm809kYUoZ35XvNfd7QadO4e8lz8ptc5/kkb9iqDxbl5Q8l3pPLpFM5+s4HC5VCE3BCTdFaRTFGWr6ScUYMHuH29wEgtcyy2Paylrs2AJ9lduXvmtiXzp5/XJvjFoGHE6XPYhDxF2BsmfAH7gfDU16aOZWoQ2JAY640pW1XlsGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NGiApybb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lzWta90Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 17:54:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743789273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IEFJRO7J/e79e7EMUY38TrMg6EafizVxz/TWO9tA+gQ=;
	b=NGiApybbMKG1xGeNjyB1elrvXNlsIxi8bVdbCQp0lwhKcHLvjWgEfiT71Mq39vH8wSvdCH
	PvRkTetNYOjxg8N6G/KnmpZNwqvLOJiKe0WZAyis8nawD+clShSj6HPRqMpsDbJzjrnnUh
	Ngcdss7b2tHXMqA+FLg/TliMt/5d8GLNGCW/+9hcbaehWGd7g7B07IJ0e6ZXuRCPqImQG9
	165r+BCsCSqzNKiGvbV6sXjXkRecMRU/rbwfSro2K/LHnYaFnf44aKwaUE/j8Os8d11dxW
	2yZtYsEmms47jgqbVtqeFejnOXIpnxOt4s+cgvj+MhKHZoyW307MuHiSOOZB/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743789273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IEFJRO7J/e79e7EMUY38TrMg6EafizVxz/TWO9tA+gQ=;
	b=lzWta90Z9kgQTU3IWf32So3nSa2QGDwwBydDJ6LxbPiYWaibXjURh706wNEvvW3YZ4UUgE
	Z8cGqUz+ucIRDyBA==
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
Message-ID: <174378927257.31282.13128569756433879412.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     d83e17721ede8d83d20c4261dd308ac553ed720f
Gitweb:        https://git.kernel.org/tip/d83e17721ede8d83d20c4261dd308ac553ed720f
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 19:46:07 +02:00

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

