Return-Path: <linux-tip-commits+bounces-7559-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8776FC93D31
	for <lists+linux-tip-commits@lfdr.de>; Sat, 29 Nov 2025 12:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 30F94340F51
	for <lists+linux-tip-commits@lfdr.de>; Sat, 29 Nov 2025 11:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F118823D2B4;
	Sat, 29 Nov 2025 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n8Sxr30r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yu74Y9sJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E341A8F97;
	Sat, 29 Nov 2025 11:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764416990; cv=none; b=LR+nxQrg8XOXvV8i8wdEaz588KCX4QMocw5Qz5fvDstxkJeQX8DF0wAoej7dT5ldbDgdu5cFUrdVFK9JSqJs4NFLlH5IRy4cKBx2Al/p8hIzPXV3wCCNr4sdoXzrEDZF5VjzM24iZoYj3dIVRygjUXW5+wqTyb89H7Yub+IoxoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764416990; c=relaxed/simple;
	bh=+Zw3eAmn/8H/PAOrmKhCufmYnnO4O+SahLfRqEbTG10=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=t39XfgFQ2YZlUO8IHhIj0/mRxvV8rkeeZwXQM9PWebjbS8aFfLKXIA1AziQA7/WAC7YAbERUOspdsZw3U6frGC0IMmiD6DLrDLtEc1DizYyIXkPP57ivmkHSdcwLvT3FE4cBgYsobrP3b1vE7Pi3lwXDBLU8eYZB4w5dYLX8mzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n8Sxr30r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yu74Y9sJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 29 Nov 2025 11:49:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764416979;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ju9uUwJaj/o+oa1Sf5Ud0XcIeJUo9V6ei6TBFSLuz5c=;
	b=n8Sxr30rx1c+ANz8zWpKzkgrixyv6D2py8rsHOesC2Hv5aR+y+v5ymFXlyFyy5PfRrMXrY
	HCTs43+Mbtwp4yNhf6TygMyLgab+1q68UPRFYEiMwAtsBev/eZOc0tBIe4UpN+UoCdZ+oZ
	Mw2Ydq+uU7RFS4bGyn3J7plciEgthZ8llCFibEpX6gvFTQqJnitclWjYva1UDstIMEkE5f
	eA1dpA90jZpAaW/gkt5KEx0ez89hOPai4c6l/0Jsk9FVH4gA9K/bruhcGY2BjMfi/qAdi/
	HLxsZxTLZxNk0dl0uvubLsA3cvu+IhiKhsEszAVd4WHy15UCa2b2fPa2p6n8IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764416979;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ju9uUwJaj/o+oa1Sf5Ud0XcIeJUo9V6ei6TBFSLuz5c=;
	b=Yu74Y9sJs/NNpXBRY69p1USS3nj5M/ttc+5T9wb6e0ixaHbUCfpoHtwzz0IADZevYc6JZz
	5dqRO9XPR0yuyPBg==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] local_lock: fix all kernel-doc warnings
Cc: Randy Dunlap <rdunlap@infradead.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251128065925.917917-1-rdunlap@infradead.org>
References: <20251128065925.917917-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176441697467.498.17709933612929065513.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e7194ffe9a0411122980b031c0bbb455a5106266
Gitweb:        https://git.kernel.org/tip/e7194ffe9a0411122980b031c0bbb455a51=
06266
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Thu, 27 Nov 2025 22:59:25 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 28 Nov 2025 11:09:02 +01:00

local_lock: fix all kernel-doc warnings

Modify kernel-doc comments in local_lock.h to prevent warnings:

Warning: include/linux/local_lock.h:9 function parameter 'lock' not
 described in 'local_lock_init'
Warning: include/linux/local_lock.h:56 function parameter 'lock' not
 described in 'local_trylock_init'
Warning: include/linux/local_lock.h:56 expecting prototype for
 local_lock_init(). Prototype was for local_trylock_init() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251128065925.917917-1-rdunlap@infradead.org
---
 include/linux/local_lock.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 0d91d06..b0e6ab3 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -6,6 +6,7 @@
=20
 /**
  * local_lock_init - Runtime initialize a lock instance
+ * @lock:	The lock variable
  */
 #define local_lock_init(lock)		__local_lock_init(lock)
=20
@@ -52,7 +53,8 @@
 	__local_unlock_irqrestore(this_cpu_ptr(lock), flags)
=20
 /**
- * local_lock_init - Runtime initialize a lock instance
+ * local_trylock_init - Runtime initialize a lock instance
+ * @lock:	The lock variable
  */
 #define local_trylock_init(lock)	__local_trylock_init(lock)
=20

