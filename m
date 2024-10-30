Return-Path: <linux-tip-commits+bounces-2662-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C783D9B6D6D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 21:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66109B22242
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 20:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C1A21764E;
	Wed, 30 Oct 2024 20:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OX8QEI0k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F9w3NrlZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE42144D0;
	Wed, 30 Oct 2024 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319221; cv=none; b=TYeCBrk4LenLI4OaZ4qb5dwHgB63vstDn9BR7ZHmrH77ybrioWysEBdigUB7COQIBJ3Y6cXh9HpkbetU4ReNyte60xUKBDNhW2ndTkQ6OB/jEM+CVMm4waeDisXwfOgYVt6C5GfmyzNMqdkvFbEL3LIzeFQKVT187ylMM6xgl5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319221; c=relaxed/simple;
	bh=t2RzM/w/VvPX4IEultyaQwmyaHCkvA5LFaPFsdMQymE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OS4RyjH4ZdQC23gtS/SJp/DJ48HtX5tsMmUeoPHVADsKrXo3qCqJU/satIFZ57JPOq90VGAwWSVt2fPm2DzU9O6118dYzaopcboIY8OakPwwGrem2tsd9EBSvWPeMEsrtIuZLj8aR+TBWsM7UJ6XZGG6i8Ti9pk1Dx5TSIoqdk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OX8QEI0k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F9w3NrlZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Oct 2024 20:13:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730319217;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BYJvNqRWcNNR7xHO+7w6w3aYHTAVoaKtzhomftQGPcI=;
	b=OX8QEI0kuqmgDnYWctxnquJYmcS+WR2FvYw1V/AnTrpVZCgAdfC6JKczyeB7lLCT0DQmaX
	YulwEsvD4JlnZ2OcQa0c+4DsYZSh1170ZOH4Rm6jErJywIYjzvRmS7SmuOADisfTAJ1JHN
	iulzBsru6GQLrvupeVv3srL2I1D/SGFN5tjCo+8J/arYPAUp6nH5ZMacyEhlycnZGeoUCL
	MuFOfj1AbODNl6QX74xnK+BJazgbJxAobGQmWzunZvXm20x5MkQ8R3LUfYT9iZ+ttW90NS
	FDihUXpUmXfhjpHEsp6Ai4vAF0hoheR0yOU2mMkfY9wuK21GAFX8m111ss8xEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730319217;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BYJvNqRWcNNR7xHO+7w6w3aYHTAVoaKtzhomftQGPcI=;
	b=F9w3NrlZkfXAa+Mzx4NEVAzhfwW8/A9RhQfT0FeN71Nl/hVM1gMGIec/Mmx5CEStiIEJrq
	yZEeemk+i+2tJ5Bw==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] clockevents: Improve clockevents_notify_released() comment
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241029125451.54574-2-frederic@kernel.org>
References: <20241029125451.54574-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173031921690.3137.8686198378080958241.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     679f8484cafa08f49a19e2947d05e96321fbed9d
Gitweb:        https://git.kernel.org/tip/679f8484cafa08f49a19e2947d05e96321fbed9d
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 29 Oct 2024 13:54:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 30 Oct 2024 21:02:21 +01:00

clockevents: Improve clockevents_notify_released() comment

When a new clockevent device is added and replaces a previous device,
the latter is put into the released list. Then the released list is
added back.

This may look counter-intuitive but the reason is that released device
might be suitable for other uses. For example a released CPU regular
clockevent can be a better replacement for the current broadcast event.
Similarly a released broadcast clockevent can be a better replacement
for the current regular clockevent of a given CPU.

Improve comments stating about these subtleties.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241029125451.54574-2-frederic@kernel.org

---
 kernel/time/clockevents.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 78c7bd6..4af2799 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -337,13 +337,21 @@ int clockevents_program_event(struct clock_event_device *dev, ktime_t expires,
 }
 
 /*
- * Called after a notify add to make devices available which were
- * released from the notifier call.
+ * Called after a clockevent has been added which might
+ * have replaced a current regular or broadcast device. A
+ * released normal device might be a suitable replacement
+ * for the current broadcast device. Similarly a released
+ * broadcast device might be a suitable replacement for a
+ * normal device.
  */
 static void clockevents_notify_released(void)
 {
 	struct clock_event_device *dev;
 
+	/*
+	 * Keep iterating as long as tick_check_new_device()
+	 * replaces a device.
+	 */
 	while (!list_empty(&clockevents_released)) {
 		dev = list_entry(clockevents_released.next,
 				 struct clock_event_device, list);

