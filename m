Return-Path: <linux-tip-commits+bounces-5505-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3234AB02F4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 20:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACA8E7A5BDF
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 18:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34AC27A441;
	Thu,  8 May 2025 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j/hNeny0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FyS8aFZn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4577A2147F6;
	Thu,  8 May 2025 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746729419; cv=none; b=jhLzNPoMSaY9R8ODihlygAY1ZgoxUu2a6L1gBx1BGgXf5SJQ3Z9zKmNSQn/3+6XRSZJvCDWuleUFAetQpAZ4YUvjAW+gAA6ZWpOs5uNLy3Ps61qK+gKF3QBmXuPd5+Jp3cIzExcH19adFH4/7n8oWofXxMrVwjp9jVaFNpHxiEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746729419; c=relaxed/simple;
	bh=gFnKaO8NJ1vr65D5HM2hcUhON+JFBItrqPU7ReVq4bI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ludhtvh8u6wo0v6m9yf4dDj5Z+3xfP2nz0VUM7A045SJUsy5Ywq6QmdBpP2B9HcgIWTBvj/epLW8gxDsJgFY/rPXjaZ6rquvZm5STAPSLQcAqSFQy4A9NI/XubPd4xPk7oHA+uzzoIwJ9zaVB2eZbj3axJktBrSzWBEbxFOaRSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j/hNeny0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FyS8aFZn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 18:36:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746729416;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXYK14Q4FErDPwPirDQXCk5kvlrvUYDBPzcCfw0MMkw=;
	b=j/hNeny07jiRHL81xvbgDqbL4A4Oc9AivuIoWEXZdLOfnQ4uYdFxh3gKJfoqcIciwesmE0
	8dIi4McADliYwEmDldTdx5/yGPeGQNXduyIzmC2SIG2AmmeMreYufRtGpq04gC2eI78vJh
	l5W6uNRTxnnZFFwpuDAQUf1/E6xNOCaxq5cywnQD4261VJDlo53JRTJK4i0xH8qw7svEEi
	aYaX3X5jGNPVkhpzDR7m71qNUsDc7As4KsuH/m7Wo/CjGCfYdGxA+YxbMKso5Z56OcxTc8
	pbB6rC/Rdtg7LBXFvri6nil5EmhQhlAPxEJdq1owb7prQrhPC6ESDEfUPuRLvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746729416;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXYK14Q4FErDPwPirDQXCk5kvlrvUYDBPzcCfw0MMkw=;
	b=FyS8aFZnlczx4ZfXVaCyapA+IA+kXLVBrxymabSfvV/907Aokn7/2tyA9PDk3oVmf7+kjT
	AWaUmuVU31SG2wCA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/futex] futex: Fix outdated comment in struct restart_block
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250428193445.4571-1-namcao@linutronix.de>
References: <20250428193445.4571-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174672941499.406.16484065926733232596.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     01475aedfdfa33a5ee3219079426f5743367c624
Gitweb:        https://git.kernel.org/tip/01475aedfdfa33a5ee3219079426f5743367c624
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Mon, 28 Apr 2025 21:34:45 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 May 2025 20:29:07 +02:00

futex: Fix outdated comment in struct restart_block

Since commit 2070887fdeac ("futex: fix restart in wait_requeue_pi"),
futex_wait_requeue_pi() no longer uses restart_block. Update the comment
accordingly.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250428193445.4571-1-namcao@linutronix.de

---
 include/linux/restart_block.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
index 13f1767..7e50bbc 100644
--- a/include/linux/restart_block.h
+++ b/include/linux/restart_block.h
@@ -26,7 +26,7 @@ struct restart_block {
 	unsigned long arch_data;
 	long (*fn)(struct restart_block *);
 	union {
-		/* For futex_wait and futex_wait_requeue_pi */
+		/* For futex_wait() */
 		struct {
 			u32 __user *uaddr;
 			u32 val;

