Return-Path: <linux-tip-commits+bounces-1486-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF4D913ACB
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 15:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10370B20C67
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 13:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F217E181333;
	Sun, 23 Jun 2024 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MAsl0TKA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yy+GtDhe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C951E4BE;
	Sun, 23 Jun 2024 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719148633; cv=none; b=EXPP9qYbiZggv0Pv3hI4BZHO/oAAUt9doqO1xg2WqLNHq7USXAY6399EPsyZ3sm40IzQ4SMpMaLH2LYdmrHMGNW/0rR3TlVzjj/BgjCcSNgwFqjCuI770bdANsvWpnc8RquNG+UsVH28pXbIB+esYqO0XQgzz527fWxgnlUEbco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719148633; c=relaxed/simple;
	bh=+LK6WIkVUAN1Z+EAC4BH+nzDcWCkxk/TMq3NzuRQkck=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LePKrpcuEdvPYP//9X3A7v4FZgsTtSmc8avzXZuOX1krHENxewatIQcziYJR35BqWoiHfGMzkGRHZ/qIuHd985+uW05OvfpZ8xiYcOh9IRmDkrxBkKfj4L6MOAYBHbcXHGPU19gDoiITIni8NdXJv8F9UZy6daxq5EOepHyD1kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MAsl0TKA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yy+GtDhe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 13:17:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719148629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7WoVySaq9A3DyxvIh09LFRn8jyDz1VkILbYOlP6jt0=;
	b=MAsl0TKA3/oUZFmOvqoHqkG9SBEugmtUw1a9LHSqdVPFH3zkKd+WidwGf0V3h2XBGgyRZE
	tvdbRt6PxLyirgckzjO+0f9YZwHaSgkftpQfWqWp2mTWGuAIJbVgVGI1Swaaue8KwGEo53
	WfA0ET/Xrw/OXGWZVYbVquIbGCLj6ZtGp0EYpyPR6f11YVrXgDYdd9jDQOMQm2m45za2RT
	wFXw3bdzBttAFJe/wPFOHObnQP5bW9pOA/KqW9TdDhmZcAXwXUh2eSK9t9iqoMSTBYf0GP
	9sOZm/rA3qI71neDQ+VyFZL0Xqy8qZuTJLnr2/4M9xcgR9EaQkxD3SOleu97sA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719148629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7WoVySaq9A3DyxvIh09LFRn8jyDz1VkILbYOlP6jt0=;
	b=Yy+GtDhewFR1oFxSr+6lfEdwhYG1qxvQQW91d+Du3ZLldQ7/eSblpriBHzRxbdYZwnHkXn
	w6yZPa5zakSH+WBA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqdomain: Fix formatting irq_find_matching_fwspec()
 kerneldoc comment
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240614102403.13610-2-shivamurthy.shastri@linutronix.de>
References: <20240614102403.13610-2-shivamurthy.shastri@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171914862923.10875.165422280627822509.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     6dca724d61a1d10f772dcd06948c30ceca027069
Gitweb:        https://git.kernel.org/tip/6dca724d61a1d10f772dcd06948c30ceca027069
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Fri, 14 Jun 2024 12:23:40 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Jun 2024 15:07:57 +02:00

irqdomain: Fix formatting irq_find_matching_fwspec() kerneldoc comment

Modify the comment formatting in irq_find_matching_fwspec function to
enhance code readability and maintain consistency.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614102403.13610-2-shivamurthy.shastri@linutronix.de

---
 kernel/irq/irqdomain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index aadc889..8475b83 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -438,7 +438,8 @@ struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 	struct fwnode_handle *fwnode = fwspec->fwnode;
 	int rc;
 
-	/* We might want to match the legacy controller last since
+	/*
+	 * We might want to match the legacy controller last since
 	 * it might potentially be set to match all interrupts in
 	 * the absence of a device node. This isn't a problem so far
 	 * yet though...

