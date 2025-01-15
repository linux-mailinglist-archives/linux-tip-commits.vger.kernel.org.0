Return-Path: <linux-tip-commits+bounces-3256-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAFCA12B34
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 19:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415501886B8B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 18:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEEF1D6DD4;
	Wed, 15 Jan 2025 18:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qaecK+0w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kMpZXu0J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7151D63D9;
	Wed, 15 Jan 2025 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736967268; cv=none; b=EfM/etrU0J95ODrUrqd8T2Muttfr6hiFBwtcvnTv7gwdBLcxkmCy9UIgF9ukXGtgpfR8rKaE11QXzN/nN9jMnrkVNj6MhWdIZ/v8KIpxhdZ1eesJRQrVVkWe/Q7uZGFQyo3nkJ2j9ldlB2Y8JMI9ygbw8T+NajsEzNC3hpRqU2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736967268; c=relaxed/simple;
	bh=dLHY1XYVqq+w8+hF1mQNQM6yryesr/fXBs/6AlgJTpE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CisNgOrEUIrLZOxb3y779UCLsgGTxnQjL1CGcwglxRAI+Y0y4pxe8E/fF5rYZSAbICBhiocBF8Z1Mn2YM2zPmwAWmr2Swrajnw3Napj37FbjW6W8vFfrZCNXT7MY6YUg+XaOqBSZoq5ewHtmndcadxVcZfjP+yk2rIpzUrprLo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qaecK+0w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kMpZXu0J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 18:54:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736967263;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YfdkckbIyvTW4yq4cqflOxd2a9Tuqrhga5rZ1Vnm/Y=;
	b=qaecK+0wv6Q/xgVsWN/VnjoPtuWTt1DLgZ3CXuFi6xPeaC4a3Lz8HOjukju58vnVr/G+NX
	D9TR5S4y/JYdehnfQ8tQUZfT94ERrzQRuNMFMNJmmW+XFiELsQiRpm7gAJaE1rMTEVnwqJ
	Hl7gaDHMQMfK0pW0qSOQfL1dYkd5aSWqM390fErTegwFWolh6K8Z9ykwlplnzMZ4A76qWo
	QMs3fjWsbhJxP+XT551d+9chgsbIeatb/mUzFjq5i+FRTZAujeZytMldBpWw9b/If00RBL
	W6A6vb+7FGN876xRoHlb1E09RrUgsaqQZvizO9OJKpLfq56VsWswrpI2TBKKMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736967263;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YfdkckbIyvTW4yq4cqflOxd2a9Tuqrhga5rZ1Vnm/Y=;
	b=kMpZXu0Jo0qLapIx8nnlwgEq3DBKZse2+wpFyUXC8SZkfvsbwc4ne5MMfrFGLzo5RRbkyq
	4PVDTTg4ju0BMHCA==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] tick/broadcast: Add kernel-doc for function parameters
Cc: Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250111063148.910887-1-rdunlap@infradead.org>
References: <20250111063148.910887-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173696726311.31546.3486619823568490107.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4903e1ba798e4d4a9bce1eee0f0285f385d14f15
Gitweb:        https://git.kernel.org/tip/4903e1ba798e4d4a9bce1eee0f0285f385d14f15
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Fri, 10 Jan 2025 22:31:48 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 19:49:14 +01:00

tick/broadcast: Add kernel-doc for function parameters

Add kernel-doc comments for two parameters to eliminate kernel-doc warnings:

tick-broadcast.c:1026: warning: Function parameter or struct member 'bc' not described in 'tick_broadcast_setup_oneshot'
tick-broadcast.c:1026: warning: Function parameter or struct member 'from_periodic' not described in 'tick_broadcast_setup_oneshot'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250111063148.910887-1-rdunlap@infradead.org

---
 kernel/time/tick-broadcast.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index ed58eeb..0207868 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -1020,6 +1020,8 @@ static inline ktime_t tick_get_next_period(void)
 
 /**
  * tick_broadcast_setup_oneshot - setup the broadcast device
+ * @bc: the broadcast device
+ * @from_periodic: true if called from periodic mode
  */
 static void tick_broadcast_setup_oneshot(struct clock_event_device *bc,
 					 bool from_periodic)

