Return-Path: <linux-tip-commits+bounces-1331-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0178D7ECF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 11:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0F61C2141E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 09:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41581272B7;
	Mon,  3 Jun 2024 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lnTeeZOh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LAsN47w6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD288614B;
	Mon,  3 Jun 2024 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407016; cv=none; b=H2LzVxDdTR2aJbJmwIIvDJz+YyvOHqJoDqIoIbhxGvMDp6NZaIOv3RSZ0Wg14nCBis5iuVAnCRr5KBJjszN7ZcB/IhTjW9oD5mlQzBGKB4A1ZrnqERgvzIomF5Ghv1AY17iP38jWXPcAzIZ53Tj/V5R+bDPw8wpCZ7ty+d0IHbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407016; c=relaxed/simple;
	bh=aG1NfCh/8LQ5jsHqlTBGaqbseKZewJDV3LJYRqDiOcg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p4APaSupBglkplHipHbboJSNcRRxcUV4Z3vqr1JScW4SbHkvHqPsc6piPNm+A5NZzBa+8l5iqrQ8EFYF2upRDQ47zHZua3N91a+e2FuT+xeGE8aGnQ97pTwSqkDe4Y7eFIKWFl7pwkaha2/y9QYRjll7Een24kVGik3xzf/R+Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lnTeeZOh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LAsN47w6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Jun 2024 09:30:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717407010;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FGMA0MpOcINH1KkUSUBHOmwx5r6N9EJYiJPh942qPhA=;
	b=lnTeeZOhWZYJkC1VBZnNHtBkaN+Z6AQKzWbc5GzT7ModkHRnaKctQ6FHAoxlMmUGzNNu3B
	FNItnz7N/07Az5ce5jwrWkV4eyUHRzcnDisrC3lmlNZ2OzY64jqaah8bkajhtCK8eSW6w4
	V2LjgEIS8DRMgxtc5YGcUL14metOWjzEHyp/jxR1K/tGVMGCO6KW3lJqo0woIXo9kzEhkm
	VEEieJm+4GPcsJmAYsqXAtc31EpqE/a5i9nkQt4emjLvEYa6dSVnvlw2HJGvwZNrVisHWQ
	1DHhnzZSWuaFL1qZe/yhqlWoVmdAzcFGUD8PiQabNmpUX35TJKAH2+og3SCiDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717407010;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FGMA0MpOcINH1KkUSUBHOmwx5r6N9EJYiJPh942qPhA=;
	b=LAsN47w6XRDUgWh+XtqenhHL3MyeThmtp211Yas8zPrrz2XnxmhCHtJ2bPuk1PqvtdAxSP
	71oacmiy02nWrpDQ==
From: "tip-bot2 for Jeff Johnson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] time: Add MODULE_DESCRIPTION() to time test modules
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240510-time-md-v1-1-44a8a36ac4b0@quicinc.com>
References: <20240510-time-md-v1-1-44a8a36ac4b0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171740700967.10875.1560404365308506128.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     7cbf3b13f00c8341afff1c48ad83d11995842c40
Gitweb:        https://git.kernel.org/tip/7cbf3b13f00c8341afff1c48ad83d11995842c40
Author:        Jeff Johnson <quic_jjohnson@quicinc.com>
AuthorDate:    Fri, 10 May 2024 17:24:25 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Jun 2024 11:18:50 +02:00

time: Add MODULE_DESCRIPTION() to time test modules

Fix the make W=1 warnings:

WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/time/clocksource-wdtest.o
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/time/test_udelay.o
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/time/time_test.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20240510-time-md-v1-1-44a8a36ac4b0@quicinc.com

---
 kernel/time/clocksource-wdtest.c | 1 +
 kernel/time/test_udelay.c        | 1 +
 kernel/time/time_test.c          | 1 +
 3 files changed, 3 insertions(+)

diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
index d06185e..62e7344 100644
--- a/kernel/time/clocksource-wdtest.c
+++ b/kernel/time/clocksource-wdtest.c
@@ -22,6 +22,7 @@
 #include "tick-internal.h"
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Clocksource watchdog unit test");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@kernel.org>");
 
 static int holdoff = IS_BUILTIN(CONFIG_TEST_CLOCKSOURCE_WATCHDOG) ? 10 : 0;
diff --git a/kernel/time/test_udelay.c b/kernel/time/test_udelay.c
index 20d5df6..783f229 100644
--- a/kernel/time/test_udelay.c
+++ b/kernel/time/test_udelay.c
@@ -155,5 +155,6 @@ static void __exit udelay_test_exit(void)
 
 module_exit(udelay_test_exit);
 
+MODULE_DESCRIPTION("udelay test module");
 MODULE_AUTHOR("David Riley <davidriley@chromium.org>");
 MODULE_LICENSE("GPL");
diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
index 3e5d422..2889763 100644
--- a/kernel/time/time_test.c
+++ b/kernel/time/time_test.c
@@ -96,4 +96,5 @@ static struct kunit_suite time_test_suite = {
 };
 
 kunit_test_suite(time_test_suite);
+MODULE_DESCRIPTION("time unit test suite");
 MODULE_LICENSE("GPL");

