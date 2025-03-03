Return-Path: <linux-tip-commits+bounces-3808-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D6AA4CB50
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386091892CC0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 18:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2A323314A;
	Mon,  3 Mar 2025 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iu0Q0Gv4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z1ePmIrP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0490622DFBA;
	Mon,  3 Mar 2025 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027927; cv=none; b=UoHP5YFM2GnIiWHIYEcVvf/2CjtjXrVellY3t19njR4ahWyJg/iCbDOKtCnCNgwg9HDLTv6A0odRtSv3Omp1G2tw53rf7dqiB1rIKd8PFpwQWbVq6XXMSLabm4FxCr9n/chlqsa2Fk7nj2rHMPk3e0uqydmj0KVgvuIHLTaKh38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027927; c=relaxed/simple;
	bh=yP2bMXboyZlw+VJghPvpp91VgNgud5+Lfm2lz/M2D6U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rD4Ii86lNi+vE7OQdmHukRNvEFr1bAxiHj0OCm5FY0+3MotXw+mc/9q/1ii/yHEpLcnVYgWnGhEiFk9NK2vfWgDTxiGa8u5TAn5T3es+R2Q5wtgn9Hf+ybLnB2qwxtDgiUbx6Q5tLW3lT3B9sXmFkNzwPRygkwrhkCnfK3X5j2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iu0Q0Gv4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z1ePmIrP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 18:51:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741027916;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TwwtMpxw4BLY6c99GlGQCdGrlJYdC/DdIBf9ypEELhE=;
	b=iu0Q0Gv4iDel+CvQKmcWTvYDOzeGZ/+5B5K9lw9CMe64d8lJVUsrYPMg7aujQfPz2u4VnU
	6QgaYU5emSz5+7/MD4mnN/nTPJhh8eAJ3K3A5VfK9MN5g1MNGeH+eRfpviTdadFS2QmCdD
	Y3m4ddlzQi+tABoc7oTYBen1VikCbD6tiDsxaSvLIqOESe/IWfkxnLgESArWqL3bN8MGHO
	k1hLQddlkMQZo3WelQJuxMnomNGKaKHFry/xr/phSuPkOq6YBw0Zcmsr85oDiHY1541Jc2
	EMB5hkeAerM2G9cTaW2ELi1fbYlVm0h98HMEi94ht9/4bEbOEz68vUOzd5oPbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741027916;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TwwtMpxw4BLY6c99GlGQCdGrlJYdC/DdIBf9ypEELhE=;
	b=z1ePmIrPcFC050ivsnubThWYNRge2yHwG32NXWdyqLqi+ni8M4h+gpVVqhoWGQj2zqdbHT
	cvjICJjjfZLHqrDg==
From: "tip-bot2 for Alice Ryhl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: Add accessor for the lock behind a
 given guard
Cc: Alice Ryhl <aliceryhl@google.com>, Fiona Behrens <me@kloenk.dev>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250205-guard-get-lock-v2-1-ba32a8c1d5b7@google.com>
References: <20250205-guard-get-lock-v2-1-ba32a8c1d5b7@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102791612.14745.8505844030900098070.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     36dbde71fcece19699cef0d01bd2123a6d3142f4
Gitweb:        https://git.kernel.org/tip/36dbde71fcece19699cef0d01bd2123a6d3142f4
Author:        Alice Ryhl <aliceryhl@google.com>
AuthorDate:    Wed, 05 Feb 2025 10:54:50 
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Sun, 23 Feb 2025 18:24:46 -08:00

rust: sync: Add accessor for the lock behind a given guard

In order to assert a particular `Guard` is associated with a particular
`Lock`, add an accessor to obtain a reference to the underlying `Lock`
of a `Guard`.

Binder needs this assertion to ensure unsafe list operations are done
with the correct lock held.

[Boqun: Capitalize the title and reword the commit log]

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250205-guard-get-lock-v2-1-ba32a8c1d5b7@google.com
---
 rust/kernel/sync/lock.rs | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index eb80048..8e7e6d5 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -199,7 +199,12 @@ pub struct Guard<'a, T: ?Sized, B: Backend> {
 // SAFETY: `Guard` is sync when the data protected by the lock is also sync.
 unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
 
-impl<T: ?Sized, B: Backend> Guard<'_, T, B> {
+impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
+    /// Returns the lock that this guard originates from.
+    pub fn lock_ref(&self) -> &'a Lock<T, B> {
+        self.lock
+    }
+
     pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
         // SAFETY: The caller owns the lock, so it is safe to unlock it.
         unsafe { B::unlock(self.lock.state.get(), &self.state) };

