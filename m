Return-Path: <linux-tip-commits+bounces-2458-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBFF99FB84
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 00:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEDB51C23B70
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 22:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74B21D6DB1;
	Tue, 15 Oct 2024 22:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4qflmSAk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="63sCVAeC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C761D63D8;
	Tue, 15 Oct 2024 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032086; cv=none; b=G1pG+qb/hov648JdaEl8aOc0V5MjQLbsVPdwtj26VOpMUzdmoRbrV38xzAEquHJUdcEwbefEbn8rmptzrkB2/xO7TLoK7iOF8PVjQleWCyk2EWTa9c3VaR0jFnFUPU5/YpLQQJ9XKkM24blYRdAz2OSRLYVmRTP84Io8hRuncP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032086; c=relaxed/simple;
	bh=uVOcMRwKnXgFpySAQQUpcOt4qwG+tAI/NEMB3hgPdIk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rNJ1Q2no6iu5wXxdFnDjC28xPExYTtaVSQM4ibX+O2pgcDopPANtHp7YfDObEJRviEBF7spA6yAWa2QxJl8960z3omy70doa/AAdh+15TYwqRZTasCg16Hex1Q40WSP4f8FkQBzqHaQX8Sd2bH/CsDpi0eTH4e9pINfEnMDExHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4qflmSAk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=63sCVAeC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 22:41:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729032083;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+y0Xx2TH8by4iDHS70KqQLHt2sC5Roa8z2MakpiF8PU=;
	b=4qflmSAkw9k4QIoDmBatYNLb6UJ8kFL59/P6p6M4tyoiaq4/97EabfY0xhk00UNlDQz8pg
	z2CeYRhARkv6BugoVGRpIBRxwr5h5ftsqxswdkLshwlX9L9YWHtJwKiC3psHeWr2UggTi2
	7HcaJPpbHtCbQa5EbfNQBdDfG+Bs1QtRZZi30ft6L6RDesB4diDTCquJdCWQaEaxYCNGxC
	3CopeUcebxmeXCf+nZtLdCht4uh9HExzGvf73SyI4rCKCwkDHr/ajy0foaaYMezY8mvQQS
	/c66jWrgX76oE+xXYcF8Cr3I8SuJoKclozr+uj3uiZLIU0EkNmNvnRSxy3cYcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729032083;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+y0Xx2TH8by4iDHS70KqQLHt2sC5Roa8z2MakpiF8PU=;
	b=63sCVAeCVn+MOouv98/bzx5yTpDHSd8ol4lv+jalC26oDowQxLZzRoOj/e4iIaavOH4dCy
	Vrox+RlfQx+bXCBw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Add a warning to usleep_range_state() for
 wrong order of arguments
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-9-dc8b907cb62f@linutronix.de>
References:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-9-dc8b907cb62f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172903208237.1442.9087885737949003382.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     6279abf16a014474fba3de2e28b6ede871141cde
Gitweb:        https://git.kernel.org/tip/6279abf16a014474fba3de2e28b6ede871141cde
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 14 Oct 2024 10:22:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 00:36:47 +02:00

timers: Add a warning to usleep_range_state() for wrong order of arguments

There is a warning in checkpatch script that triggers, when min and max
arguments of usleep_range_state() are in reverse order. This check does
only cover callsites which uses constants. Add this check into the code as
a WARN_ON_ONCE() to also cover callsites not using constants and fix the
mis-usage by resetting the delta to 0.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20241014-devel-anna-maria-b4-timers-flseep-v3-9-dc8b907cb62f@linutronix.de

---
 kernel/time/sleep_timeout.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/sleep_timeout.c b/kernel/time/sleep_timeout.c
index f3f246e..3054e52 100644
--- a/kernel/time/sleep_timeout.c
+++ b/kernel/time/sleep_timeout.c
@@ -364,6 +364,9 @@ void __sched usleep_range_state(unsigned long min, unsigned long max, unsigned i
 	ktime_t exp = ktime_add_us(ktime_get(), min);
 	u64 delta = (u64)(max - min) * NSEC_PER_USEC;
 
+	if (WARN_ON_ONCE(max < min))
+		delta = 0;
+
 	for (;;) {
 		__set_current_state(state);
 		/* Do not return before the requested sleep time has elapsed */

