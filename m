Return-Path: <linux-tip-commits+bounces-2671-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0329B7802
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 10:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37A0288C4F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 09:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE6A19B595;
	Thu, 31 Oct 2024 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="se2Khv+X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9k+60SCN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347AA199FCC;
	Thu, 31 Oct 2024 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368283; cv=none; b=g9HaB/95/uLb5DU4JEOT9eQpOU9p8f8A5SSrdkUTnJzhNue5jm8/xTT44egkrex/CUcvq5Il+hBWXeT6U8iRQ1Iz6j1BrS+gwqDXFIaRcg8O1S3dJLyUMWv4GysHUHX5tHFCsvzKoYB9GewB+0VEhJVx6dvBGuLUtzq+b1mk4Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368283; c=relaxed/simple;
	bh=q4umpjQpr0ENy1hPq8EiCPEfWJQeRyeW+Mvgj8LmPFQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UBIrTP9aujNPRDhBXP//o/4CEr6g3oulwMNEGJfjeNSLH1myBUN8zTbfE9w9avmkXtKnNl+uxpnSFQm23xJ+Vd+AU29ZdT/E9GP0sxb1hyq5HdBRyMbf9rFAn2jplRozEKNzcCRIzF8eWTgFTscDUY0K69YF8QFKwMvoLFZgrOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=se2Khv+X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9k+60SCN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 09:51:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730368279;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TKSvaX5ifwZYCtvZYrP1upl15hMrNvetvRxeRHh0qyw=;
	b=se2Khv+XI1XdB6suvjBaQMWdkIt+qLyix+VqlgRBj1psaV559aPJgediszv+AAQQkbjIZf
	L5ZJvWs7V/C/GnkrxLwXNQ12xgR6lI8I2Aq+VvPZ7k7BvMm3qNLr2ZnY+RhnKhlHyQOavO
	Py0AOLe5oVVK0PQhZI7NJfHdVu/jrTOcC6KNPnS0Jw+mcXv1lHwUePHkFzdpT2l42OpXcj
	0v/5rB4Jc+fxj+FkXJ8G86g2RrgQKyyb+ZmF01KtZOIbf/5ichX3GgI5ctTRn/K0XvumIl
	pig/wpb0i2TJOW6IPwcgyvqhL1g8nOyY66pbonDz0Hu8xeeOev634edNQASKSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730368279;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TKSvaX5ifwZYCtvZYrP1upl15hMrNvetvRxeRHh0qyw=;
	b=9k+60SCNBFZiSgNeeVJ3NxoUypdmjg3KsUXJMaTUNP13fJW6MrlW2aYbbfHlR95Jr6e2MM
	CJF0+RxHr+LWWhAQ==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] clockevents: Improve clockevents_notify_released() comment
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241029125451.54574-2-frederic@kernel.org>
References: <20241029125451.54574-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173036827906.3137.8887881617356953747.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     17a8945f369ce2de2532ba8abdb93bb5b2d1c118
Gitweb:        https://git.kernel.org/tip/17a8945f369ce2de2532ba8abdb93bb5b2d1c118
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 29 Oct 2024 13:54:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 31 Oct 2024 10:41:42 +01:00

clockevents: Improve clockevents_notify_released() comment

When a new clockevent device is added and replaces a previous device,
the latter is put into the released list. Then the released list is
added back.

This may look counter-intuitive but the reason is that released device
might be suitable for other uses. For example a released CPU regular
clockevent can be a better replacement for the current broadcast event.
Similarly a released broadcast clockevent can be a better replacement
for the current regular clockevent of a given CPU.

Improve comments stating about these subtleties.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241029125451.54574-2-frederic@kernel.org

---
 kernel/time/clockevents.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 78c7bd6..4af2799 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -337,13 +337,21 @@ int clockevents_program_event(struct clock_event_device *dev, ktime_t expires,
 }
 
 /*
- * Called after a notify add to make devices available which were
- * released from the notifier call.
+ * Called after a clockevent has been added which might
+ * have replaced a current regular or broadcast device. A
+ * released normal device might be a suitable replacement
+ * for the current broadcast device. Similarly a released
+ * broadcast device might be a suitable replacement for a
+ * normal device.
  */
 static void clockevents_notify_released(void)
 {
 	struct clock_event_device *dev;
 
+	/*
+	 * Keep iterating as long as tick_check_new_device()
+	 * replaces a device.
+	 */
 	while (!list_empty(&clockevents_released)) {
 		dev = list_entry(clockevents_released.next,
 				 struct clock_event_device, list);

