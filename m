Return-Path: <linux-tip-commits+bounces-3135-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CEA9FC170
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 19:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32011884937
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 18:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90322139B2;
	Tue, 24 Dec 2024 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vpnSM28O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a8LFQvzm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60B1213254;
	Tue, 24 Dec 2024 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066428; cv=none; b=M4k3jErT+GYtnK4TNwjxu71JKG1CgpohFH+ATGehgdMqKwG0MIRTRkPCPk2JQBO9pBXmAvVXNM8vGw11aeCcWUfhgF40pRXyRziExNDq/MzISby7nmK4C8nsE+8iEa4TvS8k6aSZA+deE+2KqR5oJbFc0pWHDHpnrIpW9qHMO9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066428; c=relaxed/simple;
	bh=xsEoHYljcfhTF/0//2rvLigYesTuoijBXPPfHlMSxQk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sqfnZXc4JD1htryKnIzjpyDRYyRu/PhOP5qbFH+ZmEm5iaX7XwJSVTdPvnXtG18DF8yK1Wt6/hc5JytIRNvJOTLA47RKQCr9s2qs2j1kPlQ1bNWZ/LpME/6OkScR3ChV/h/FpsKcAU54t57Tcd/xBTFyu6RTkAav27s0G2TCFyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vpnSM28O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a8LFQvzm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 18:53:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735066425;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHXgH7FVhgzh4n1Ce5wG9zPc+t5FLBlD4dSDQEjJJuQ=;
	b=vpnSM28OzmUUcDv0mefYf2eHve/KRlMd7dHU15AiXnPVJVS5mnZvf8tbZY5iHyGJPLZKuu
	tFX6fLuR024gHWWwBQXri8sUnQSrmB0yuABjO0T1JZO4tnnu0szXNP7lVxjoQyx48rhyjY
	b6y5vIbFo+HVVbfSLkfIw6iFuv5Ln4GNoGlxKg09PMKbGZ7tnstJQDd9zQcK548qk5OCHz
	ZCXw26D6FUsZMOG0PIJhywZeLhRB0IVvwxdJDIWvL0yFYnG4ZLJrxn+WgdcCBwazAuWRpo
	hfXiEEiwXKgjmP+GvNRMXT1F2N4d20zAJWT6U0ytX/xtF4CHpP/MfcdaLayQ7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066425;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHXgH7FVhgzh4n1Ce5wG9zPc+t5FLBlD4dSDQEjJJuQ=;
	b=a8LFQvzmu42ToDcSDxSOFbdhBR+0nlusSZEyAuPF2KMdSO1p9c1IJyh499A69MrBF8m0xu
	HnizWyaA7LVbx9Dg==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww_mutex/test: Use swap() macro
Cc: Abaci Robot <abaci@linux.alibaba.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Waiman Long <longman@redhat.com>, Thorsten Blum <thorsten.blum@toblux.com>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241025081455.55089-1-jiapeng.chong@linux.alibaba.com [1]>
References: <20241025081455.55089-1-jiapeng.chong@linux.alibaba.com [1]>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506642497.399.671600444798182994.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0d3547df6934b8f9600630322799a2a76b4567d8
Gitweb:        https://git.kernel.org/tip/0d3547df6934b8f9600630322799a2a76b4567d8
Author:        Thorsten Blum <thorsten.blum@toblux.com>
AuthorDate:    Wed, 31 Jul 2024 15:58:51 +02:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Sun, 15 Dec 2024 11:49:35 -08:00

locking/ww_mutex/test: Use swap() macro

Fixes the following Coccinelle/coccicheck warning reported by
swap.cocci:

  WARNING opportunity for swap()

Compile-tested only.

[Boqun: Add the report tags from Jiapeng and Abaci Robot [1].]

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Reported-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11531
Link: https://lore.kernel.org/r/20241025081455.55089-1-jiapeng.chong@linux.alibaba.com [1]
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20240731135850.81018-2-thorsten.blum@toblux.com
---
 kernel/locking/test-ww_mutex.c |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 5d58b2c..bcb1b9f 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -404,7 +404,7 @@ static inline u32 prandom_u32_below(u32 ceil)
 static int *get_random_order(int count)
 {
 	int *order;
-	int n, r, tmp;
+	int n, r;
 
 	order = kmalloc_array(count, sizeof(*order), GFP_KERNEL);
 	if (!order)
@@ -415,11 +415,8 @@ static int *get_random_order(int count)
 
 	for (n = count - 1; n > 1; n--) {
 		r = prandom_u32_below(n + 1);
-		if (r != n) {
-			tmp = order[n];
-			order[n] = order[r];
-			order[r] = tmp;
-		}
+		if (r != n)
+			swap(order[n], order[r]);
 	}
 
 	return order;

