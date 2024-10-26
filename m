Return-Path: <linux-tip-commits+bounces-2602-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DF39B15F5
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Oct 2024 09:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025481C20B97
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Oct 2024 07:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24A718C321;
	Sat, 26 Oct 2024 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MYpgy0ks";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3JXSkfQI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3CD4436A;
	Sat, 26 Oct 2024 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729928131; cv=none; b=rCgZWck5vDQpSHxNZY1Pdhigbe9/PL5X7ACdhnU2lWHL1I5d6MdWzGwqJSli/Pm2tJsiN1+21bWuKrZccL0y/1uuLerJuTaZql3obFS3KbKpOlON/8cVjwIaNNT12wrHZpkodKQ7HM3nV0Vu4gwI4chtHzTeBwHLVM6o+0j/XtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729928131; c=relaxed/simple;
	bh=ka9wlBmfnv8X1yLKeW/MCvgXOTRWqDz9XGAof1xAPJA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CKu69AF0JUm8cbDexDdMcWCq7IdlfvVhcDoLgAx5LMyKTpYw/9GjPHcme4pON6h7LukEIb09LMhGF2Hk90NxJsEA4dyYpGYm7yfmiG1Wt9g+n1zMoJNjZu5rMzkAB4rHjVaztyvSMbRWTAGiefA7+SDOEPhkyly9D8Iooi5RfZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MYpgy0ks; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3JXSkfQI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 26 Oct 2024 07:35:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729928127;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKky5Eshfe80vFQH1wZ+S3IpsrtWkSdIdzkRo0P1SyI=;
	b=MYpgy0ksSC1ho+uiewtuRn/x5SVZYjHCSwKngybBwb1Jpibx/0AQvmb9yjqAHSWGk4WcZv
	VRfwLL5Hsk+kfeosVOczebaHqXSR5c1B1uN9Wo5bsujQcxPOUljkcZZg4zEe5plX3sN24N
	TDvOOY/wYHaCYzfGi92btoOUrgcNvjO02LKsBQgAIKMmsUDFnJG1IsWIiOgyFwya88LHsk
	t9OSefbqmQFZ1M1AnwrH9ESVnMUsezKeGHFkueN5YHS6d8Ar+7Bc8pe3DNQR87aWt81Ej+
	Y4TicuxfgORVWyzeSq2l0P6zUQVfhndHwFIS4coSWkzzzs22kGBPtbTGH8SRrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729928127;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKky5Eshfe80vFQH1wZ+S3IpsrtWkSdIdzkRo0P1SyI=;
	b=3JXSkfQIAknrfZQ8VdA2PXxkKbWjqkkZs5wEs+VZvL3dF+0VL4zMo6b297BcLByysxJQpm
	LW8nymaEdbseugCg==
From: "tip-bot2 for David Lechner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] cleanup: Add conditional guard helper
Cc: David Lechner <dlechner@baylibre.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20241001-cleanup-if_not_cond_guard-v1-1-7753810b0f7a@baylibre.com>
References:
 <20241001-cleanup-if_not_cond_guard-v1-1-7753810b0f7a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172992812675.1442.16190431929459104566.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     36c2cf88808d47e926d11b98734f154fe4a9f50f
Gitweb:        https://git.kernel.org/tip/36c2cf88808d47e926d11b98734f154fe4a9f50f
Author:        David Lechner <dlechner@baylibre.com>
AuthorDate:    Tue, 01 Oct 2024 17:30:18 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Oct 2024 10:01:51 +02:00

cleanup: Add conditional guard helper

Add a new if_not_guard() macro to cleanup.h for handling
conditional guards such as mutext_trylock().

This is more ergonomic than scoped_guard() for most use cases.
Instead of hiding the error handling statement in the macro args, it
works like a normal if statement and allow the error path to be indented
while the normal code flow path is not indented. And it avoid unwanted
side-effect from hidden for loop in scoped_guard().

Signed-off-by: David Lechner <dlechner@baylibre.com>
Co-developed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lkml.kernel.org/r/20241001-cleanup-if_not_cond_guard-v1-1-7753810b0f7a@baylibre.com
---
 include/linux/cleanup.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 0cc66f8..e859f79 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -273,6 +273,12 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *	an anonymous instance of the (guard) class, not recommended for
  *	conditional locks.
  *
+ * if_not_guard(name, args...) { <error handling> }:
+ *	convenience macro for conditional guards that calls the statement that
+ *	follows only if the lock was not acquired (typically an error return).
+ *
+ *	Only for conditional locks.
+ *
  * scoped_guard (name, args...) { }:
  *	similar to CLASS(name, scope)(args), except the variable (with the
  *	explicit name 'scope') is declard in a for-loop such that its scope is
@@ -343,6 +349,15 @@ _label:									\
 
 #define scoped_cond_guard(_name, _fail, args...)	\
 	__scoped_cond_guard(_name, _fail, __UNIQUE_ID(label), args)
+
+#define __if_not_guard(_name, _id, args...)		\
+	BUILD_BUG_ON(!__is_cond_ptr(_name));		\
+	CLASS(_name, _id)(args);			\
+	if (!__guard_ptr(_name)(&_id))
+
+#define if_not_guard(_name, args...) \
+	__if_not_guard(_name, __UNIQUE_ID(guard), args)
+
 /*
  * Additional helper macros for generating lock guards with types, either for
  * locks that don't have a native type (eg. RCU, preempt) or those that need a

