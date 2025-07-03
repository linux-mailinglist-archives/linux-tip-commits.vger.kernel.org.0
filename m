Return-Path: <linux-tip-commits+bounces-5981-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A74AF6D17
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 10:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1C3523C78
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 08:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D732D320E;
	Thu,  3 Jul 2025 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z6O/Q2ZM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h2Duiw1M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A392D238A;
	Thu,  3 Jul 2025 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751531775; cv=none; b=E3avbN7gSZp4B171DwltjctOFsb+PkG4kSkRrmuEMta09D/c5gX8ZXGvCATd1moQXowcQQLwt/H7wV27995KB0eNTuLxhXxTdKaocqXd8N/Y+tsimAHAxNZpBW4G0MxtoO8dnwCdze6iDyyCB8BTO8kfox6aC3wtreB9qVKqEto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751531775; c=relaxed/simple;
	bh=JsW0YjUH/Jg+tw0MBFMQCkKuyl6YaJQd18iPLYGl+qo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XHGcuq2ywHwgw6PPG6BjwmYZ3i4QHAGEqvsWASsoXxB3K+AAQVk0DCyxfuzGMIbzM2BjzaaxiWyYvlGfnh7tJw3F0x4YgfqA9RDVBEdQSinmq45bqxjdiKknW089Jkipv77LcMYLoBVqHXCxWYHTR9kjcrXX3ME1x8PGJtXaoME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z6O/Q2ZM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h2Duiw1M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Jul 2025 08:36:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751531772;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7XTBkCT6PX4mD6QphuppEoUgoD9/CzZoxeu+23Cszc=;
	b=z6O/Q2ZMz9LXdSgBSRAPRE/nx6LnJoyiz84zJORakTNA6zqtOj+JeFvkV/H77j7Fys6S3f
	qbeStnXfBX2Flj4Z3n8C1UYG1MHC0p3vhzjAVt3cpqdp7tQma6nxcY8WM9xHbMibUQoerY
	yLOLUYVOAqEh553wfTLSdwhfJKs41tBDs9/yw5aGsvbmjPjw7C4uQ2fO7y9zled9GLj38v
	L5pnm16TbiQC0eZtqaJiGo24NKco2O+7qg+1ohTd1MPkytCP44eLV8HG/gjTsefF03AAi+
	T/2parANIb2mJNki/6OS25uD8nTYu/jPT57gM3/bZ+OQR1rFMEo2A3YLPLXfvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751531772;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7XTBkCT6PX4mD6QphuppEoUgoD9/CzZoxeu+23Cszc=;
	b=h2Duiw1MAKKkzKqU/ivY52214F5a55lEBW5Pud2aBJOrRaNQAHZhHMrnHTV4/WwsR99Ou4
	I9dee/xNrLKApWDw==
From: "tip-bot2 for Kunwu Chan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rust: sync: Mark CondVar::notify_*() inline
Cc: Alice Ryhl <aliceryhl@google.com>, Grace Deng <Grace.Deng006@Gmail.com>,
 Kunwu Chan <kunwu.chan@hotmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324061835.1693125-1-kunwu.chan@linux.dev>
References: <20250324061835.1693125-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175153177121.406.17192778606361617054.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3f9ebeba9878679bb43ee2db7d50a4691f55e3a5
Gitweb:        https://git.kernel.org/tip/3f9ebeba9878679bb43ee2db7d50a4691f55e3a5
Author:        Kunwu Chan <kunwu.chan@hotmail.com>
AuthorDate:    Mon, 24 Mar 2025 14:18:34 +08:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Tue, 24 Jun 2025 10:23:48 -07:00

rust: sync: Mark CondVar::notify_*() inline

When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
with ARCH=arm64, the following symbols are generated:

$nm vmlinux | grep ' _R'.*CondVar | rustfilt
... T <kernel::sync::condvar::CondVar>::notify_all
... T <kernel::sync::condvar::CondVar>::notify_one
... T <kernel::sync::condvar::CondVar>::notify_sync
...

These notify_*() symbols are trivial wrappers around the C functions
__wake_up() and __wake_up_sync(). It doesn't make sense to go through
a trivial wrapper for these functions, so mark them inline.

[boqun: Reword the commit title for consistency and reformat the commit
log.]

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://github.com/Rust-for-Linux/linux/issues/1145
Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250324061835.1693125-1-kunwu.chan@linux.dev
---
 rust/kernel/sync/condvar.rs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index caebf03..c6ec642 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -216,6 +216,7 @@ impl CondVar {
     /// This method behaves like `notify_one`, except that it hints to the scheduler that the
     /// current thread is about to go to sleep, so it should schedule the target thread on the same
     /// CPU.
+    #[inline]
     pub fn notify_sync(&self) {
         // SAFETY: `wait_queue_head` points to valid memory.
         unsafe { bindings::__wake_up_sync(self.wait_queue_head.get(), TASK_NORMAL) };
@@ -225,6 +226,7 @@ impl CondVar {
     ///
     /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost
     /// completely (as opposed to automatically waking up the next waiter).
+    #[inline]
     pub fn notify_one(&self) {
         self.notify(1);
     }
@@ -233,6 +235,7 @@ impl CondVar {
     ///
     /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost
     /// completely (as opposed to automatically waking up the next waiter).
+    #[inline]
     pub fn notify_all(&self) {
         self.notify(0);
     }

