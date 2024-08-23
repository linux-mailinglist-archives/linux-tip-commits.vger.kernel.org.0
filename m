Return-Path: <linux-tip-commits+bounces-2095-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FC395D53A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2024 20:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17B14B20F05
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2024 18:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722A41917EC;
	Fri, 23 Aug 2024 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e0MFSEyY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WJve/7V9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A125A18E05B;
	Fri, 23 Aug 2024 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724437193; cv=none; b=nZi8yGFWAht+/iR6r+rDjbLyYa8hsEi9vMWYCF9BWYW42VYBqp7s3ygRx87YQqAcXK9PRjGtZJSUmfhChqvVBi4jzKvyuapGmSLzbDTQzwvmPXfdea73t1APCePIhSIak/mKokhxqxo6QbfhYNFC3/hpVisjb/KJQy1u/Dt9WC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724437193; c=relaxed/simple;
	bh=x5HHU0SBHuL9gbv/yKoeZWm4P0pIi2l2QWUYahKWuI8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HVIfTscSbugsvcWJgwiHvWpe/Z9YqX34uG2pQIu5tAnUDyCG2yUbkOjTIEuEtab9aDaAFQKF2GupCXAbFSV1f7V8iWl6qX1J7TqurC2DVE6qnIp/8pw4Y9gqOsYBQIZFKL8X9wCFTGeCwDk8mvNHn2/Dw5X3nnuILQ98Gl2U5ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e0MFSEyY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WJve/7V9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Aug 2024 18:19:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724437189;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7RqTooVElktesgJGQex7X/0e4odWmiKq6l4/sOY4/s=;
	b=e0MFSEyYColFaHIjLaCXtpRdIgJkwaz4kj/mM1q+k58w1QsNvetlcWFzi6thU2pExpmKHy
	MEy/yH0e3ngu4zdYfQtKQFSUracJEOaml4UEA8zCp/ET5D9AdWqht0FDdmY+imRoFh2xCk
	WnoJ40MLmNQoZYN5tklY1ydWM6EVAyKg/OD5UVSHRNovLx77n1DGtHRVBXQZVSyg23QdlS
	mZLI/MNOKhWEDXHO49shIW7Te/BeiRz+Txf7hk6KalJobIWFAJQTfvUhgeIvfUEl9ZZV+8
	zPibDhaNLMccKullEj/gtaYSpo9AvKtkuW/zeSjTGW/NLaGBUvB+xTZCMLPviA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724437189;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7RqTooVElktesgJGQex7X/0e4odWmiKq6l4/sOY4/s=;
	b=WJve/7V9DEKEVmgfqdCUupFK0Aefc0FI+xUEKrn76PYLKper0CzIppNscqoaKkCh6DhiiD
	24P1WA5OD9vHxnBw==
From: "tip-bot2 for Chen Yufan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Use time_after() in
 timekeeping_check_update()
Cc: Chen Yufan <chenyufan@vivo.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240822070717.12773-1-chenyufan@vivo.com>
References: <20240822070717.12773-1-chenyufan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172443718918.2215.9073356657150571388.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     42db2c2cb5ac3572380a9489b8f8bbe0e534dfc7
Gitweb:        https://git.kernel.org/tip/42db2c2cb5ac3572380a9489b8f8bbe0e534dfc7
Author:        Chen Yufan <chenyufan@vivo.com>
AuthorDate:    Thu, 22 Aug 2024 15:07:17 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Aug 2024 20:15:11 +02:00

timekeeping: Use time_after() in timekeeping_check_update()

The open coded comparison does not handle wrap arounds correctly.

Signed-off-by: Chen Yufan <chenyufan@vivo.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240822070717.12773-1-chenyufan@vivo.com

---
 kernel/time/timekeeping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 2fa87dc..4fa42a1 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -217,7 +217,7 @@ static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 	}
 
 	if (tk->underflow_seen) {
-		if (jiffies - tk->last_warning > WARNING_FREQ) {
+		if (time_after(jiffies, tk->last_warning + WARNING_FREQ)) {
 			printk_deferred("WARNING: Underflow in clocksource '%s' observed, time update ignored.\n", name);
 			printk_deferred("         Please report this, consider using a different clocksource, if possible.\n");
 			printk_deferred("         Your kernel is probably still fine.\n");
@@ -227,7 +227,7 @@ static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 	}
 
 	if (tk->overflow_seen) {
-		if (jiffies - tk->last_warning > WARNING_FREQ) {
+		if (time_after(jiffies, tk->last_warning + WARNING_FREQ)) {
 			printk_deferred("WARNING: Overflow in clocksource '%s' observed, time update capped.\n", name);
 			printk_deferred("         Please report this, consider using a different clocksource, if possible.\n");
 			printk_deferred("         Your kernel is probably still fine.\n");

