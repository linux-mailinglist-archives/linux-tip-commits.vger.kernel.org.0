Return-Path: <linux-tip-commits+bounces-2136-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D6196486A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Aug 2024 16:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5950E1F268A8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Aug 2024 14:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460831AED54;
	Thu, 29 Aug 2024 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uCjqAZoE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dh9q5bwR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E0C1AE861;
	Thu, 29 Aug 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941804; cv=none; b=ajE6yBrySjGbWTzeqZSNVoEsSIwGX+UNS/0MbqjpUaYshwU+NI+sQ2DZAs2i3hnrQYmzGUvUgA2nfzqR1Ig+Vw+JEbKRzA1REjH4NJBw6bNUNVHrHVOOSwVGD25bzJzE0EScYLHi3u9tKQTAwxXZ20pdX6eVBTMEGieS81fBhEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941804; c=relaxed/simple;
	bh=lPhCv5rqTEaj9deyj3AbFYfobgIk5CzGn6U89hPV9BI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iTP3NJDrQz29nYOs6I1+aZDdCXsvP1FCkunkjiJVJSTIE+6ZPdfH9v+JDF46hQ+kh7zBDiKQs5j5ok4rCuvmnrzlvSNfZNIyFNYdUV5iU/MwQxLYe4J6uoTFZiEKycCY7isxRBYf3Y1epc0gTVy6LjAv3rLbFK+r3RBVwQYcudE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uCjqAZoE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dh9q5bwR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 29 Aug 2024 14:29:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724941800;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88C8yUp2c0/M9UOaXiCJYgHrwn2J+ty+oepitP3t1MA=;
	b=uCjqAZoEGMBYaHwYAnn3YGHgDtjQBynp2oTiXnpITfX7SoyWCc8vNRaxw3RQZbfTeKsyKv
	KmLmNrjnkwzwiIZahABPKkLZgkHLapq26d/PfIMjAliGhomWuTk9WbUjDSv8C8VaXU5a6M
	xMz8c3xh1vfRfkZvoANQV/VHtbU328oRHgmjEuUuhJFWhsSWugunhXifWk4CHmuGLGvFa1
	AOSt2R6vEi5/r6m6jzE9iOjFEwIMoQxKrl0WW/+W0hODnlkf0XdKJB/auhge+mM3PJSqmf
	dhcjoxpYZ0QXwyGF+C70gBHVIU0eCtqfzcjcTeF8fTsTA7Qosu5Kx7ccVggPIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724941800;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88C8yUp2c0/M9UOaXiCJYgHrwn2J+ty+oepitP3t1MA=;
	b=Dh9q5bwRN7opQogqa0lbTj2gayJkHbMB50QlDX4sm9YwxObDtw/CjM33m2KZx1UxCSbV7V
	6+M8GNpOrsOfASAA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Remove historical extra jiffie for timeout
 in msleep()
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240829074133.4547-1-anna-maria@linutronix.de>
References: <20240829074133.4547-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172494179975.2215.7791907589691817396.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4381b895f544bb84b8cfb34ada64df67c9b2a4f0
Gitweb:        https://git.kernel.org/tip/4381b895f544bb84b8cfb34ada64df67c9b2a4f0
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Thu, 29 Aug 2024 09:41:33 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 29 Aug 2024 16:17:18 +02:00

timers: Remove historical extra jiffie for timeout in msleep()

msleep() and msleep_interruptible() add a jiffie to the requested timeout.

This extra jiffie was introduced to ensure that the timeout will not happen
earlier than specified.

Since the rework of the timer wheel, the enqueue path already takes care of
this. So the extra jiffie added by msleep*() is pointless now.

Remove this extra jiffie in msleep() and msleep_interruptible().

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/all/20240829074133.4547-1-anna-maria@linutronix.de
---
 kernel/time/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 429232d..d8eb368 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2732,7 +2732,7 @@ void __init init_timers(void)
  */
 void msleep(unsigned int msecs)
 {
-	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
+	unsigned long timeout = msecs_to_jiffies(msecs);
 
 	while (timeout)
 		timeout = schedule_timeout_uninterruptible(timeout);
@@ -2746,7 +2746,7 @@ EXPORT_SYMBOL(msleep);
  */
 unsigned long msleep_interruptible(unsigned int msecs)
 {
-	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
+	unsigned long timeout = msecs_to_jiffies(msecs);
 
 	while (timeout && !signal_pending(current))
 		timeout = schedule_timeout_interruptible(timeout);

