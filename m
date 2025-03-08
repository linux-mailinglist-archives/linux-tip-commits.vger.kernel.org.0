Return-Path: <linux-tip-commits+bounces-4064-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362B3A57691
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 01:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9997B188641D
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 00:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F256F182BD;
	Sat,  8 Mar 2025 00:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HNpUhwuq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t2FD4YPj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C94B323D;
	Sat,  8 Mar 2025 00:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392489; cv=none; b=VLvXry16hfxekUf4Uhi3VH5rqHXlhVSpv52fA1PA/s/ty6JaAZQdnqSulPTfQz02M9z2mwfkrlPFnIJGrztnEpwKFssjcq+b8yQCUkNvhehr7rVppibnsal09+OXQD5Zc5VwIwmGpnCGqLYVHgppk010CcOtw5PVKQuW5gLolGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392489; c=relaxed/simple;
	bh=QlEa37nGN6+MvEF9b+z7UisLOjWHJRHVJhU7RmrEx+w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m7VsFGk8V2cRIolH6yruCBnbG+XVYOxp2KU0QQnTEKf4TPRoVao+2q61BW0fznt86kpresvrS3qHbgfhW49GiuyLWU0RUyBVCf86waYf2dw6V2eH6fbb+5pA2yUBjzdb7FrBGuNK0f7IXCOnpbxrKRr2Q012NLVyqxvNLwuZb0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HNpUhwuq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t2FD4YPj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 00:08:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741392485;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nWbSTEZX/uXwNJpxZxMGiTAxsevwGtUEjLgvJcZh1aM=;
	b=HNpUhwuqq+TnsHRsTDiESBOUGT7rCjUxcEj2EDRqmys5QSHqWcOllUeRHHSlTfoLLUh1uV
	LkbgdsE/uuTO62YRJPwJ+s2rxLd2/w8sfG1stbVN7UJ+XuWj57R+fbTfcRZZUcdR7s/Up0
	vEHGWNhDi6Tx0hnV13OL4VqBZRLHwjIYzO1JV/xmIUnvoPnNpQhdUUSX2JuwVo1fJNLrel
	nbSNEZiG95rT6TnbhNTB6MEd+I2Umi60edsAhUe3nQS4pECdfzzzjgICDGw9CvGC94/3uR
	JD1RN8PbESbmcywxQThrR1V6SdmG5x8H4GXV1Z+Es3u7xUC4HsIBBcYpm+apaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741392485;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nWbSTEZX/uXwNJpxZxMGiTAxsevwGtUEjLgvJcZh1aM=;
	b=t2FD4YPjeL1D6kjz+PgnCsXUJ5r/GQkrUpRzMJhU9qjoI58utEMQ2QmfGyFTkTUSnR2ibi
	XZavazqYzhwAg8DQ==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Add kasan_check_byte() check in
 lock_acquire()
Cc: Marco Elver <elver@google.com>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andrey Konovalov <andreyknvl@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250307232717.1759087-7-boqun.feng@gmail.com>
References: <20250307232717.1759087-7-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174139248454.14745.10281410147550782244.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     de4b59d652646cf00cf632174348ca2266099edc
Gitweb:        https://git.kernel.org/tip/de4b59d652646cf00cf632174348ca2266099edc
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Fri, 07 Mar 2025 15:26:56 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 08 Mar 2025 00:55:04 +01:00

locking/lockdep: Add kasan_check_byte() check in lock_acquire()

KASAN instrumentation of lockdep has been disabled, as we don't need
KASAN to check the validity of lockdep internal data structures and
incur unnecessary performance overhead. However, the lockdep_map pointer
passed in externally may not be valid (e.g. use-after-free) and we run
the risk of using garbage data resulting in false lockdep reports.

Add kasan_check_byte() call in lock_acquire() for non kernel core data
object to catch invalid lockdep_map and print out a KASAN report before
any lockdep splat, if any.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Link: https://lore.kernel.org/r/20250214195242.2480920-1-longman@redhat.com
Link: https://lore.kernel.org/r/20250307232717.1759087-7-boqun.feng@gmail.com
---
 kernel/locking/lockdep.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 8436f01..b15757e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -57,6 +57,7 @@
 #include <linux/lockdep.h>
 #include <linux/context_tracking.h>
 #include <linux/console.h>
+#include <linux/kasan.h>
 
 #include <asm/sections.h>
 
@@ -5830,6 +5831,14 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (!debug_locks)
 		return;
 
+	/*
+	 * As KASAN instrumentation is disabled and lock_acquire() is usually
+	 * the first lockdep call when a task tries to acquire a lock, add
+	 * kasan_check_byte() here to check for use-after-free and other
+	 * memory errors.
+	 */
+	kasan_check_byte(lock);
+
 	if (unlikely(!lockdep_enabled())) {
 		/* XXX allow trylock from NMI ?!? */
 		if (lockdep_nmi() && !trylock) {

