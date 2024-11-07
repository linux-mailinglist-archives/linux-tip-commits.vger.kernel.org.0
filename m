Return-Path: <linux-tip-commits+bounces-2808-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993879BFC13
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 03:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD3E2837D3
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF13281720;
	Thu,  7 Nov 2024 01:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WtAFPK+p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hUPJ9Dpt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415B218E25;
	Thu,  7 Nov 2024 01:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944781; cv=none; b=frBRPW/ZiBUPz45MPIQT73jXSLnk8Swq8qdmD/Srb6UgH+9GnJa/OHv9bzy0dZFto66aM7xJ7lGTSSNuALQhFZ06NNJMnRkFkoeJ3ujxW7zIA+1fX7PGw7tXn9sDf+E3Roxc4HZfSNgQCOCOr5KAoYWQTkSRaglS26vfbDrnWbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944781; c=relaxed/simple;
	bh=CpYRRhHUHIV6zaT9VtQHqmUiSuuuKiIFxHeqo8VG/I4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G8Im92i27wmRwIBI0XQeIbfNtqtrKJBIT8t0CbFvNlQJ/6K8Xpr/ev/nvyirqCAb+8vEA12NZHeGaysD52wJazXIKLBdNQydw27Uewy1mnYBf0xUzLBJnbwvIcqUHTOk0eWr7A5FZAdvmYTts/i20LUZhoikZTZjq8NKzN1e4oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WtAFPK+p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hUPJ9Dpt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:59:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944778;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95mVYktVflJtVDszmDtmWY8+qFLRO6ndvDm2624VHoM=;
	b=WtAFPK+p9zAOfDbEUmIvE5jplUr2TEnFztTnopLAJrCoXJq863lwLTPI0L0wzIhlAy8pOq
	PK3afAYvp6JtxJVal/JTC30H3xF/zEztRRoGAcebl7QXPxVl3WCuid8LpVn2UiyygHD1/Z
	WTJ7TwzOB63xfMNboSxo7KE7nhoyyZDB/63dyYjOm8I+XrB0qWr+IB6vc4O0F+VMqK6sHK
	RbnbvMPwCU3iFCVtqd8b/0IeFqUOrKZ/SZlDPKTGIdtJvT5thb8kd6mTn+jsZpBsTmNWoY
	HPBIVL3N3OHJWbYomUUWHJ2zjT3DBBuxwgYxmUh5tneSGypsyX1ef4Ri7A3ksw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944778;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95mVYktVflJtVDszmDtmWY8+qFLRO6ndvDm2624VHoM=;
	b=hUPJ9DptV0EcmY/ZubEVHq/WnKthZsdP8hVmXMBl5wabZ7MLNPHARWezYiUnMROZDoQP2U
	8VoseU85/ACbMSDQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] wait: Switch to use hrtimer_setup_sleeper_on_stack()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cfc91182375df81120a88dbe0263267e24d1bf19e=2E17303?=
 =?utf-8?q?86209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cfc91182375df81120a88dbe0263267e24d1bf19e=2E173038?=
 =?utf-8?q?6209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094477807.32228.7145077199369021198.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     211647e5121e0e0da974bf69a8eb7c9fe57fa3bd
Gitweb:        https://git.kernel.org/tip/211647e5121e0e0da974bf69a8eb7c9fe57fa3bd
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 31 Oct 2024 16:14:28 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:47:06 +01:00

wait: Switch to use hrtimer_setup_sleeper_on_stack()

hrtimer_setup_sleeper_on_stack() replaces hrtimer_init_sleeper_on_stack()
to keep the naming convention consistent.

Convert the usage site over to it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/fc91182375df81120a88dbe0263267e24d1bf19e.1730386209.git.namcao@linutronix.de

---
 include/linux/wait.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 8aa3372..643b7c7 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -541,8 +541,8 @@ do {										\
 	int __ret = 0;								\
 	struct hrtimer_sleeper __t;						\
 										\
-	hrtimer_init_sleeper_on_stack(&__t, CLOCK_MONOTONIC,			\
-				      HRTIMER_MODE_REL);			\
+	hrtimer_setup_sleeper_on_stack(&__t, CLOCK_MONOTONIC,			\
+				       HRTIMER_MODE_REL);			\
 	if ((timeout) != KTIME_MAX) {						\
 		hrtimer_set_expires_range_ns(&__t.timer, timeout,		\
 					current->timer_slack_ns);		\

