Return-Path: <linux-tip-commits+bounces-4183-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B6DA5F26A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 12:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F59A19C12C0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC70266F17;
	Thu, 13 Mar 2025 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CoPsH1L1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JNmfLzsn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA4E266B6C;
	Thu, 13 Mar 2025 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865489; cv=none; b=T1NG7fmoK/OxRWVeaFt2qRJjuKZcNMynXps/hGypTKFSUbCmXwxaeCpJZ70YWHZdcbH1dPfptSel9vGyUypLO/wSjR3gbuHogbbEML2XWxpupdi7uSgl1CLBhfAkDnyLLLw+TMoYen0eDHN9u7t+irsdhSjGACOgjQ+hlywT870=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865489; c=relaxed/simple;
	bh=0CgHQQBRlS4skrH5B6EbTPU9l0uI/jOUvvSpXN2BKPc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CEZAWfEpUSh3YgUJbhJosktA8oThSQePfobaGkJACvitj5h9CBxN6txoDGFM+goZgS8nPSfgtfNJ1ApXDdB6fJGKixncNeJ+V4Rerlwf3EL7emLhwRSg49xWJCHNWu5Tk/kE8f0WzFXK08uCbJ20MsZrHcRO/ZKDcL7BdQ3tkfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CoPsH1L1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JNmfLzsn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 11:31:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741865486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9Th7ul+aybq/z2Hl4t4NrmjbYoveaqL1HbweOfbMKc=;
	b=CoPsH1L1twQSn09ycPkrVr5UJX7pRkf+aMbY63IostJCZDxG5jS1erqndu1/cTTrGN8B1z
	W3BjCgROmX1fVpju2AI7UJXgUpyMcPJBGaIe8Sv9R/9q5JVbTP56gAtqUWj9pBmMKT5q4G
	qvZq4lIHDa1J+mqf9+6+DFlfoUtbrlaN9kN8KuyfFFtiLTY+96Su23dqwaa7z9ydvLWGwX
	pC46v6X3dJ3zCkWNIoUFtY7Xt2/iI3LYFHaBomKdx29eiIytq6oIRhK0jqW3Z4EjaTIRT0
	AHptSj144A+NUKfiSuor0WSDz4QSmi432/bDMIXHMhrfV1IXrThUqIjhLjjyUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741865486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9Th7ul+aybq/z2Hl4t4NrmjbYoveaqL1HbweOfbMKc=;
	b=JNmfLzsnTIpLFJdOArbouOiJTHALHteeuPszYyI+TxAxj/j/2RdBukdbEfAb+4Babz5Y6d
	Mz6SwhfjzTWhlkCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Switch to jhash32()
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250308155624.279080328@linutronix.de>
References: <20250308155624.279080328@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186548539.14745.14080988185546244322.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     781764e0b4394fbd8e8eb39195f8a076b60808b3
Gitweb:        https://git.kernel.org/tip/781764e0b4394fbd8e8eb39195f8a076b60808b3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 08 Mar 2025 17:48:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Mar 2025 12:07:17 +01:00

posix-timers: Switch to jhash32()

The hash distribution of hash_32() is suboptimal. jhash32() provides a way
better distribution, which evens out the length of the hash bucket lists,
which in turn avoids large outliers in list walk times.

Due to the sparse ID space (thanks CRIU) there is no guarantee that the
timers will be fully evenly distributed over the hash buckets, but the
behaviour is way better than with hash_32() even for randomly sparse ID
spaces.

For a pathological test case with 64 processes creating and accessing
20000 timers each, this results in a runtime reduction of ~10% and a
significantly reduced runtime variation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250308155624.279080328@linutronix.de


---
 kernel/time/posix-timers.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 23f6d8b..0c4cee3 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -11,8 +11,8 @@
  */
 #include <linux/compat.h>
 #include <linux/compiler.h>
-#include <linux/hash.h>
 #include <linux/init.h>
+#include <linux/jhash.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/memblock.h>
@@ -47,11 +47,11 @@ struct timer_hash_bucket {
 
 static struct {
 	struct timer_hash_bucket	*buckets;
-	unsigned long			bits;
+	unsigned long			mask;
 } __timer_data __ro_after_init __aligned(2*sizeof(long));
 
 #define timer_buckets	(__timer_data.buckets)
-#define timer_hashbits	(__timer_data.bits)
+#define timer_hashmask	(__timer_data.mask)
 
 static const struct k_clock * const posix_clocks[];
 static const struct k_clock *clockid_to_kclock(const clockid_t id);
@@ -87,7 +87,7 @@ DEFINE_CLASS_IS_COND_GUARD(lock_timer);
 
 static struct timer_hash_bucket *hash_bucket(struct signal_struct *sig, unsigned int nr)
 {
-	return &timer_buckets[hash_32(hash32_ptr(sig) ^ nr, timer_hashbits)];
+	return &timer_buckets[jhash2((u32 *)&sig, sizeof(sig) / sizeof(u32), nr) & timer_hashmask];
 }
 
 static struct k_itimer *posix_timer_by_id(timer_t id)
@@ -1513,7 +1513,7 @@ static int __init posixtimer_init(void)
 	timer_buckets = alloc_large_system_hash("posixtimers", sizeof(*timer_buckets),
 						size, 0, 0, &shift, NULL, size, size);
 	size = 1UL << shift;
-	timer_hashbits = ilog2(size);
+	timer_hashmask = size - 1;
 
 	for (i = 0; i < size; i++) {
 		spin_lock_init(&timer_buckets[i].lock);

