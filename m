Return-Path: <linux-tip-commits+bounces-3478-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E20A39916
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798693BAD3C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24F6243385;
	Tue, 18 Feb 2025 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nebosOXK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x9hCJJpJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389B32417FA;
	Tue, 18 Feb 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874396; cv=none; b=qeji84y6cvoY1xF7vC/5e6y7YlOG8nDTLcdvCi6ROn6kxEheUCDhsGOFkCe23H8kK3IjdDvesXNtnMRTiX5LtBujF4jCWz9gsz1HNiAiN3SGlECZ3g43XXjEyVHT+lQaHHlycziMzHj5/2CjK4eZT2uF7iNPg0v60b1EaC6AEJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874396; c=relaxed/simple;
	bh=kep8uFepWOtbjBnwE0m713WH70ESr4AcQLkInEaUnbo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rrisGd0Do7ilJxko3/bA4UR6NaX/DyfQe5hxhCLgXmKpTOe6WGgfsjKYmNKehg64rPzYp1oiHUF0OQJZ+NqhMUW36ulSvY35pNn82SBDj8azgby2dvESxT/7O8OO87SLe0U0YTVYPNCm/WdZa9+StNdhAX0OZoXyIpBk+XGBAyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nebosOXK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x9hCJJpJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6r/2ZfT+DUsCQSqFqURp3cimjh/PkYqM6Sspoqbn0x0=;
	b=nebosOXKJAzzYmh2YqnVYsBcf84SonbO2K8cZTRACvrvmXkuf1H05VqKiT88tv7RRPjss2
	9VW0oh4LWHzb5NXmfuAl+I+sGd17GyN8DOM6m5TmGdpTANm4lzPFuNeEkw+QdUH4uBU2V1
	6zdIj6Ow9G70PFjRhTKV17CBDznjR38Qbt1SHOsWvAjDNHFwtySczByac6bSLY4dDnGXs/
	JYkOCctzns9c3DZMzCGQrlBbmINumSh1mwC8uWQL9DgFdGIBKli6IPPp9AMgbbbAakqdVL
	nC1M7nfK8+O61r/pENk9bMG55MgJh2gHXI8yP4YDwILP1Go5YxoJs4/onJjyFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6r/2ZfT+DUsCQSqFqURp3cimjh/PkYqM6Sspoqbn0x0=;
	b=x9hCJJpJhP+TYtE1DeNf2RTIlUBhD3Tx9rLgNBkHj60DtM6rHB0TtoFq6E4ZXL/2HrTnIX
	ZOVkPWZ6gXPrdKCA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] mailbox: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cb742f81b6acdaa604511834a06a8aac3e6e63ca3=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cb742f81b6acdaa604511834a06a8aac3e6e63ca3=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987439326.10177.10410853459596782545.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     c158a29c5c5ba97c0549d3390f50d441950bbce7
Gitweb:        https://git.kernel.org/tip/c158a29c5c5ba97c0549d3390f50d441950bbce7
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:04 +01:00

mailbox: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/b742f81b6acdaa604511834a06a8aac3e6e63ca3.1738746904.git.namcao@linutronix.de

---
 drivers/mailbox/mailbox.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index d3d26a2..118beaf 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -534,9 +534,7 @@ int mbox_controller_register(struct mbox_controller *mbox)
 			return -EINVAL;
 		}
 
-		hrtimer_init(&mbox->poll_hrt, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL);
-		mbox->poll_hrt.function = txdone_hrtimer;
+		hrtimer_setup(&mbox->poll_hrt, txdone_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 		spin_lock_init(&mbox->poll_hrt_lock);
 	}
 

