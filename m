Return-Path: <linux-tip-commits+bounces-5980-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C14A4AF6D15
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 10:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D931C46E2A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 08:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01312D23A8;
	Thu,  3 Jul 2025 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hygIXVqq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zpfwl63/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140D62D12F1;
	Thu,  3 Jul 2025 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751531774; cv=none; b=a6wBI/mTQxD74e1mJ6MZpEweCm6Klro0zBZus6eJjjOoFR/hsgzQx+s6i7kUXEQQs9eHI+yI16DvvNaZ5+OpRvF9tcshekGTcLngPCiWb6eHExpQsyG2tdU23Afc6CLhy6mps19X7cTk8u6MGxulUFLL+zpoevRF5aZLpPAEUgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751531774; c=relaxed/simple;
	bh=Lry5ZTUuxHBbR1K2DZ56GAXTApxJ/kxtNdbu2Vbp0S8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Gj0LFVucu9uVxY1WF+LuD8/f6OJPx6Mv4z9B4tx2rcyWXQOngyfMjKqFS81tVK8RrkHXLoyPqe/rwnMQ1G3iKdpc3Hhf38mOHBZb4vuBhvGz02/Xp6O2KylFDli18mw91QhGnsEAlpXgvHa/iaV+KwhtNxVHL3gbwdv1Coepiqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hygIXVqq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zpfwl63/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Jul 2025 08:36:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751531771;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcSBf4oJr7a9VtOkrIASlO3Yf47qE2qfocMt8sJPn7o=;
	b=hygIXVqqkb/MGYLfsBFUdSU30zwJJdpIbJTQGTCPmy4RV0dYjP86snu1ntQUy85t7v4k6t
	DKi90iL9+y5vsSVLKrEqB4CS+efzkSvhwg35RwkTcP9lP2qwNm9a7pChlzq2JQRSr8iMzP
	mcraavuMEXozAblRsoV1wYwLBUkEdqr/G7uQU14f8qEf6jKUPOPIXHDT0uTE6sm+F/QMSJ
	4CW7CWTOn6YWB5zH8HKkM1qY2iz7JGrtNy/PRmOgYki96B90rY65DcBf3hn+PaswBSyiG1
	G4aIRTKC+q3bxHL1ZfwxCxe4qLtQcKRtiK5BxLyWH3g5qfr8ZO/gsdfVpxGWAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751531771;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcSBf4oJr7a9VtOkrIASlO3Yf47qE2qfocMt8sJPn7o=;
	b=Zpfwl63/ZtmXRZemfk4OY8myvKeQSErRTNV1nPr+Q1JNG3jr3UW4cWvjg/Qc9f/l9XknxE
	t8ohMBarL5u5h8BA==
From: "tip-bot2 for Kunwu Chan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rust: sync: Mark PollCondVar::drop() inline
Cc: Alice Ryhl <aliceryhl@google.com>, Grace Deng <Grace.Deng006@Gmail.com>,
 Kunwu Chan <kunwu.chan@hotmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250317025205.2366518-1-kunwu.chan@linux.dev>
References: <20250317025205.2366518-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175153177030.406.10410426934366776743.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     11867144ff81ab98f4b11c99716c3e8b714b8755
Gitweb:        https://git.kernel.org/tip/11867144ff81ab98f4b11c99716c3e8b714b8755
Author:        Kunwu Chan <kunwu.chan@hotmail.com>
AuthorDate:    Mon, 17 Mar 2025 10:52:05 +08:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Tue, 24 Jun 2025 10:23:48 -07:00

rust: sync: Mark PollCondVar::drop() inline

When building the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
with ARCH=arm64, the following symbols are generated:

$nm vmlinux | grep ' _R'.*PollCondVar  | rustfilt
... T <kernel::sync::poll::PollCondVar as kernel::init::PinnedDrop>::drop
...

This Rust symbol is trivial wrappers around the C functions
__wake_up_pollfree() and synchronize_rcu(). It doesn't make sense to go
through a trivial wrapper for its functions, so mark it inline.

[boqun: Reword the commit title and re-format the commit log per tip
tree's requirement, remove unnecessary information from "nm vmlinux"
result.]

Link: https://github.com/Rust-for-Linux/linux/issues/1145
Suggested-by: Alice Ryhl <aliceryhl@google.com>
Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250317025205.2366518-1-kunwu.chan@linux.dev
---
 rust/kernel/sync/poll.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
index d7e6e59..7b973d7 100644
--- a/rust/kernel/sync/poll.rs
+++ b/rust/kernel/sync/poll.rs
@@ -107,6 +107,7 @@ impl Deref for PollCondVar {
 
 #[pinned_drop]
 impl PinnedDrop for PollCondVar {
+    #[inline]
     fn drop(self: Pin<&mut Self>) {
         // Clear anything registered using `register_wait`.
         //

