Return-Path: <linux-tip-commits+bounces-4680-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F661A7C282
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 19:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1884D1B60B13
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E3B21CA0D;
	Fri,  4 Apr 2025 17:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fhsokw4q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0nI39yq+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7828121E0AC;
	Fri,  4 Apr 2025 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788056; cv=none; b=P+DsvWIzEFLo6RDWNz0pNFtirnjohP83i8fLNOaKJTwwmIc7axfALQmA/E3cXiju1wif9zNHBB8aa0JrX5MZfa1AsR9F/XEES/Wjf3VWbfKQTPXEubSHQizLLkOZwT7865kQipBMgq6ieg+3GlKEquwqnMugMN0j8DBWHu0l4yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788056; c=relaxed/simple;
	bh=SBhlq2J8Zn+ELgMcsYrxA8o1MdKoTWxRU1OhrVICJhc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tuoHDaChJdb2ub6zWdOAFFwIacwE2O810+GGCk2vM/7/eyzIk837oSYT//8/o1jFDqRc27JfqvbPs+MyqMOPIGj5SE8xZFCiWjKm9ff9gyay7CXW2/1amRlqbQ8jcTdIRw1Mnbw4gKin8k7TZFxyJUIHcsK2oIZRWQO2uqaJDrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fhsokw4q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0nI39yq+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 17:34:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743788052;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFPZJAoR1yjSzfTRmkDDcFDoUHdiGzbQ45p3d8+jwZo=;
	b=fhsokw4q7e2s3E+1ila/ivxkfDtGiMM1y/dY3dy6j6p6yNJroTeO96wQqhVW3tnFCXg49Q
	bt+eAJkYsDMwu3IJUASEbBWJabR9Mlmy7/uSFlrsJSNyDMwydmiEwql4YNiYf/qnomZN/S
	KeE4tPJqHGzHYl7aoqsMynVoXF9wdbWNjXXu8zLiNTyT0KCQS33++YSBo8EJFtbF3HqdJ6
	TY9/YOqW33oyTa5AzKdY0QoG1aDuie47p7X8XlGv7018rFB9y0gOSc1EfKngLjtxnyRR1c
	/3z2Do3bQ1ghvgLwtYZDLStBogJCGgMddM4Y/d2XFOHHENaUvtz84ienQ6VM+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743788052;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFPZJAoR1yjSzfTRmkDDcFDoUHdiGzbQ45p3d8+jwZo=;
	b=0nI39yq+mhx2tt4WR4Cr6NDS5C4It88FrxbyPzbEzCiLn6H3fFFK51BOBOgQg2aM72KGvc
	iDbBL0m77nA2BzBA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Switch to use __htimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cd9a45a51b6a8aa0045310d63f73753bf6b33f385=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cd9a45a51b6a8aa0045310d63f73753bf6b33f385=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174378805202.31282.4548676701082513893.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     6119cdeeead0552e7dcfde1473a711b494be66e5
Gitweb:        https://git.kernel.org/tip/6119cdeeead0552e7dcfde1473a711b494be66e5
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:11 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 19:26:43 +02:00

hrtimers: Switch to use __htimer_setup()

__hrtimer_init_sleeper() calls __hrtimer_init() and also setups the
callback function. But there is already __hrtimer_setup() which does both
actions.

Switch to use __hrtimer_setup() to simplify the code.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/d9a45a51b6a8aa0045310d63f73753bf6b33f385.1738746927.git.namcao@linutronix.de

---
 kernel/time/hrtimer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index b7555ba..2d2835c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2061,8 +2061,7 @@ static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 			mode |= HRTIMER_MODE_HARD;
 	}
 
-	__hrtimer_init(&sl->timer, clock_id, mode);
-	sl->timer.function = hrtimer_wakeup;
+	__hrtimer_setup(&sl->timer, hrtimer_wakeup, clock_id, mode);
 	sl->task = current;
 }
 

