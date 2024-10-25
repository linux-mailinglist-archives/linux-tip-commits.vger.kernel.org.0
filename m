Return-Path: <linux-tip-commits+bounces-2548-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2817A9B0650
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 16:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501081C2245B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E988B15B130;
	Fri, 25 Oct 2024 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="efdoGh91";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bqP7UcdA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE72F15572C;
	Fri, 25 Oct 2024 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868028; cv=none; b=HKDZ2p5qsJCsVy89DeRxee4mpwHlRWAbAbdr7amiKpYlAynCGCZliQd0JK7EvHp3Q3BApoRzbnxnYmeH9/VA1ZBwhxqNp3kTITPeNSAo3SDf5U4zhkBecpB7/XTf5RNA2In3UqHtPPYUZvL4LTjgFDFQx84Zn89455DJxUyA8MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868028; c=relaxed/simple;
	bh=vtdrA+l04JmaLpPMSPQkQIDF6jKe58KuIUC/SpgayFU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gb3cQSqZyX5WsJYRKgKy8ZLfdPP/0WsOV4asdfP79rkGK0zvG6p3mWn6ZI/0HUun1msIdchwcniAk6btHN82BTdwkTDQVoXEwWqmUDBIIN+QqV6v3Tt9nvMKZ4HbIOsSGiZ5+zd1Vb26klYu3Yub+nWWoUR83pfvoiHddon9iDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=efdoGh91; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bqP7UcdA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 14:53:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729868024;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjQXaSKzKw2HUPFZI7tf/E3QFXqKpmZ7W9Pwak8g2rw=;
	b=efdoGh91x0GNb8WMcN0FdbUp29I3vATKVevY7QB4aS+ATZAavYI9pBzs2LizRcYVh9m+qX
	L6jiwOBvDhtaXsp/EgIC6ntm1vhQjBbt2vYlojgv7doR1GQWMEVetkWpRSa7O/FVhH+YnF
	1flPxpKQHk+NSZ1TzPu+KMWrIWtK1x5cENikfZx5lah1waF57JhWYlA/Kpui7pUiDSoGbg
	5ZsLnOItQ2MKs9MfJn0yp0JgraWULeIA0KuoTCcJNo4klvcAIRqEZI03L7kXoOZBoXOtGc
	gVDYnz1/e+e2zT1s/ZNqLmQkZjy7wAHyR6L2XY4HZ5kXGNR9J1vIH/fj2oR33Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729868024;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjQXaSKzKw2HUPFZI7tf/E3QFXqKpmZ7W9Pwak8g2rw=;
	b=bqP7UcdAtyrkLMnr4AdGzzQcZbvIFQdcmfgSP9wWbAPBBp3NTT44hWhd+AkHBgelmRkr6Z
	RFGoi7+njuVOTQBQ==
From: "tip-bot2 for Miguel Ojeda" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time: Partially revert cleanup on
 msecs_to_jiffies() documentation
Cc: Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241025110141.157205-1-ojeda@kernel.org>
References: <20241025110141.157205-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172986802400.1442.1163693120565825233.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0592cdd59cb09f7ab8bda55f77952f3ce2edaa04
Gitweb:        https://git.kernel.org/tip/0592cdd59cb09f7ab8bda55f77952f3ce2edaa04
Author:        Miguel Ojeda <ojeda@kernel.org>
AuthorDate:    Fri, 25 Oct 2024 13:01:40 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 16:48:10 +02:00

time: Partially revert cleanup on msecs_to_jiffies() documentation

The documentation's intention is to compare msecs_to_jiffies() (first
sentence) with __msecs_to_jiffies() (second sentence), which is what the
original documentation did. One of the cleanups in commit f3cb80804b82
("time: Fix various kernel-doc problems") may have thought the paragraph
was talking about the latter since that is what it is being documented.

Thus revert that part of the change.

Fixes: f3cb80804b82 ("time: Fix various kernel-doc problems")
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241025110141.157205-1-ojeda@kernel.org

---
 kernel/time/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 5984d4a..b1809a1 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -558,7 +558,7 @@ EXPORT_SYMBOL(ns_to_timespec64);
  *   handling any 32-bit overflows.
  *   for the details see __msecs_to_jiffies()
  *
- * __msecs_to_jiffies() checks for the passed in value being a constant
+ * msecs_to_jiffies() checks for the passed in value being a constant
  * via __builtin_constant_p() allowing gcc to eliminate most of the
  * code, __msecs_to_jiffies() is called if the value passed does not
  * allow constant folding and the actual conversion must be done at

