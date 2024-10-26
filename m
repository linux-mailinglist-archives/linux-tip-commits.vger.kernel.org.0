Return-Path: <linux-tip-commits+bounces-2605-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F23599B15FB
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Oct 2024 09:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9180282D46
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Oct 2024 07:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E065419340A;
	Sat, 26 Oct 2024 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qxdXEI8D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DxcQMfeO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D887D17CA02;
	Sat, 26 Oct 2024 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729928133; cv=none; b=scNJ/9K89h6qTBt1QAsP6g1iOu/SzePBIxY1FPuDzEiCrfewbnSWG/NSEpJc2YBMxbYUvSIBU/HQt3gCO2jCJVpAOo9kITITXs9mMsJokudrmp1E01QBUP/MAIj6Y6LgvYEkE/Z3IAja34/aGxRMO1jrL8Ba3Krgt4Lw5/K1MIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729928133; c=relaxed/simple;
	bh=3V1gMW/cZmWAyLWxpR8HS/Epe3XuK7HcCmUHJUwmvg4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JPWpXdGwqiZqXTZKQE/Qg6NQUOW3dCQdc+dooZaGeN/5N5j0zYncBtAePuFVnuBs1WZE7vHO73FGppQA4pNeP0bT8ueG1KPH7bnrDkCYYyStXZBSY+z7Pi+Xr1wT0mD+S582fipSauUfTProT2UImHVZcAcgyOnUYonRfcFZVfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qxdXEI8D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DxcQMfeO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 26 Oct 2024 07:35:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729928129;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2WjWDhcEUuHXffZnnxsUt4P7QOwf7MRneZgk3kBIWA=;
	b=qxdXEI8DvCwReJdXTbOXMmJmDY/tmvPGJ6ZmPwO3Uzen8/kgen4NBj4nSdJ/vBQWKxVi1D
	BeZmkUD+nLFKFfTFYulSqN7a/QotJkz0zZPvAbWJt4gLFnYRd/fRMs1BZvbmsut+HXxjK8
	yVYLPSCaIX0IhlquJM+Zxj62KZZD2vRG+0FvDcnTgjud9NahoyRAmmBJIssnEoJNgqb6Y4
	XXvAbY+GWKDnBaV1VwHMyWiFN+rn4ZzNq9EoiTo37Uk59JdNHp4Aa2Q73q+umiRiXdfu6P
	OJf+bevfPr9sHZqkAMNxPx8iAMwTyEYWeVdu21khPgjOgmP1DMQ/41zl6dB5EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729928129;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2WjWDhcEUuHXffZnnxsUt4P7QOwf7MRneZgk3kBIWA=;
	b=DxcQMfeO7NV7cW3qBACrL28+6avIJIDpyM2VQTglZr3f8ENIv8kX+4X+nQVMhktj/Ilk2p
	2M5DDh3rf1yNjKCA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] cleanup: Remove address space of returned pointer
Cc: Uros Bizjak <ubizjak@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240819074124.143565-1-ubizjak@gmail.com>
References: <20240819074124.143565-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172992812897.1442.17815814917523978461.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f730fd535fc51573f982fad629f2fc6b4a0cde2f
Gitweb:        https://git.kernel.org/tip/f730fd535fc51573f982fad629f2fc6b4a0cde2f
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 19 Aug 2024 09:41:15 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Oct 2024 10:01:50 +02:00

cleanup: Remove address space of returned pointer

Guard functions in local_lock.h are defined using DEFINE_GUARD() and
DEFINE_LOCK_GUARD_1() macros having lock type defined as pointer in
the percpu address space. The functions, defined by these macros
return value in generic address space, causing:

cleanup.h:157:18: error: return from pointer to non-enclosed address space

and

cleanup.h:214:18: error: return from pointer to non-enclosed address space

when strict percpu checks are enabled.

Add explicit casts to remove address space of the returned pointer.

Found by GCC's named address space checks.

Fixes: e4ab322fbaaa ("cleanup: Add conditional guard support")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20240819074124.143565-1-ubizjak@gmail.com
---
 include/linux/cleanup.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 038b2d5..518bd1f 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -290,7 +290,7 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
 	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
 	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
-	{ return *_T; }
+	{ return (void *)(__force unsigned long)*_T; }
 
 #define DEFINE_GUARD_COND(_name, _ext, _condlock) \
 	EXTEND_CLASS(_name, _ext, \
@@ -347,7 +347,7 @@ static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
 									\
 static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)	\
 {									\
-	return _T->lock;						\
+	return (void *)(__force unsigned long)_T->lock;			\
 }
 
 

