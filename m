Return-Path: <linux-tip-commits+bounces-3439-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D20A39826
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D632D161F66
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7972376E2;
	Tue, 18 Feb 2025 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AnygK6O7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mOWy/sRo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6623E1B87FD;
	Tue, 18 Feb 2025 10:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873204; cv=none; b=Tsk/tOnD8S8lQz/zId/G3gr5hzELQncuxixTSddFlVKbXkp/OBceIzs5rctd+1C09O5NkK23XiZBJkTAwLv7domFrhiNvjuWpB8/ga5euMvUtNv/frvEk85xkWWlnyYmwOW+aFqIKLmA7ffIw2U3Ku+0vrl9KMbuOba1q/dSDpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873204; c=relaxed/simple;
	bh=uo2JrNOKAPACUiTteDo9l10dGD/RFCbf9huv3begYIs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=spXL5TtFiGj2lV3RzvH3nAjanC9M9ksXNKChcDTRhF1vYZxLcEiannmTGQ8ajkTr/jA9fHRzsMdstYb0CJDCBt/h6dATVjTYPY7O+5THjH1ael9wYoA0l8q+OfnzwbaCao6oyUuRp9sTWSUMo7WGiofSZa/S4Ys/ak49BM7XpnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AnygK6O7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mOWy/sRo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873201;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exGAJ7kpynr+pP0upX5DgeSdh6gLA5qLpRqSyK1zH80=;
	b=AnygK6O7a0aPVuiPJJ93nbPWnCCk6rO+yHyXHmsuI9UI8Wz9dUNeStqijL3xKQg44AtzBr
	+X9GMaq+k696oRyq2CcV5Ffu8WGRuEx+9zBB10+qn8fuH/w4WzZ5kVgNt+TSGKNmJrkiuV
	CmwI+LeLKnYtO08EKphn+YRSVWgNLLGKSOfjWJA0K7gY/jzaojJrEUcuWSfTygpclAjPw5
	/7sQj6BRzf/x1QUvJ/1Qj+VCwmO6lo08ccYmr9nkR7aPk1qKWGsNQafB1P8tBo8ByA7ia3
	YptndF1yCQElr5gZ4/u2MjzjUoJse5H+M1a6ByhkFtjGc4JtUBpDo7imvkbCOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873201;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exGAJ7kpynr+pP0upX5DgeSdh6gLA5qLpRqSyK1zH80=;
	b=mOWy/sRoY4DaPLjeaUNk+S6+WlhJiIIdiVLAt84VUqHV+sqg+tfQv0t3iP6MLZ7rmJljFe
	epLdRXYg7NB/j9DQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] wifi: rt2x00: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cf086be77528edf0dfb455af4cb984b863084a455=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cf086be77528edf0dfb455af4cb984b863084a455=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987320118.10177.1016574178226331343.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     1528fd734e7b8fabea014234fc3f35d811f2f6f7
Gitweb:        https://git.kernel.org/tip/1528fd734e7b8fabea014234fc3f35d811f2f6f7
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:47 +01:00

wifi: rt2x00: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely. This new function replaces
hrtimer_init().

However, converting this driver is not obvious: the driver calls
hrtimer_init() in rt2x00dev.c, then set the hrtimer's callback function in
rt2800mmio.c and rt2800usb.c. Therefore, switching to the new function is
not a simple one-for-one replacement.

With the lack of hardware to verify any non-trivial changes, keep it simple
and calls hrtimer_setup() with hrtimer_dummy_timeout() as callback function
pointer.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/f086be77528edf0dfb455af4cb984b863084a455.1738746872.git.namcao@linutronix.de

---
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index 9e7d9db..432ddfa 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -1391,8 +1391,8 @@ int rt2x00lib_probe_dev(struct rt2x00_dev *rt2x00dev)
 	mutex_init(&rt2x00dev->conf_mutex);
 	INIT_LIST_HEAD(&rt2x00dev->bar_list);
 	spin_lock_init(&rt2x00dev->bar_list_lock);
-	hrtimer_init(&rt2x00dev->txstatus_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
+	hrtimer_setup(&rt2x00dev->txstatus_timer, hrtimer_dummy_timeout, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
 	set_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags);
 

