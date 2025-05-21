Return-Path: <linux-tip-commits+bounces-5681-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111EDABF3AF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF25B3B9E76
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81799265CB9;
	Wed, 21 May 2025 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="caMkA/00";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="se9BZJN+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CEB264A83;
	Wed, 21 May 2025 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829172; cv=none; b=mS7mvNK884J1KV1H0viyOMEnq01g7MZsxC0xFlzoMNCYeWNTa9QGvADCbSMu3wrr70YutKTpMHrqzigPOfDMHeSiNDEIyZ6njRZ+v5LqgKJAqnQiBocJYVswIEn9bYIN3uTW3czLJP1E2VDNCQkmzbZFcxl+M1syheA9U7ewkBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829172; c=relaxed/simple;
	bh=2Y7h9FLSuwQV4ahko7NokTmxnqt7W/kwNcP7E2GH0yU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JyRvge9+1GjPuHcQDjBZpXd0YGNOlNEXkYGRIN/UJ2Wqz/lQ/itSCmSlc5wvf2vJfL2BBPbVB/f770gp2BJDUs1QuBRX8IBsoCWMhTVU3oTk8EVDmrVgH2tD6A7lqwgdvfKtsfwUFSisWQCbdLUDoODwcWXHnvEWtmGs7m8HBMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=caMkA/00; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=se9BZJN+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:06:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829169;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODw2q0VcZh/FUcAyOd0UjhWNr57kbKVG/Xy+qxZzXqo=;
	b=caMkA/00937bURz5Vk23ine98B7W+Qx3kv7HSOOUT7KqphLr/N1JW/NBGIWTjUP3oLy22h
	x0QDOu1PL9Vjb3yStqwTVbkStaUXEQyKwG8WDjD8wQu2X5ThaQOOWYA0bSSYpqJkNt+GTI
	aT4+MZYYz+bakofOf0CJR1jrWU06mBWw0EWCIwGOPZvVBfCMPCf8stS3lbVUvicSHxtsbz
	nseM4Xi4FWznOqysJdQiJ6oAtmL5h2K7D+Ed1J2Vmx4KjKxm6W/Aw0xLr4VnPd4scmmmlV
	GjfqHcoYeNV1a9dWjTIQMNVuRyIzHRm6sqmaTnRDEu0RlNcUlq1/nP1A9M+OBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829169;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODw2q0VcZh/FUcAyOd0UjhWNr57kbKVG/Xy+qxZzXqo=;
	b=se9BZJN+AsfJ3/GVE4fOXc13Gju0XzgsxmoyYzfte8imL7Y6P/fGemexW5BoEwFzD6jtpo
	gFZfI2/RzH+ColCA==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/futex] futex: Use RCU_INIT_POINTER() in futex_mm_init().
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250517151455.1065363-4-bigeasy@linutronix.de>
References: <20250517151455.1065363-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782916844.406.17946927892328892389.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     279f2c2c8e2169403d01190f042efa6e41731578
Gitweb:        https://git.kernel.org/tip/279f2c2c8e2169403d01190f042efa6e41731578
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Sat, 17 May 2025 17:14:53 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:41 +02:00

futex: Use RCU_INIT_POINTER() in futex_mm_init().

There is no need for an explicit NULL pointer initialisation plus a
comment why it is okay. RCU_INIT_POINTER() can be used for NULL
initialisations and it is documented.

This has been build tested with gcc version 9.3.0 (Debian 9.3.0-22) on a
x86-64 defconfig.

Fixes: 094ac8cff7858 ("futex: Relax the rcu_assign_pointer() assignment of mm->futex_phash in futex_mm_init()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250517151455.1065363-4-bigeasy@linutronix.de
---
 include/linux/futex.h |  9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 168ffd5..005b040 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -88,14 +88,7 @@ void futex_hash_free(struct mm_struct *mm);
 
 static inline void futex_mm_init(struct mm_struct *mm)
 {
-	/*
-	 * No need for rcu_assign_pointer() here, as we can rely on
-	 * tasklist_lock write-ordering in copy_process(), before
-	 * the task's MM becomes visible and the ->futex_phash
-	 * becomes externally observable:
-	 */
-	mm->futex_phash = NULL;
-
+	RCU_INIT_POINTER(mm->futex_phash, NULL);
 	mutex_init(&mm->futex_hash_lock);
 }
 

