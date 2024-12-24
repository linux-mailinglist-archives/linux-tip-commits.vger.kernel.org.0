Return-Path: <linux-tip-commits+bounces-3128-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F729FC167
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 19:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0F5165A37
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 18:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F622135AA;
	Tue, 24 Dec 2024 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c3jMIY5C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pbs5uaaV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA4C213228;
	Tue, 24 Dec 2024 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066427; cv=none; b=gzaU6WQq2EKXyzhJ8545hshUbghiPsZeiH3Zbklt4jPIPphszVFiAYL1g9Obpk8rlvJFl8ee2TnWMuBWh10FGEEMnCl5c4I1VTw/9Fhzwjs66bQaHhZuDykdiQVAgpXXMcB8X+s3FO8MjlXf1FcDqjaQ3llUQg+QPc7jNKzkk8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066427; c=relaxed/simple;
	bh=3t0/nmmqIrlRSwuktkkigmTZ7Gk/nbVj0miIVQ79aJI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UwXFoyFXRWx9R19tfjDVepoZjBoZ8gBwwQeq6jySH/EGayKC4oMBblxACcLTYQmWidf23Le3RKMUTB2Q+7YrOvb4oGacO8a4gVPAimSQ8rvaMCRY8gwbGKEV/pJrRApisEx8YFSM/qKxBirWmlSqNkm0C+FURovTPHSRDQ4bx7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c3jMIY5C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pbs5uaaV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 18:53:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735066423;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sdfxiP8R7Woq/j6ze/KAEvqml5GzyHXmfFGcOQq4Hro=;
	b=c3jMIY5CV+sJtnvEq0oHeg9c/7hBWo8WkbK+60+TtLypl1O1ilksy3blUddfhzH3aLJW9s
	R2INi9L2QGuByBr8c7tkOZG5k3lEtVgDqOnxhL2uW8/FBogVZtVMdPfhe+RVbYGCfbkEh5
	heDqFf9b1jOwf3AJ1ihKSc1K9RGdjfOZ7itzWWimEdoYvsxR+aYvuuC6WY5rsv0mYw8xzB
	ry7K4Xz7msEcePvtfdyC4OU6JATR6nNKXm2W8++MKbHSJumZKoIggdibkXeOrc35fkkWrU
	t7p06Ze4bZQ3NUQvZmAIOQWQG+13SQa4KYQJWAlvaD4F1CcJ71eTKoav+zN7VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066423;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sdfxiP8R7Woq/j6ze/KAEvqml5GzyHXmfFGcOQq4Hro=;
	b=Pbs5uaaVstCv/i/JffdyKzW1u6fP2hCUfONGy6vXVTHMGXBBM7hQ2nzEZmzZCrehMyAhQs
	A10sow9iG7Om9VDg==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Move lockdep_assert_locked() under
 #ifdef CONFIG_PROVE_LOCKING
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241202193445.769567-1-andriy.shevchenko@linux.intel.com>
References: <20241202193445.769567-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506642297.399.11623936787357213206.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3430600925859be3c8588b8220173758c7860e8c
Gitweb:        https://git.kernel.org/tip/3430600925859be3c8588b8220173758c7860e8c
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Mon, 02 Dec 2024 21:34:45 +02:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Thu, 19 Dec 2024 14:04:03 -08:00

lockdep: Move lockdep_assert_locked() under #ifdef CONFIG_PROVE_LOCKING

When lockdep_assert_locked() is unused, it prevents kernel builds
with clang, `make W=1` and CONFIG_WERROR=y, CONFIG_LOCKDEP=y and
CONFIG_PROVE_LOCKING=n:

  kernel/locking/lockdep.c:160:20: error: unused function 'lockdep_assert_locked' [-Werror,-Wunused-function]

Fix this by moving it under the respective ifdeffery.

See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build").

[Boqun: add more config information of the error]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20241202193445.769567-1-andriy.shevchenko@linux.intel.com
---
 kernel/locking/lockdep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index fe04a21..29acd23 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -157,10 +157,12 @@ static inline void lockdep_unlock(void)
 	__this_cpu_dec(lockdep_recursion);
 }
 
+#ifdef CONFIG_PROVE_LOCKING
 static inline bool lockdep_assert_locked(void)
 {
 	return DEBUG_LOCKS_WARN_ON(__owner != current);
 }
+#endif
 
 static struct task_struct *lockdep_selftest_task_struct;
 

