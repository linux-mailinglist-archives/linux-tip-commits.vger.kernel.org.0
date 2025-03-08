Return-Path: <linux-tip-commits+bounces-4063-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1ACA5768F
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 01:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D78189C5F9
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 00:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1414FC2FB;
	Sat,  8 Mar 2025 00:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fmCSIsY7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Pg+zjtM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9833C1F;
	Sat,  8 Mar 2025 00:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392489; cv=none; b=aKPgPfz3V6opL2AlkA+Lxow1hUGLY5emgJHa2Y9sGN+xsabVHDkTv331kU3s+67hBhxDK5rIl7sv3ZOfsBwuUFqZ/g0rST1/ulmPTN/IAtt8IhTqc8WA5dzCKIp9WBR0SAfUSQ7E3xTo70XRhHMEeK0j2lmlABWvtPqyBhv8C44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392489; c=relaxed/simple;
	bh=jOGjfftvjeBuDw9ZvbacrdqXQVYHDsf7ZGAP0BXNMQw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bH7aX2elfsD/Hr1ftAjnqNHTZwoHjWp5RGUZiqQZ1eGTi9kGAabdZbOG2NN2RPDsUow5tuFPJP+zqljNCxDgelIsjkNx9drUODtZpXhPllb+L/XyZmfRYa3VW4LwRn2p/qIOjk3H67r2/dbhPSZDoMsEPudvY9Em7jI3X0jae9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fmCSIsY7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Pg+zjtM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 00:08:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741392484;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tRP4kIiNc9biGBqpqxZ+pZ3/SjPPrTzesDvbfuzuq14=;
	b=fmCSIsY7+65ykb942jEl3mwHC1SSGWypl2pCgKbtaG584QZK+/hqrSiSg9gMKrOU36fWb4
	I5p7usP2OgNd1ABhFf7AOxcZ7y5/AtWlVo3tw6uFcXBttQVxNtVF10MSYq1PFEsU6MFkOV
	hQmQL7nWqobB+KjL5mX1/kJYyybHzmQOjlgUqR+sw14HG1kqPi5WvsanbO7MhOOxDyYsyH
	7TWvZw2Gcn38SfeUoaQDNHpYicp/wheeT+W7C4ylTU1f9g7yTQ8X4CeqDiDgiBKEjwhWXc
	MAYjAB8HMLyUyaJ33KN3UnptLHjOMeYYxOCEIzo61HqoZ2tTWFMPEuwm4D8lIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741392484;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tRP4kIiNc9biGBqpqxZ+pZ3/SjPPrTzesDvbfuzuq14=;
	b=1Pg+zjtMfw5IfrlLziiSxtIyRNFr1dcfNdB+G0G1dv6m5AZfkn0AeeiCfJudAHGyrPGrOa
	0BmmddFqk/1yBdBQ==
From: "tip-bot2 for Alice Ryhl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: Add accessor for the lock behind a
 given guard
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, Fiona Behrens <me@kloenk.dev>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250307232717.1759087-8-boqun.feng@gmail.com>
References: <20250307232717.1759087-8-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174139248373.14745.16712674726296603783.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8f65291dae0e75941cf76e427088e5612c4d692e
Gitweb:        https://git.kernel.org/tip/8f65291dae0e75941cf76e427088e5612c4d692e
Author:        Alice Ryhl <aliceryhl@google.com>
AuthorDate:    Fri, 07 Mar 2025 15:26:57 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 08 Mar 2025 00:55:04 +01:00

rust: sync: Add accessor for the lock behind a given guard

In order to assert a particular `Guard` is associated with a particular
`Lock`, add an accessor to obtain a reference to the underlying `Lock`
of a `Guard`.

Binder needs this assertion to ensure unsafe list operations are done
with the correct lock held.

[Boqun: Capitalize the title and reword the commit log]

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Link: https://lore.kernel.org/r/20250205-guard-get-lock-v2-1-ba32a8c1d5b7@google.com
Link: https://lore.kernel.org/r/20250307232717.1759087-8-boqun.feng@gmail.com
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

