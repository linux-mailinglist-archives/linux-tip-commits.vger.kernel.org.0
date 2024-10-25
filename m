Return-Path: <linux-tip-commits+bounces-2547-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E438B9B064E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 16:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A604B224FC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 14:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4617D158D93;
	Fri, 25 Oct 2024 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kC921eXN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uyTXnLD9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E39115443B;
	Fri, 25 Oct 2024 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868028; cv=none; b=bNBVhSrYlGrmo2CYDg5v1d2fedcRdfLGKssNaSg/8hLRYZB9k8xzlxtq0NPS+ogQ4Xw7+fA46SXQFX4/evX21ImiLuMMF1VgRc7tkQiO4BRk1MG0JmFaqsoazBgp6Jv9SQaDFtdQuUN2l1qjhuZeDmH3kJ3tr9puloF21B/cBq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868028; c=relaxed/simple;
	bh=uVHSaw9C9UKMKnAtzWTDGWu0lrJt/JlyJpEFivITuoE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r+X11jgd1+y8c+jVG8F7ta788jnTnD8fRHbcOEVZ+cPsYZHdlDypYs78GPSY5k4VVDuC1W7FS9NvbBhT1MewLiAUdGRHJx5e4V9DYoOPTezDYHOY2mNx7kJHdj/uH5gN4QzIWVrwbqmz0tBB/pEj0LUZCaNq5hqRyEfV7hAtsXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kC921eXN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uyTXnLD9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 14:53:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729868024;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUl4zE6wmMjeY9xZvdoHQ3eVK7t0I3JCaPLDjIRoME8=;
	b=kC921eXN2TtO9L0+/GnULPX/iCnn4wMySpmwZx4MtXuiTwQD924FINhNRtBQfK5YiyHGUe
	EdXUMXmH1JZF125Z8qBj2OjpB/+uZwJaAquZpwZGiH+bePh6vsNXU3f7GdarizXsIg6sDy
	FI1nuA06AQr8H54yYCBqxqukpeSXqCvjYxiSn/M5/oSfGU8U1Dsj5fLOlJMRXcf8MJto5T
	Y0UlT2UBa/5zt3uwtxW2xXrLbyMYBH1x0gEHG+sdTfub21h/8NyoGx2scNA+3pddH9nXyC
	oVuXkAchaqZm5Uzbbjv1itpPKuMcuZDWCB4cGFlS0bqp8lH0LA0TCddIrTK/1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729868024;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUl4zE6wmMjeY9xZvdoHQ3eVK7t0I3JCaPLDjIRoME8=;
	b=uyTXnLD9lcJyEF7nmWaX/yIsOHS7sLFB9KjCGlOmQVh7QRhLwyd/PWQKxbRbe5u/PbTcA3
	DGScwZWy3yCfaNDA==
From: "tip-bot2 for Miguel Ojeda" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time: Fix references to _msecs_to_jiffies()
 handling of values
Cc: Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241025110141.157205-2-ojeda@kernel.org>
References: <20241025110141.157205-2-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172986802328.1442.3479222011520473762.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9824e79077e8022e24d760333633ffc760b09270
Gitweb:        https://git.kernel.org/tip/9824e79077e8022e24d760333633ffc760b09270
Author:        Miguel Ojeda <ojeda@kernel.org>
AuthorDate:    Fri, 25 Oct 2024 13:01:41 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 16:48:10 +02:00

time: Fix references to _msecs_to_jiffies() handling of values

The details about the handling of the "normal" values were moved
to the _msecs_to_jiffies() helpers in commit ca42aaf0c861 ("time:
Refactor msecs_to_jiffies"). However, the same commit still mentioned
__msecs_to_jiffies() in the added documentation.

Thus point to _msecs_to_jiffies() instead.

Fixes: ca42aaf0c861 ("time: Refactor msecs_to_jiffies")
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241025110141.157205-2-ojeda@kernel.org

---
 include/linux/jiffies.h | 2 +-
 kernel/time/time.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 1220f0f..5d21dac 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -502,7 +502,7 @@ static inline unsigned long _msecs_to_jiffies(const unsigned int m)
  * - all other values are converted to jiffies by either multiplying
  *   the input value by a factor or dividing it with a factor and
  *   handling any 32-bit overflows.
- *   for the details see __msecs_to_jiffies()
+ *   for the details see _msecs_to_jiffies()
  *
  * msecs_to_jiffies() checks for the passed in value being a constant
  * via __builtin_constant_p() allowing gcc to eliminate most of the
diff --git a/kernel/time/time.c b/kernel/time/time.c
index b1809a1..1b69caa 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -556,7 +556,7 @@ EXPORT_SYMBOL(ns_to_timespec64);
  * - all other values are converted to jiffies by either multiplying
  *   the input value by a factor or dividing it with a factor and
  *   handling any 32-bit overflows.
- *   for the details see __msecs_to_jiffies()
+ *   for the details see _msecs_to_jiffies()
  *
  * msecs_to_jiffies() checks for the passed in value being a constant
  * via __builtin_constant_p() allowing gcc to eliminate most of the

