Return-Path: <linux-tip-commits+bounces-2218-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3C797207F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993CF1C239D0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF70E183CB8;
	Mon,  9 Sep 2024 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BOEE4FT0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="05A2JUMX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70F117CA0B;
	Mon,  9 Sep 2024 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902867; cv=none; b=HP1qbwlOaC+/eMvH0h4f5VxRRs9hqIWbVCZCLXtDN5/7u5gplcRgCZy2EPCtdmvaYfkMEZq0Kgr++EYbcLL3JCCVY2TYcqtybtry77fZFvyD7SSiHKMpdm8ciw+CLJWiAFagVoTofDcODfDIR1EF+koEcvnG9AdZ1roCuJfNoeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902867; c=relaxed/simple;
	bh=fbKOl/C4Kftn4/Q21T3tGdYIbkfDl34OkmTSl8wxGTk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WezdptedUNfaI9MEuHdYrQMal6c0fRoNX1aECJy8VTq3PbDFNw3X4K6b42vSrUk8vfP1ZNmo1yAkKvlTTOck52DpYainqoIiBLOuS4pscnyxrRVxz+sOO9LjwssfxPWUS98+LNgzRmN1icPYFeoEmvSt6xdcACI588BtkxxwJvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BOEE4FT0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=05A2JUMX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902862;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RmiThMGIbB4Y3ccQYcpYXFpuQM+Yu/ThvBvjnjLjOxs=;
	b=BOEE4FT0/tFrSMGOIqhiGL2UbKOMRRkY+VTqPoEXt1GvWuUbFNkoZ9CZJm7V/eJtNCt7Eg
	aextezJSK+RU6WhePECgsEhF6+U4aRhdSUc1DSOLecEuvt4OrtatsuxqOQyKRJMbRzeSXn
	Yads2lqtBX2AF5IvC3DyVUwHEIvLTDtLrEDLuhN/pSd3SM+NkXCF7D8qi9S1vEIa9jtBBP
	PcoCoVa8n4ZmjrlN9O+j26eihyJ82ibGhKRsY8OH4RFoQMbNyDTEdLYhBvfPeByUPxwmmN
	ASSgAPLZSJ4Z/TwVWDZK+FVfin88emkZ3ArLVobRolVLs4vR9qMYilJIeNkAFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902862;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RmiThMGIbB4Y3ccQYcpYXFpuQM+Yu/ThvBvjnjLjOxs=;
	b=05A2JUMXi8zRRdned1vsZj6kypz6y8OYioj+A53+XvnmLq1tsWHlU0uZFMeKGSstunhlZx
	tT7BQhr/U4EkIgCA==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: nbcon: Assign nice -20 for printing threads
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240904120536.115780-17-john.ogness@linutronix.de>
References: <20240904120536.115780-17-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286208.2215.581312913346730259.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     1529bbb6e2619495f146dd519a196b67837fdfa6
Gitweb:        https://git.kernel.org/tip/1529bbb6e2619495f146dd519a196b67837fdfa6
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Wed, 04 Sep 2024 14:11:35 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 04 Sep 2024 15:56:33 +02:00

printk: nbcon: Assign nice -20 for printing threads

It is important that console printing threads are scheduled
shortly after a printk call and with generous runtime budgets.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240904120536.115780-17-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/nbcon.c  | 6 ++++++
 kernel/printk/printk.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 9844088..fd12efc 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1321,6 +1321,12 @@ bool nbcon_kthread_create(struct console *con)
 
 	con->kthread = kt;
 
+	/*
+	 * It is important that console printing threads are scheduled
+	 * shortly after a printk call and with generous runtime budgets.
+	 */
+	sched_set_normal(con->kthread, -20);
+
 	return true;
 }
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 66cfe7b..afd9266 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3555,6 +3555,12 @@ static bool legacy_kthread_create(void)
 
 	printk_legacy_kthread = kt;
 
+	/*
+	 * It is important that console printing threads are scheduled
+	 * shortly after a printk call and with generous runtime budgets.
+	 */
+	sched_set_normal(printk_legacy_kthread, -20);
+
 	return true;
 }
 

