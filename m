Return-Path: <linux-tip-commits+bounces-2142-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF633967152
	for <lists+linux-tip-commits@lfdr.de>; Sat, 31 Aug 2024 13:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844A51F220EF
	for <lists+linux-tip-commits@lfdr.de>; Sat, 31 Aug 2024 11:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9370917C23B;
	Sat, 31 Aug 2024 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r7rmWNMq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+GLn1eiP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A0D19BB7;
	Sat, 31 Aug 2024 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725104154; cv=none; b=IuqMj4hna4Pe5dewTER4riAyiFL92Oq+dv693pGPgYhCX3wbgTFNdHc6z3KQQw+4WUZaIKDLYI8IvSeF19ivL1FWHGkVGmCVJQcDhBEwdeuVBACFLGpfweeZQjB2tw0J8js4j7SMOV192pzzVh2cUyvM2UVQex6gN3ZumkcDFFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725104154; c=relaxed/simple;
	bh=p8/lDM0cC55G6RPKHtM0qwXyznkNlWGGqzepkmtlwjU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=CzTeRh52XOcULk9wROUjBTReRKzPmHcyGG9S/donfWbJfThCyW4rsdfullyJBNmVk65Wvhbz5HZrqp7aFmaPWU9UyYlNISKTubc3tUte4b+afldCRbOmyObPxAXz+jkh0qD6Gac3daZ/GPiZw75EjFyx04W3NM5DMhLycHV0LUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r7rmWNMq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+GLn1eiP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 31 Aug 2024 11:35:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725104150;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=VAR6E5wOkXDgCvIIY1WZojham88gMqLKNVPqhToSA0k=;
	b=r7rmWNMqTQ8jID3WmPnD4FIeKl1MPKbEW04FZb3DakHiR0WYvUVwtvYlbq84VvplZqzw3O
	z83c2q1sStP9krGDv+sV8R1L+ciBkkOV34j/YOtrcjXIYKSOOwWZ4EfWIWHyi/GVtDk+s1
	JFY2xpWe0El893y+fl/S8CU8oWN4U+CbA7miS1hNv745n0hgFZ0dnOXRZaz775FVo2Uhsu
	Igrwlv1cvUD8ZCdw8C3VxV9zgnkYSWQVFCb+UOQuU3x8qh9rPZZ5FoIHwYely+DHmIMpPW
	PVPHf59Ki6VPLfd27SGcLdrN34Qpgnk7JIq3rfgjpWC+b8xk4B+OcOGoNzhOpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725104150;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=VAR6E5wOkXDgCvIIY1WZojham88gMqLKNVPqhToSA0k=;
	b=+GLn1eiPkwG9DmczeBbRt5xC3QEFt9HljgbqmanaNKxQAlgHHIJNaFNVm2uas/LgMvBhYz
	EHlxBjMKNPZEQwAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] Revert "timekeeping: Use time_after() in
 timekeeping_check_update()"
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172510414774.2215.15979645843783952294.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/core branch of tip:

Commit-ID:     908c1217c074b83222cdb88235bd940e51463244
Gitweb:        https://git.kernel.org/tip/908c1217c074b83222cdb88235bd940e51463244
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 31 Aug 2024 13:26:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 31 Aug 2024 13:26:26 +02:00

Revert "timekeeping: Use time_after() in timekeeping_check_update()"

This reverts commit 42db2c2cb5ac3572380a9489b8f8bbe0e534dfc7.

Due to build warnings.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timekeeping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 6cda65d..5391e41 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -217,7 +217,7 @@ static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 	}
 
 	if (tk->underflow_seen) {
-		if (time_after(jiffies, tk->last_warning + WARNING_FREQ)) {
+		if (jiffies - tk->last_warning > WARNING_FREQ) {
 			printk_deferred("WARNING: Underflow in clocksource '%s' observed, time update ignored.\n", name);
 			printk_deferred("         Please report this, consider using a different clocksource, if possible.\n");
 			printk_deferred("         Your kernel is probably still fine.\n");
@@ -227,7 +227,7 @@ static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 	}
 
 	if (tk->overflow_seen) {
-		if (time_after(jiffies, tk->last_warning + WARNING_FREQ)) {
+		if (jiffies - tk->last_warning > WARNING_FREQ) {
 			printk_deferred("WARNING: Overflow in clocksource '%s' observed, time update capped.\n", name);
 			printk_deferred("         Please report this, consider using a different clocksource, if possible.\n");
 			printk_deferred("         Your kernel is probably still fine.\n");

