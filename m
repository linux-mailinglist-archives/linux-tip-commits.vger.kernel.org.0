Return-Path: <linux-tip-commits+bounces-2536-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F9A9AE11C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Oct 2024 11:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4239A281449
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Oct 2024 09:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0D21B6CE7;
	Thu, 24 Oct 2024 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BjcN41UP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5URo/4II"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E03C1B6CE8;
	Thu, 24 Oct 2024 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762630; cv=none; b=jEERBND66p0PAhpPqN0tJulJx+yT/xXE4RkUdSwrnjoxw0w/F3ArgFYpvS9ljki2roT5dSuOfYqfn535SeNPJCLjKRQl6EjU78KTHg4d4iRXhY6WTnshoWgn0MiXSKRctVU1zdKJ47Lb0cUn7lWjaTgpK401M+/IUUDr2lMoPNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762630; c=relaxed/simple;
	bh=RzARLvf7q8U4WtfMRe7VQACB2FhlIcsNW9cgrEn9Wmo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z09Pn/4mtsr0700QhMr7NRnbFGuGmp6dYOFq54jkG87Wz0UyzYZl1rIpjNtD/iVsFZDX7D606PppQ4QsFQf2Cv1tPWIPtJq/DH3WhnwHBnmqlceyQ+IcVIPMc3LbWbPuws3ZlTlHcaNNSGvo/mZIzn3ogmjUyDTQd9HAu9mYmMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BjcN41UP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5URo/4II; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 24 Oct 2024 09:37:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729762626;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FdwnWpcBQLiybLizh7cEd5aliquxyVujA3mBHi9foAE=;
	b=BjcN41UPwRPF9bq+4XnFYEoLcNtqBXkLI+cAjL2H91JOk/2kc19WZWSG8eVzdBiBnu90FP
	Tdqcr+HqxmiB6AXempn4vbx1AXSui6PGfi60G1PCRAV57XS9J47EhD5uDVO6cJDB65aHsF
	wK6TsjtbsmMLpS30Sqz5j3kRRGSmeSS6l3Qafuhu4w0o958lNQGr4JtxVRcKP5SE+71Lzw
	X8Tx9bPKQchsNBeu1i54cfFENc9+Oe6A8ne31WtTinQFScXs7ZWVsEyalV/hIzGVHU1G+Z
	l3yq8f0auVvpz667q6bz793U4jO5YqG+TuAqrfpAbtHSiaW+w+xhR0Wkbttjiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729762626;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FdwnWpcBQLiybLizh7cEd5aliquxyVujA3mBHi9foAE=;
	b=5URo/4IIL5wLVoYRBlh0g/Hafrqq32G+SWuU+TTV4aMtDaKhceyQjiET8zeD9E/xneWmXK
	vO4/Mo9mxb6SxcDQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] locking/rt: Annotate unlock followed by lock for sparse.
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240812104200.2239232-5-bigeasy@linutronix.de>
References: <20240812104200.2239232-5-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172976262580.1442.4617419905991721713.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     77abd3b7d9bf384306872b6201b1dfeb1e899892
Gitweb:        https://git.kernel.org/tip/77abd3b7d9bf384306872b6201b1dfeb1e899892
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 12 Aug 2024 12:39:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Oct 2024 11:27:02 +02:00

locking/rt: Annotate unlock followed by lock for sparse.

rt_mutex_slowlock_block() and rtlock_slowlock_locked() both unlock
lock::wait_lock and then lock it later. This is unusual and sparse
complains about it.

Add __releases() + __acquires() annotation to mark that it is expected.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240812104200.2239232-5-bigeasy@linutronix.de

---
 kernel/locking/rtmutex.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index ebebd0e..d3b72c2 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1601,6 +1601,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 					   unsigned int state,
 					   struct hrtimer_sleeper *timeout,
 					   struct rt_mutex_waiter *waiter)
+	__releases(&lock->wait_lock) __acquires(&lock->wait_lock)
 {
 	struct rt_mutex *rtm = container_of(lock, struct rt_mutex, rtmutex);
 	struct task_struct *owner;
@@ -1805,6 +1806,7 @@ static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
  * @lock:	The underlying RT mutex
  */
 static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
+	__releases(&lock->wait_lock) __acquires(&lock->wait_lock)
 {
 	struct rt_mutex_waiter waiter;
 	struct task_struct *owner;

